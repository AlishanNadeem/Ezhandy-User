import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {
  static CreatePostController get i => Get.find();

  RxBool isLoading = false.obs;

  String _basename(String path) {
    final normalized = path.replaceAll('\\', '/');
    final i = normalized.lastIndexOf('/');
    return i >= 0 ? normalized.substring(i + 1) : path;
  }

  /// Creates a community post. Returns whether the API reported success.
  Future<bool> createPost({
    required String description,
    File? image,
  }) async {
    if (isLoading.value) return false;
    isLoading.value = true;

    bool? outcome;

    try {
      final formData = dio.FormData.fromMap({
        'description': description.trim(),
        if (image != null)
          'image': await dio.MultipartFile.fromFile(
            image.path,
            filename: _basename(image.path),
          ),
      });

      final response = await DioClient().postRequest(
        endPoint: NetworkStrings.communityPostsEndpoint,
        data: formData,
        isHeaderRequire: true,
      );

      if (response == null) {
        return false;
      }

      await DioClient().validateResponse(
        response: response,
        responseListener: _CreatePostListener(
          onSuccessCallback: (_) => outcome = true,
          onFailureCallback: (_) => outcome = false,
        ),
      );
    } finally {
      isLoading.value = false;
    }

    return outcome ?? false;
  }

  /// Updates a community post. Returns whether the API reported success.
  Future<bool> updatePost({
    required String postId,
    required String description,
    File? image,
  }) async {
    if (isLoading.value) return false;
    if (postId.trim().isEmpty) return false;

    isLoading.value = true;
    bool? outcome;

    try {
      final formData = dio.FormData.fromMap({
        'description': description.trim(),
        if (image != null)
          'image': await dio.MultipartFile.fromFile(
            image.path,
            filename: _basename(image.path),
          ),
      });

      final response = await DioClient().patchRequest(
        endPoint: NetworkStrings.communityPostById(postId.trim()),
        data: formData,
        isHeaderRequire: true,
      );

      if (response == null) {
        return false;
      }

      await DioClient().validateResponse(
        response: response,
        responseListener: _CreatePostListener(
          onSuccessCallback: (_) => outcome = true,
          onFailureCallback: (_) => outcome = false,
        ),
      );
    } finally {
      isLoading.value = false;
    }

    return outcome ?? false;
  }
}

class _CreatePostListener extends ResponseListener {
  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  _CreatePostListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}
