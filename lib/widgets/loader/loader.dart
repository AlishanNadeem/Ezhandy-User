import 'package:bot_toast/bot_toast.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ezhandy_user/utils/app_colors.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SpinKitFadingCircle(
      duration: Duration(milliseconds: 1000),
      color: AppColors.black,
      size: 50.0,
    );
  }
}
showLoader() {
  BotToast.showCustomLoading(toastBuilder: (close) {
    return Loader();
  });
}
stopLoader() {
  BotToast.closeAllLoading();
}


class TermsLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SpinKitCircle(
      duration: Duration(milliseconds: 1000),
      color: AppColors.black,
      size: 50.0,
    );
  }
}


