// ignore_for_file: must_be_immutable

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ContentScreen extends StatefulWidget {
  String? title;
  String? type;
  // bool? isBackground;
  ContentScreen({super.key, this.title, this.type});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  bool? isChecked = false;

  @override
  void initState() {
    super.initState();
    // AuthController.i.getContent(content_type: Get.arguments);

    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  // var title = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return withBackgroundWidget();
  }

  BackgroundImage withBackgroundWidget() {
    return BackgroundImage(
      // is_registration: false,
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: widget.title,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child:
            // Column(
            //   children: [
            // CustomText(
            //   text: widget.title,
            //   fontWeight: FontWeight.w600,
            //   is_alignLeft: false,
            // ),
            // dividerWidget(),
            contentWidget(),
        //   ],
        // ),
      ),
    );
  }

  // Stack dividerWidget() {
  //   return Stack(
  //     alignment: Alignment.topCenter,
  //     children: [
  //       Divider(
  //         color: AppColors.black,
  //       ),
  //       Positioned(
  //         top: 3.h,
  //         child: Container(
  //           width: 200.w,
  //           height: 4.h,
  //           decoration: BoxDecoration(
  //               color: AppColors.green, borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r), topRight: Radius.circular(5.r))),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget backgroundCheck() {
  //   return Visibility(
  //     visible: widget.type == WebContentType.bc.name,
  //     child: Column(
  //       children: [
  //         checkBox(),
  //         button(),
  //       ],
  //     ),
  //   );
  // }

  // Padding button() {
  //   return Padding(
  //     padding: const EdgeInsets.only(
  //       left: AppPadding.defaultHorizontalPadding,
  //       right: AppPadding.defaultHorizontalPadding,
  //       bottom: AppPadding.verticalPaddingEight,
  //     ),
  //     child: CustomButton(
  //       text: AppStrings.continuee,
  //       onclick: () {
  //         if (isChecked!) {
  //           AppDialogs.showSuccessAndAllDialog(context,
  //               title: AppStrings.successful,
  //               message: AppStrings.youHaveCompletedYourProfileSetUp,
  //               buttonText1: AppStrings.continuee, ontapButton1: () {
  //             AppNavigation.navigateToRemovingAll(
  //                 context, AppRoutes.userMainMenuScreenRoute);
  //           });
  //         }
  //       },
  //       textcolor: isChecked! ? null : AppColors.fontColor,
  //       color: !isChecked! ? AppColors.white : null,
  //     ),
  //   );
  // }

  // CheckBoxWidget checkBox() {
  //   return CheckBoxWidget(
  //     isChecked: isChecked!,
  //     title: AppStrings.acknowledge,
  //     ontapCheck: () {
  //       setState(() {
  //         isChecked = !isChecked!;
  //       });
  //     },
  //     // onCheckBoxStateChanged: (v) {
  //     //   innerState(() {
  //     //     if (v!) {}
  //     //     ischecked = !ischecked!;
  //     //   });
  //     // }
  //   );
  // }

  Widget contentWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomText(
              text:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "),
          25.verticalSpace
        ],
      ),
    );
  }

  // Widget contentWidget() {
  //   return Stack(
  //     children: [
  //       Opacity(
  //         opacity: _opacity ?? 0,
  //         child: WebView(
  //           initialUrl: AppStrings.webViewUrl,
  //           // AuthController.i.content!.value,
  //           onPageStarted: (String? url) {
  //             log("started");
  //           },
  //           onPageFinished: (String? url) {
  //             setState(() {
  //               _opacity = 1.0;
  //               _isLoading = false;
  //             });
  //           },
  //         ),
  //       ),
  //       Visibility(
  //         visible: _isLoading!,
  //         child: const Center(
  //           child: CircularProgressIndicator(color: AppColors.buttonColor),
  //         ),
  //       )
  //     ],
  //   );
  // }
}
