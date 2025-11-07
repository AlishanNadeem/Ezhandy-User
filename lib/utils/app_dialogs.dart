import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/compliance_dialog.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_reject_dialog.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/delete_and_all_dialoge.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/show_file_image_source_dialog.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/show_image_source_dialog.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/successful_dialog.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/thank_you_dialog.dart';

class AppDialogs {
  static void showToast({String? message}) {
    Fluttertoast.showToast(
      msg: message ?? "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  // Future showCustomConfirmationDialog(BuildContext context,
  //     {String? title = AppStrings.confirmationDialogTitle,
  //     String? description = AppStrings.confirmationDialogDeleteDescription,
  //     String? button1Text = AppStrings.dialogActionButtonOneText,
  //     String? button2Text = AppStrings.dialogActionButtonTwoText,
  //     Color? button1Color,
  //     Color? button2Color,
  //     Color? borderColor,
  //     Color? button1TextColor,
  //     Color? button2TextColor,
  //     Function()? onTapYes,
  //     Function()? onTapNo}) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return CustomConfirmationDialog(
  //           title: title,
  //           borderColor: borderColor,
  //           description: description,
  //           button1Text: button1Text,
  //           button2Text: button2Text,
  //           button1Color: button1Color,
  //           button2Color: button2Color,
  //           button1TextColor: button1TextColor,
  //           button2TextColor: button2TextColor,
  //           onTapYes: onTapYes,
  //           onTapNo: onTapNo,
  //         );
  //       });
  // }

  // Future showCustomConfirmationIconDialog(BuildContext context,
  //     {String? title = AppStrings.confirmationDialogTitle,
  //     String? description = AppStrings.confirmationDialogDeleteDescription,
  //     String? button1Text = AppStrings.dialogActionButtonOneText,
  //     String? button2Text = AppStrings.dialogActionButtonTwoText,
  //     required String assetPath,
  //     Color? button1Color,
  //     Color? button2Color,
  //     Color? borderColor,
  //     Color? button1TextColor,
  //     Color? button2TextColor,
  //     Function()? onTapOption2,
  //     Function()? onTapOption1}) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return CustomConfirmationIconDialog(
  //           title: title,
  //           assetPath: assetPath,
  //           borderColor: borderColor,
  //           description: description,
  //           button1Text: button1Text,
  //           button2Text: button2Text,
  //           button1Color: button1Color,
  //           button2Color: button2Color,
  //           button1TextColor: button1TextColor,
  //           button2TextColor: button2TextColor,
  //           onTapYes: onTapOption2,
  //           onTapNo: onTapOption1,
  //         );
  //       });
  // }

  // Future showCustomAddCardDialog(context,
  //     {String? description,
  //     Function()? onTapYes,
  //     Function()? onTapNo,
  //     double? fontSize,
  //     String? yes,
  //     String? title,
  //     String? no}) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return CustomAddCardDialog(
  //             description: description,
  //             onTapYes: onTapYes,
  //             onTapNo: onTapNo ??
  //                 () {
  //                   //  AppNavigation.navigatorPop(context);
  //                 },
  //             yes: yes,
  //             fontSize: fontSize,
  //             title: title,
  //             No: no);
  //       });
  // }

  // Future cancelOrderReasonDialog(context, {int? index, int? orderId}) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return CancelOrderReasonDialog(
  //           index: index,
  //           orderId: orderId,
  //         );
  //       });
  // }

  // static Future showDeleteAccountDialog(
  //   context,
  //   // String? title,
  //   // String? assetPath,
  //   // String? message,
  //   // String? buttonText1,
  //   // String? buttonText2,
  //   // bool showButton2 = false,
  //   // bool showTextButton2 = false,
  //   // void Function()? ontapButton1,
  // ) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return DeleteAccountDialog();
  //       });
  // }

  // static Future showRideCancelationDialog(
  //   context,
  //   // String? title,
  //   // String? assetPath,
  //   // String? message,
  //   // String? buttonText1,
  //   // String? buttonText2,
  //   // bool showButton2 = false,
  //   // bool showTextButton2 = false,
  //   // void Function()? ontapButton1,
  // ) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return RideCancelationDialog();
  //       });
  // }

  // static Future showPaymentDialog(
  //   context, {
  //   required String buttonText,
  //   Function()? onclick,
  // }
  //     // String? title,
  //     // String? assetPath,
  //     // String? message,
  //     // String? buttonText1,
  //     // String? buttonText2,
  //     // bool showButton2 = false,
  //     // bool showTextButton2 = false,
  //     // void Function()? ontapButton1,
  //     ) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return PaymentDialog(
  //           buttonText: buttonText,
  //           onclick: onclick,
  //         );
  //       });
  // }

  static Future showComplianceDialog(context,
      // String? title,
      // String? assetPath,
      // String? message,
      // String? buttonText1,
      // String? buttonText2,
      // bool showButton2 = false,
      // bool showTextButton2 = false,
      // void Function()? ontapButton1,
      {String? stateFiling,
      String? permitsRenewal,
      String? licenseUpdate,
      required void Function(String) onBtnTap}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ComplianceDialog(
            onBtnTap: onBtnTap,
            licenseUpdate: licenseUpdate,
            permitsRenewal: permitsRenewal,
            stateFiling: stateFiling,
          );
        });
  }

