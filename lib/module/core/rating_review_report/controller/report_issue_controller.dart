import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ReportIssueController extends GetxController {
  ReportIssueController({required this.bookingId});

  final int bookingId;
  final RxBool isSubmitting = false.obs;

  bool get hasValidBookingId => bookingId > 0;

  String? get loggedInUserId {
    final id = AuthController.i.appUser.value.data?.userModel?.sub?.trim();
    if (id == null || id.isEmpty) return null;
    return id;
  }

  bool get hasValidUserId => loggedInUserId != null;

  Future<bool> submitReport({required String message}) async {
    if (!hasValidBookingId || !hasValidUserId || isSubmitting.value) {
      return false;
    }

    final text = message.trim();
    if (text.isEmpty) return false;

    isSubmitting.value = true;
    var success = false;

    try {
      final response = await DioClient().postRequest(
        endPoint: NetworkStrings.reportsEndpoint,
        isHeaderRequire: true,
        data: <String, dynamic>{
          'message': text,
          'bookingId': bookingId,
          'userId': loggedInUserId,
          'reportType': 'issue',
        },
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

    return success;
  }
}
