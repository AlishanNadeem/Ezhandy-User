import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get i => Get.find();

  RxBool isLoading = false.obs;
  RxBool categoriesLoading = false.obs;
  RxList categoryList = [].obs;
  String? selectedCategoryId;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() async {
    categoriesLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: "categories",
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: _Listener(
        onSuccessCallback: (response) {
          print("✅ Categories: $response");
          categoryList.value = response?['data'] ?? [];
          categoriesLoading.value = false;
        },
        onFailureCallback: (response) {
          print("❌ Categories Failed: $response");
          categoriesLoading.value = false;
        },
      ),
    );
    categoriesLoading.value = false;
  }

  Future<void> createProduct({
    required String title,
    required String description,
    required String price,
    File? image,
    VoidCallback? onSuccess,
  }) async {
    if (selectedCategoryId == null) {
      print("❌ No category selected");
      return;
    }

    isLoading.value = true;

    final formData = dio.FormData.fromMap({
      "title": title,
      "description": description,
      "price": double.tryParse(price) ?? 0.0,
      "isActive": true,
      "categoryId": selectedCategoryId,
      if (image != null)
        "image": await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
    });

    print("📦 CREATE PRODUCT BODY: title=$title, price=$price, categoryId=$selectedCategoryId");

    try {
      final response = await DioClient().postRequest(
        endPoint: NetworkStrings.productsEndpoint,
        data: formData,
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: _Listener(
          onSuccessCallback: (response) {
            print("✅ Product Created: $response");
            onSuccess?.call();
          },
          onFailureCallback: (response) {
            print("❌ Product Create Failed: $response");
          },
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
} // ← END of ProductController

// ← OUTSIDE the class
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