  static Future showRejectDialog(   context, {
    String? title,
    String? btnTxt1,
    String? btnTxt2,
    String? image,
    bool isDoneShow = true,
    bool barrierDismissible = false,
    // required String description,
    final Function()? onTap1,
    final Function()? onTap2,}) {
    return showDialog(
      
        barrierDismissible: barrierDismissible, // Prevent dismiss on tap outside
        barrierColor: AppColors.orange.withOpacity(0.8),
        context: context,
        builder: (context) {
          return Material(color: AppColors.transparent,
            child: CustomRejectDialog( 
              btnTxt1: btnTxt1,
              barrierDismissible: barrierDismissible,
              image: image,
              btnTxt2: btnTxt2,
              isDoneShow: isDoneShow,
              title: title,
              onTap1: onTap1,
              onTap2: onTap2,),
          );
        });
  }

  static Future showSuccessDialog(
    context, {
    String? title,
    String? btnTxt1,
    String? btnTxt2,
    String? image,
    bool isDoneShow = true,
    bool barrierDismissible = false,
    required String description,
    final Function()? onTap1,
    final Function()? onTap2,
  }) {
    return showDialog(
        barrierDismissible: barrierDismissible, // Prevent dismiss on tap outside
        barrierColor: AppColors.orange.withOpacity(0.8),
        context: context,
        builder: (context) {
          return SuccessfulDialog(
            description: description,
            btnTxt1: btnTxt1,
            barrierDismissible: barrierDismissible,
            image: image,
            btnTxt2: btnTxt2,
            isDoneShow: isDoneShow,
            title: title,
            onTap1: onTap1,
            onTap2: onTap2,
          );
        });
  }

  // static Future showCommitDialog(
  //   context, {
  //   String? title,
  //   required String bt1,
  //   required String bt2,
  //   required String name,
  //   final Function()? onSubmit,
  // }) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return CommitDialog(
  //           bt1: bt1,
  //           bt2: bt2,
  //           name: name,
  //           title: title,
  //           onTap: onSubmit,
  //         );
  //       });
  // }

  // static Future showSelectTimeDialog(
  //   context, {
  //   String? minutes,
  //   String? seconds,
  //   String? hours,
  //   required bool isAdd,
  //   final Function(String? value)? onSubmit,
  // }) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return SelectTimeDialog(
  //           isAdd: isAdd,
  //           hours: hours,
  //           minutes: minutes,
  //           seconds: seconds,
  //           onSubmit: onSubmit,
  //         );
  //       });
  // }

  static Future showDeleteAndAllDialog(context,
      {String? assetPath,
      String? message,
      String? buttonText1,
      String? buttonText2,
      void Function()? ontapButton1}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DeleteAndAllDialoge(
            assetPath: assetPath,
            message: message,
            buttonText1: buttonText1,
            buttonText2: buttonText2,
            ontapButton1: ontapButton1,
          );
        });
  }

  static Future showFileImageSourceDialog(
    context, {
    final Function(File)? setFile,
  }) {
    return showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (context) {
          return ShowFileImageSourceDialog(
            setFile: setFile,
          );
        });
  }

  static Future showImageSourceDialog(
    context, {
    final Function(File)? setFile,
    bool isVideo = false,
  }) {
    return showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (context) {
          return ShowImageSourceDialog(
            isVideo: isVideo,
            setFile: setFile,
          );
        });
  }

  static Future showThankYouDialog(context,
      {String? title,
      String? assetPath,
      String? message,
      String? buttonText1,
      void Function()? ontapButton1}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ThankYouDialog(
            title: title,
            assetPath: assetPath,
            message: message,
            buttonText1: buttonText1,
            ontapButton1: ontapButton1,
          );
        });
  }

  static Widget progressDialog() {
    return const CircularProgressIndicator(
      color: AppColors.black,
    );
  }
}
