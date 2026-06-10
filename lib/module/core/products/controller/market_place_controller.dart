import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/local_search_helper.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class MarketPlaceController extends GetxController {
  static MarketPlaceController get i => Get.find();

  RxList productsList = [].obs;
  RxList myProductsList = [].obs;
  RxBool productsLoading = false.obs;
  RxBool myProductsLoading = false.obs;
  RxBool deleteLoading = false.obs;
  final RxString productsSearchQuery = ''.obs;
  final RxString myProductsSearchQuery = ''.obs;

  List<dynamic> get filteredProductsList => filterMapsByTitleKey(
        items: productsList,
        query: productsSearchQuery.value,
        titleKey: 'title',
      );

  List<dynamic> get filteredMyProductsList => filterMapsByTitleKey(
        items: myProductsList,
        query: myProductsSearchQuery.value,
        titleKey: 'title',
      );

  void updateProductsSearch(String value) => productsSearchQuery.value = value;

  void updateMyProductsSearch(String value) => myProductsSearchQuery.value = value;

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getMyProducts();
  }

  Future<void> getProducts() async {
    productsLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.productsEndpoint,
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: _MarketPlaceListener(
          onSuccessCallback: (response) {
            productsList.value = response?['data'] ?? [];
          },
          onFailureCallback: (_) {
            productsList.clear();
          },
        ),
      );
    } finally {
      productsLoading.value = false;
    }
  }

  Future<void> getMyProducts() async {
    final ownerId =
        AuthController.i.appUser.value.data?.userModel?.sub?.trim() ?? '';
    if (ownerId.isEmpty) {
      myProductsList.clear();
      return;
    }

    myProductsLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.productsByOwner(ownerId),
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: _MarketPlaceListener(
          onSuccessCallback: (response) {
            myProductsList.value = response?['data'] ?? [];
          },
          onFailureCallback: (_) {
            myProductsList.clear();
          },
        ),
      );
    } finally {
      myProductsLoading.value = false;
    }
  }

  // ✅ Delete Product
  void deleteProduct({
    required String productId,
    required Function onSuccess,
  }) async {
    deleteLoading.value = true;

    final response = await DioClient().deleteRequest(
      endPoint: "products/$productId",
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: _MarketPlaceListener(
        onSuccessCallback: (response) {
          print("✅ Product Deleted: $response");
          deleteLoading.value = false;
          productsList.removeWhere((p) => p['id'] == productId);
          myProductsList.removeWhere((p) => p['id'] == productId);
          onSuccess();
        },
        onFailureCallback: (response) {
          print("❌ Delete Failed: $response");
          deleteLoading.value = false;
        },
      ),
    );
    deleteLoading.value = false;
  }
}

class _MarketPlaceListener extends ResponseListener {
  final Function(dynamic) onSuccessCallback;
  final Function(dynamic) onFailureCallback;

  _MarketPlaceListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}