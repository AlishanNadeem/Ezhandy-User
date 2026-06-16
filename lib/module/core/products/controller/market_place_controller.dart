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
  final RxString filterCategoryId = ''.obs;
  final RxString filterCategoryName = ''.obs;
  final RxString filterMinPrice = ''.obs;
  final RxString filterMaxPrice = ''.obs;

  bool get hasActiveFilters =>
      filterCategoryId.value.isNotEmpty ||
      filterMinPrice.value.isNotEmpty ||
      filterMaxPrice.value.isNotEmpty;

  List<dynamic> get filteredProductsList => _applyProductFilters(
        filterMapsByTitleKey(
          items: productsList,
          query: productsSearchQuery.value,
          titleKey: 'title',
        ),
      );

  List<dynamic> get filteredMyProductsList => _applyProductFilters(
        filterMapsByTitleKey(
          items: myProductsList,
          query: myProductsSearchQuery.value,
          titleKey: 'title',
        ),
      );

  void updateProductsSearch(String value) => productsSearchQuery.value = value;

  void updateMyProductsSearch(String value) => myProductsSearchQuery.value = value;

  void applyFilters({
    String? categoryId,
    String? categoryName,
    String? minPrice,
    String? maxPrice,
  }) {
    filterCategoryId.value = categoryId?.trim() ?? '';
    filterCategoryName.value = categoryName?.trim() ?? '';

    var min = minPrice?.trim() ?? '';
    var max = maxPrice?.trim() ?? '';
    if (min.isNotEmpty &&
        max.isNotEmpty &&
        (double.tryParse(min) ?? 0) > (double.tryParse(max) ?? 0)) {
      final temp = min;
      min = max;
      max = temp;
    }

    filterMinPrice.value = min;
    filterMaxPrice.value = max;
  }

  void clearFilters() {
    filterCategoryId.value = '';
    filterCategoryName.value = '';
    filterMinPrice.value = '';
    filterMaxPrice.value = '';
  }

  void clearCategoryFilter() {
    filterCategoryId.value = '';
    filterCategoryName.value = '';
  }

  void clearMinPriceFilter() => filterMinPrice.value = '';

  void clearMaxPriceFilter() => filterMaxPrice.value = '';

  List<dynamic> _applyProductFilters(List<dynamic> items) {
    if (!hasActiveFilters) return items;

    final min = double.tryParse(filterMinPrice.value);
    final max = double.tryParse(filterMaxPrice.value);

    return items.where((product) {
      if (product is! Map) return false;

      if (!_matchesCategoryFilter(product)) return false;

      final price = _productPrice(product);
      if (min != null && price < min) return false;
      if (max != null && price > max) return false;

      return true;
    }).toList();
  }

  bool _matchesCategoryFilter(Map product) {
    if (filterCategoryId.value.isEmpty && filterCategoryName.value.isEmpty) {
      return true;
    }

    final productCategoryId = _productCategoryId(product);
    final productCategoryName = _productCategoryName(product);

    if (filterCategoryId.value.isNotEmpty &&
        productCategoryId.isNotEmpty &&
        productCategoryId.toLowerCase() ==
            filterCategoryId.value.toLowerCase()) {
      return true;
    }

    if (filterCategoryName.value.isNotEmpty &&
        productCategoryName.toLowerCase() ==
            filterCategoryName.value.toLowerCase()) {
      return true;
    }

    return false;
  }

  String _productCategoryId(Map product) {
    final category = product['category'];
    if (category is Map) {
      return category['id']?.toString().trim() ?? '';
    }
    return product['categoryId']?.toString().trim() ?? '';
  }

  String _productCategoryName(Map product) {
    final category = product['category'];
    if (category is Map) {
      return category['name']?.toString().trim() ?? '';
    }
    if (category != null) {
      return category.toString().trim();
    }
    return product['categoryName']?.toString().trim() ?? '';
  }

  double _productPrice(Map product) {
    final price = product['price'];
    if (price is num) return price.toDouble();
    return double.tryParse(price?.toString() ?? '') ?? 0;
  }

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