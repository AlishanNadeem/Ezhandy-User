import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class WriteReviewController extends GetxController {
  WriteReviewController({required this.providerId});

  final String providerId;
  final RxBool isSubmitting = false.obs;

  Future<bool> submitRating({
    required int rating,
    required String review,
  }) async {
    if (providerId.trim().isEmpty) return false;
    if (isSubmitting.value) return false;

    isSubmitting.value = true;
    bool? success;

    try {
      final response = await DioClient().postRequest(
        endPoint: NetworkStrings.ratingsEndpoint,
        data: <String, dynamic>{
          'providerId': providerId,
          'rating': rating,
          'review': review.trim(),
        },
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (_) => success = true,
          onFailureCallback: (_) => success = false,
        ),
        message: true,
      );
    } finally {
      isSubmitting.value = false;
    }

    return success ?? false;
  }
}
