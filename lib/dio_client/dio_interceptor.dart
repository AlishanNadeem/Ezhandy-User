import 'package:dio/dio.dart';
import 'package:get/get.dart' as getP;
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/session_clear.dart';
import 'package:ezhandy_user/widgets/loader/loader.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/toast.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path != (NetworkStrings.API_BASE_URL + "saveMessage"))
      // utiles.showDialogs(
      //   barrierDismissible: false,
      //   widget: Center(
      //     child: CircularProgressIndicator(color: App_Colors.primaryColor),
      //   ),
      // );
      return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path !=
        (NetworkStrings.API_BASE_URL + "saveMessage")) {
      return super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    if (dioError.requestOptions.path !=
        (NetworkStrings.API_BASE_URL + "saveMessage")) ;

    Response? response = dioError.response;

    String? errorMessage = _getErrorMessage(response: response);

    ToastMessage(toastmsg: errorMessage ?? dioError.message.toString());

    // when status code= 401 (skip public auth — wrong login creds also return 401)
    if (dioError.response?.statusCode == NetworkStrings.UNAUTHORIZED_USER_CODE) {
      if (_isPublicAuthEndpoint(dioError.requestOptions.path)) {
        stopLoader();
      } else {
        _invalidAuthorization();
      }
    }
    if (dioError.response?.statusCode == NetworkStrings.NOT_FOUND_CODE) {
      // print("aqib error");

      // CoreController.i.slotsModel.refresh();

      stopLoader();
      // _invalidAuthorization();
    }
    if (dioError.response?.statusCode ==
            NetworkStrings.SERVER_NOT_FOUND_CODE ||
        dioError.response?.statusCode == NetworkStrings.BAD_REQUEST_CODE) {
      // _invalidAuthorization();
      stopLoader();
    }
    return null;
  }

  void _invalidAuthorization() async {
    stopLoader();

    await SessionClear.clearApiCaches();

    getP.Get.offAllNamed(AppRoutes.loginScreenRoute);
  }

  /// Public auth calls that may return 401 for bad input (not expired session).
  bool _isPublicAuthEndpoint(String path) {
    final segments = Uri.tryParse(path)?.pathSegments;
    final segment =
        (segments == null || segments.isEmpty) ? path : segments.last;
    const publicAuth = {
      NetworkStrings.signinEndpoint,
      NetworkStrings.signupEndpoint,
      NetworkStrings.forgotPassEndpoint,
      NetworkStrings.verificationEmailEndpoint,
      NetworkStrings.verificationResetPasswordEndpoint,
      NetworkStrings.resendCodeEndpoint,
      NetworkStrings.resetPassEndpoint,
    };
    return publicAuth.contains(segment);
  }

  String? _getErrorMessage({Response? response}) {
    String? errorMessage;

    if (response?.data is Map<String, dynamic>) {
      // Checking that API is returning JSON Object instead of crashing HTML
      if (response?.data != null) {
        print("++++++++++++++++++++++++++++++++++++++++++++++++");
        print(response?.data["message"]);
        print("++++++++++++++++++++++++++++++++++++++++++++++++");
        if (response?.data.containsKey("message")) {
          errorMessage = response?.data["message"];

          print("++++++++++++++++++++++++++++++++++++++++++++++++");
          print(errorMessage);
          print("++++++++++++++++++++++++++++++++++++++++++++++++");

          stopLoader();
        }
      } else {
        errorMessage = response?.statusMessage;
        stopLoader();
      }
    }
    return errorMessage;
  }
}
