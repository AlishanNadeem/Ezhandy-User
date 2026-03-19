import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/listeners.dart';

class ResendCodeRepository extends ResponseListener {
  void resendCodeRepo({String? email}) async {
    Map<String, dynamic> rawData = {
      "email": email,
    };
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$rawData");
    var response = await DioClient().postRequest(
      endPoint:  NetworkStrings.resendCodeEndpoint,
      data: rawData,
      responseListener: this,
    );

    DioClient().validateResponse(
        response: response, responseListener: this, message: true);
  }

  @override
  void onSuccess({response}) {
    AuthController.i.countDownController.value.start();

  }
}
