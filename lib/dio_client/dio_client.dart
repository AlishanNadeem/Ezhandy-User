import 'dart:async';
import 'dart:developer';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:ezhandy_user/dio_client/dio_interceptor.dart';
import 'package:ezhandy_user/services/connectivity_manager.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
import 'package:ezhandy_user/widgets/loader/loader.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/toast.dart';

class DioClient {
  // DioClient({this.loading=false});
  // bool? loading;

  static Dio? _dio;
  static DioClient? _dioClient;

  static ConnectivityManager? _connectivityManager;

  static CancelToken? _cancelToken;

  DioClient._createInstance();

  factory DioClient() {
    // factory with constructor, return some value
    if (_dioClient == null) {
      _dioClient = DioClient._createInstance(); // This is executed only once, singleton object

      _getDio();

      _connectivityManager = ConnectivityManager();

      _cancelToken ??= CancelToken();
    }
    return _dioClient!;
  }

  static void _getDio() {
    _dio ??= Dio();

    _dio?.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      error: true,
    ));

    _dio?.interceptors.add(DioInterceptors());
  }

  ///-------------------- Get Request -------------------- ///

  Future<Response?> getRequest({
    String? endPoint,
    Map<String, dynamic>? queryParameters,
    ResponseListener? responseListener,
    bool? isHeaderRequire,
    bool isLoader = false,
  }) async {
    Response? response;

    if (await _connectivityManager!.isInternetConnected()) {
      if (isLoader) {
        showLoader();
      }
      // EasyLoading.instance.userInteractions = false;
      // EasyLoading.show(statusCode: 'Please wait...', dismissOnTap: true);

      try {
        response = await _dio!.get(NetworkStrings.API_BASE_URL + endPoint!,
            queryParameters: queryParameters,
            cancelToken: _cancelToken,
            options: Options(
              headers: _setHeader(isHeaderRequire: isHeaderRequire),
              sendTimeout: Duration(microseconds: 20000),
            ));

        // log("GET REQUEST API: $response" );
      } on DioError catch (e) {
        _onTimeOut(message: e.message, responseListener: responseListener);
        print("$endPoint TimeOut: " + e.message.toString());
        print("$endPoint RESPONSEsssssss: " + e.response.toString());
        stopLoader();
      }
    } else {
      _noInternetConnection(responseListener: responseListener);
    }
    stopLoader();
    return response;
  }

  ///-------------------- Post Request -------------------- ///
  Future<Response?> postRequest({
    String endPoint = "",
    String? baseurl,
    dynamic data,
    ResponseListener? responseListener,
    bool? isHeaderRequire,
    bool isLoader = true,
  }) async {
    Response? response;
    if (await _connectivityManager!.isInternetConnected()) {
      if (isLoader) {
        showLoader();
      }
// band loader
      try {
        response = await _dio!.post(baseurl ?? NetworkStrings.API_BASE_URL + endPoint,
            data: data,
            cancelToken: _cancelToken,
            options: Options(
                headers: _setHeader(isHeaderRequire: isHeaderRequire),
                sendTimeout: Duration(milliseconds: 500000),
                receiveTimeout: Duration(milliseconds: 500000)));
      } on DioException catch (e) {
        print("kbdhwhdbwkd  wkhdkw  dwkhbw");
        print(e);
        _onTimeOut(message: e.message, responseListener: responseListener);
        stopLoader();
      }
    } else {
      _noInternetConnection(responseListener: responseListener);
    }
    stopLoader();
    return response;
  }

  ///-------------------- Put Request -------------------- ///
  Future<Response?> putRequest({
    String endPoint = "",
    String? baseurl,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    ResponseListener? responseListener,
    bool? isHeaderRequire,
    bool isLoader = true,
  }) async {
    Response? response;
    if (await _connectivityManager!.isInternetConnected()) {
      if (isLoader) {
        showLoader();
      }

      try {
        response = await _dio!.put(baseurl ?? NetworkStrings.API_BASE_URL + endPoint,
            data: data,
            queryParameters: queryParameters,
            cancelToken: _cancelToken,
            options: Options(
                headers: _setHeader(isHeaderRequire: isHeaderRequire),
                sendTimeout: Duration(milliseconds: 500000),
                receiveTimeout: Duration(milliseconds: 500000)));
      } on DioException catch (e) {
        print("kbdhwhdbwkd  wkhdkw  dwkhbw");
        print(e);
        _onTimeOut(message: e.message, responseListener: responseListener);
        stopLoader();
      }
    } else {
      _noInternetConnection(responseListener: responseListener);
    }
    stopLoader();
    return response;
  }
  ///-------------------- Put Request -------------------- ///
  Future<Response?> patchRequest({
    String endPoint = "",
    String? baseurl,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    ResponseListener? responseListener,
    bool? isHeaderRequire,
    bool isLoader = true,
  }) async {
    Response? response;
    if (await _connectivityManager!.isInternetConnected()) {
      if (isLoader) {
        showLoader();
      }

      try {
        response = await _dio!.patch(baseurl ?? NetworkStrings.API_BASE_URL + endPoint,
            data: data,
            queryParameters: queryParameters,
            cancelToken: _cancelToken,
            options: Options(
                headers: _setHeader(isHeaderRequire: isHeaderRequire),
                sendTimeout: Duration(milliseconds: 500000),
                receiveTimeout: Duration(milliseconds: 500000)));
      } on DioException catch (e) {
        print("kbdhwhdbwkd  wkhdkw  dwkhbw");
        print(e);
        _onTimeOut(message: e.message, responseListener: responseListener);
        stopLoader();
      }
    } else {
      _noInternetConnection(responseListener: responseListener);
    }
    stopLoader();
    return response;
  }

  ///-------------------- Delete Request -------------------- ///
  Future<Response?> deleteRequest({
    String? endPoint,
    Map<String, dynamic>? queryParameters,
    ResponseListener? responseListener,
    bool? isHeaderRequire,
    bool isLoader = true,
  }) async {
    Response? response;
    if (await _connectivityManager!.isInternetConnected()) {
      if (isLoader) {
        showLoader();
      }

      try {
        response = await _dio!.delete(NetworkStrings.API_BASE_URL + endPoint!,
            queryParameters: queryParameters,
            cancelToken: _cancelToken,
            options: Options(
              headers: _setHeader(isHeaderRequire: isHeaderRequire),
              sendTimeout: Duration(microseconds: 20000),
            ));
      } on TimeoutException catch (e) {
        _onTimeOut(message: e.message, responseListener: responseListener);
        print("$endPoint TimeOut: " + e.message!);
        stopLoader();
      }
    } else {
      _noInternetConnection(responseListener: responseListener);
    }
    stopLoader();

    return response;
  }

  ///-------------------- Set Header -------------------- ///
  _setHeader({bool? isHeaderRequire}) {
    if (isHeaderRequire == true) {
      String? token = SharedPreference().getBearerToken()??AuthController.i.appUser.value.data?.accessToken;
      return {
        'Accept': NetworkStrings.ACCEPT,
        'Authorization': "Bearer $token",
      };
    } else {
      return {
        'Accept': NetworkStrings.ACCEPT,
      };
    }
  }

  ///-------------------- Validate Response -------------------- ///
  Future<void> validateResponse({
    Response? response,
    ResponseListener? responseListener,
    bool message = false,
  }) async {
    if (response != null) {
      var jsonResponse = response.data;

      if (jsonResponse != null) {
        print("sa" + response.statusCode.toString());
        print("sa1" + jsonResponse['isSuccess'].toString());
        if (jsonResponse['message'] != null && message == true) ToastMessage(toastmsg: jsonResponse['message']);
        if (response.statusCode == NetworkStrings.SUCCESS_CODE||response.statusCode == 201) {
          if (jsonResponse['isSuccess'] == NetworkStrings.API_SUCCESS_STATUS) {
            print("abc" + jsonResponse['isSuccess'].toString());
            // When Status Code is 200 and api_status is 1
            if (responseListener != null) {
              //asjad

              responseListener.onSuccess(response: jsonResponse);
            }
          } else if (jsonResponse['isSuccess'] == null) {
            if (responseListener != null) {
              responseListener.onSuccess(response: jsonResponse);
            }
          } else {
            // When Status Code is 200 and api_status is 0
            if (responseListener != null) {
              responseListener.onSuccess(response: jsonResponse);
            }
          }
        } else if (response.statusCode == NetworkStrings.NOT_FOUND_CODE) {
          if (jsonResponse['isSuccess'] == NetworkStrings.API_SUCCESS_STATUS) {
            // When Status Code is 200 and api_status is 1
            if (responseListener != null) {
              responseListener.onFailure(response: jsonResponse);
            }
          } else if (jsonResponse['isSuccess'] == null) {
            if (responseListener != null) {
              responseListener.onFailure(response: jsonResponse);
            }
          } else {
            // When Status Code is 200 and api_status is 0
            if (responseListener != null) {
              responseListener.onFailure(response: jsonResponse);
            }
          }
        } else if (response.statusCode == NetworkStrings.NOT_FOUND_CODE) {
          if (jsonResponse['isSuccess'] == NetworkStrings.API_FAILURE_STATUS) {
            print("aqib error");
            // When Status Code is 200 and api_status is 1
            if (responseListener != null) {
              responseListener.onFailure(response: jsonResponse);
            }
          }
        } else {
          // When Status Code is not 200
          if (responseListener != null) {
            responseListener.onFailure(response: jsonResponse);
          }
          log(response.statusCode.toString());
        }
      }
    }
    stopLoader();
  }

  ///-------------------- No Internet Connection -------------------- ///
  void _noInternetConnection({ResponseListener? responseListener}) {
    // Call Failure Listener
    if (responseListener != null) {
      responseListener.onFailure(response: {});
      stopLoader();
    }

    // Display Error Message
    ToastMessage(toastmsg: AppStrings.NO_INTERNET_CONNECTION);
  }

  ///-------------------- On TimeOut -------------------- ///
  void _onTimeOut({String? message, ResponseListener? responseListener}) {
    // Call Failure Listener
    if (responseListener != null) {
      responseListener.onFailure(response: {});

      stopLoader();
    }
    // Display Error Message
    ToastMessage(toastmsg: message.toString());
  }
}
