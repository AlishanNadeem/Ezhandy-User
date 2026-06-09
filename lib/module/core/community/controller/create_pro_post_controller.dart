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
      endPoint: NetworkStrings.categoriesEndpoint,
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: _CreateProPostListener(
        onSuccessCallback: (data) {
          categories.value = data?['data'] ?? [];
          print('✅ Ask Pro categories loaded → $categories');
        },
        onFailureCallback: (data) {
          print('❌ Ask Pro categories failed → $data');
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

  static bool isUuid(String value) {
    return RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    ).hasMatch(value);
  }

  /// Submits an Ask a Pro query. Returns whether the API reported success.
  Future<bool> submitQuery({
    required String categoryId,
    required String question,
    File? image,
    File? video,
  }) async {
    if (isLoading.value) return false;

    if (!isUuid(categoryId)) {
      print('❌ Ask Pro invalid categoryId (must be UUID) → $categoryId');
      return false;
    }

    isLoading.value = true;
    bool? outcome;

    final payload = {
      'categoryId': categoryId,
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
        'categoryId': categoryId,
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
        return false;
      }

      print(
        '📥 Ask Pro query response → '
        'status=${response.statusCode}, data=${response.data}',
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: _CreateProPostListener(
          onSuccessCallback: (data) {
            print('✅ Ask Pro query success → $data');
            outcome = true;
          },
          onFailureCallback: (data) {
            print('❌ Ask Pro query failure → $data');
            outcome = false;
          },
        ),
      );
    } catch (e, stack) {
      print('❌ Ask Pro query error → $e');
      print(stack);
    } finally {
      isLoading.value = false;
    }

    return outcome ?? false;
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
