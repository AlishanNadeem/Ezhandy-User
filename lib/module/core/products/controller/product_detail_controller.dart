import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  static ProductDetailController get i => Get.find();

  RxBool isLoading = false.obs;
  Rx<Map<String, dynamic>> product = Rx<Map<String, dynamic>>({});

  void getProductDetail({required String productId}) async {
    isLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: "products/$productId",
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: _Listener(
        onSuccessCallback: (response) {
          print("✅ Product Detail: $response");
          product.value = response?['data'] ?? {};
          isLoading.value = false;
        },
        onFailureCallback: (response) {
          print("❌ Product Detail Failed: $response");
          isLoading.value = false;
        },
      ),
    );
    isLoading.value = false;
  }
}

class _Listener extends ResponseListener {
  final Function(dynamic) onSuccessCallback;
  final Function(dynamic) onFailureCallback;

  _Listener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}