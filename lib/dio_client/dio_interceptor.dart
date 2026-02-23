import 'package:dio/dio.dart';
import 'package:get/get.dart' as getP;
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
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
    if (response.requestOptions.path != (NetworkStrings.API_BASE_URL + "saveMessage")) return super.onResponse(response, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    if (dioError.requestOptions.path != (NetworkStrings.API_BASE_URL + "saveMessage")) ;

    Response? response = dioError.response;

    String? errorMessage = _getErrorMessage(response: response);

    ToastMessage(toastmsg: errorMessage ?? dioError.message.toString());

    // when status code= 401

    if (dioError.response?.statusCode == NetworkStrings.UNAUTHORIZED_USER_CODE) {
      _invalidAuthorization();
    }
    if (dioError.response?.statusCode == NetworkStrings.NOT_FOUND_CODE) {
      // print("aqib error");

      // CoreController.i.slotsModel.refresh();

      stopLoader();
      // _invalidAuthorization();
    }
    if (dioError.response?.statusCode == NetworkStrings.SERVER_NOT_FOUND_CODE || dioError.response?.statusCode == NetworkStrings.BAD_REQUEST_CODE) {
      // _invalidAuthorization();
      stopLoader();
    }
    return null;
  }

  void _invalidAuthorization() {
    stopLoader();

    SharedPreference().clearSessionOnly();

    getP.Get.offAllNamed(AppRoutes.loginScreenRoute);
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
