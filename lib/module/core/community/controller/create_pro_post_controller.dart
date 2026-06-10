import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class CreateProPostController extends GetxController {
  static CreateProPostController get i => Get.find();

  RxBool isLoading = false.obs;
  RxBool categoriesLoading = false.obs;
  RxList categories = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    if (categoriesLoading.value) return;
    categoriesLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.serviceTypesEndpoint,
      isHeaderRequire: true,
      isLoader: false,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: _CreateProPostListener(
        onSuccessCallback: (data) {
          categories.value = data?['data'] ?? [];
          print('✅ Ask Pro service types loaded → $categories');
        },
        onFailureCallback: (data) {
          print('❌ Ask Pro service types failed → $data');
        },
      ),
    );

    categoriesLoading.value = false;
  }

  String _basename(String path) {
    final normalized = path.replaceAll('\\', '/');
    final i = normalized.lastIndexOf('/');
    return i >= 0 ? normalized.substring(i + 1) : path;
  }

  static bool _isApiSuccess(dynamic data) {
    if (data is! Map) return false;
    final status = data['isSuccess'];
    if (status == false || status == NetworkStrings.API_FAILURE_STATUS) {
      return false;
    }
    return true;
  }

  /// Submits an Ask a Pro query. Returns whether the API reported success.
  Future<bool> submitQuery({
    required String serviceTypeId,
    required String question,
    File? image,
    File? video,
  }) async {
    if (isLoading.value) return false;

    if (serviceTypeId.trim().isEmpty) {
      print('❌ Ask Pro invalid serviceTypeId → empty');
      return false;
    }

    var success = false;
    isLoading.value = true;

    final payload = {
      'serviceTypeId': serviceTypeId,
      'question': question.trim(),
      'image': image?.path,
      'video': video?.path,
    };

    print('📤 Ask Pro query payload → ${jsonEncode(payload)}');
    print(
      '📤 Ask Pro query URL → '
      '${NetworkStrings.API_BASE_URL}${NetworkStrings.askProQueryEndpoint}',
    );

    try {
      final formData = dio.FormData.fromMap({
        'serviceTypeId': serviceTypeId,
        'question': question.trim(),
        if (image != null)
          'image': await dio.MultipartFile.fromFile(
            image.path,
            filename: _basename(image.path),
          ),
        if (video != null)
          'video': await dio.MultipartFile.fromFile(
            video.path,
            filename: _basename(video.path),
          ),
      });

      print(
        '📤 Ask Pro form fields → '
        '${formData.fields.map((e) => '${e.key}=${e.value}').join(', ')}',
      );
      print(
        '📤 Ask Pro form files → '
        '${formData.files.isEmpty ? 'none' : formData.files.map((e) => '${e.key}=${e.value.filename}').join(', ')}',
      );

      final response = await DioClient().postRequest(
        endPoint: NetworkStrings.askProQueryEndpoint,
        data: formData,
        isHeaderRequire: true,
      );

      if (response == null) {
        print('❌ Ask Pro query response → null (check Dio error logs above)');
      } else {
        print(
          '📥 Ask Pro query response → '
          'status=${response.statusCode}, data=${response.data}',
        );

        await DioClient().validateResponse(
          response: response,
          responseListener: _CreateProPostListener(
            onSuccessCallback: (data) {
              success = _isApiSuccess(data);
              if (success) {
                print('✅ Ask Pro query success → $data');
              } else {
                print('❌ Ask Pro query rejected → $data');
              }
            },
            onFailureCallback: (data) {
              print('❌ Ask Pro query failure → $data');
              success = false;
            },
          ),
        );
      }
    } catch (e, stack) {
      print('❌ Ask Pro query error → $e');
      print(stack);
      success = false;
    } finally {
      isLoading.value = false;
    }

    return success;
  }
}

class _CreateProPostListener extends ResponseListener {
  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  _CreateProPostListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}
