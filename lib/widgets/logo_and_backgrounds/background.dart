import 'dart:io';

import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/app_bars/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class BackgroundImage extends StatelessWidget {
  final String? title;
  bool? resizeToAvoidBottomInset;
  final String? leading;
  final String? action;
  final Widget? actionWidget;
  final String? actionText;
  Widget? floatingActionButton;
FloatingActionButtonLocation? floatingActionButtonLocation;
  bool extendBodyBehindAppBar;
  bool? is_bottomNav;
  void Function()? onclickLead, onclickAction;
  final Widget child;
  Widget? drawer;
  Key? globalkey;
  // bool? is_registration;
  Widget?  leadingWidget, titleWidget;
  double? appBarheight;
  Color? titleColor;
  BackgroundImage({
    Key? key,
    required this.child,
    this.actionWidget,
    this.floatingActionButtonLocation,
    this.titleColor,
    this.titleWidget,
    this.leadingWidget,
    // this.is_registration = false,
    this.is_bottomNav = false,
    this.extendBodyBehindAppBar = false,
    this.title,
    this.leading,
    this.action,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
    this.onclickLead,
    this.onclickAction,
    this.actionText,
    
    this.drawer,
    this.globalkey,
    this.appBarheight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
            // image: is_registration == true ? const DecorationImage(image: AssetImage(AssetPath.splash2Image), fit: BoxFit.fill) : null,
            color:
                //  is_registration == false
                //     ?
                AppColors.white
            // : null,
            ),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              // FocusManager.instance.primaryFocus?.unfocus();
            },
            child: (is_bottomNav == false ? scaffoldWidget(context) : child)));
  }

  Widget scaffoldWidget(context) {
    return 
    Platform.isAndroid
        ? SafeArea(child: withOutSafeAreaWidget(context))
        :
         withOutSafeAreaWidget(context);

    // withOutSafeareaWidget(context);
  }

  Scaffold withOutSafeAreaWidget(context) {
    return Scaffold(
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: AppColors.transparent,
        appBar: CustomAppBar(
          titleColor: titleColor,
          titleWidget: titleWidget,
          leadingWidget: leadingWidget,
          appBarheight: appBarheight,
          context: context,
          title: title,
          isLeading: leading,
          onclickLead: onclickLead,
          isAction: action,
          onclickAction: onclickAction,
          // is_registration: is_registration,
          actionWidget: actionWidget,
        ),
        body: child,
        drawer: drawer,
        key: globalkey,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton: floatingActionButton
        // bottomNavigationBar: ,
        );
  }
}
