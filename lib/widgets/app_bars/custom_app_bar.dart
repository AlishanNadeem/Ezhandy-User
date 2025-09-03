import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  BuildContext context;
  final String? title;
  Color? titleColor;
  final String? isLeading;
  void Function()? onclickLead;
  final String? isAction;
  void Function()? onclickAction;
  // bool? is_registration;
  Widget? actionWidget, leadingWidget, titleWidget;
  double? appBarheight;
  CustomAppBar(
      {super.key,
      this.actionWidget,
      required this.context,
      this.isAction,
      this.titleColor,
      this.leadingWidget,
      this.isLeading,
      // this.is_registration,
      this.onclickAction,
      this.titleWidget,
      this.onclickLead,
      this.title,
      this.appBarheight});
  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBarheight ?? 50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // flexibleSpace: is_registration == true
      //     ? SizedBox.shrink()
      //     : Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.only(
      //             bottomLeft: Radius.circular(20),
      //             bottomRight: Radius.circular(20),
      //           ),
      //           // gradient: AppGradients.appBarGradient
      //           // stops: [0.1, 1.0],
      //         ),
      //       ),
      leadingWidth: 45.sp,
      toolbarHeight: 0.09.sh,
      backgroundColor: AppColors.transparent,
      elevation: 0.0,
      title: titleWidget ??
          Text(
            title ?? "",
            style: TextStyle(
              color: titleColor ?? (AppColors.black),
              fontSize: 20.sp,
            ),
          ),
      centerTitle: false,
      leading: leadingWidget ??
          (isLeading != null
              ? Builder(builder: (context) {
                  return GestureDetector(
                    onTap: onclickLead,
                    child:
                        // is_registration == true
                        //     ? Image.asset(
                        //         isLeading!,
                        //         // color: AppColors.black,
                        //         alignment: Alignment.center,
                        //         scale: 3.sp,
                        //       )
                        //     :
                        titleColor == null
                            ? Container(
                                // padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                    // boxShadow: AppShadows.shadow4,
                                    color: AppColors.orange,
                                    shape: BoxShape.circle),
                                child: imageWidget(image: isLeading!),
                              )
                            : imageWidget(image: isLeading!),
                  );
                })
              : const SizedBox()),
      actions: [
        actionWidget ??
            (isAction != null
                ? GestureDetector(
                    onTap: onclickAction,
                    child: titleColor == null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Container(
                              // padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(8.sp),
                              decoration: BoxDecoration(
                                  // boxShadow: AppShadows.shadow4,
                                  color: AppColors.white,
                                  shape: BoxShape.circle),
                              child: imageWidget(image: isAction!),
                            ),
                          )
                        : imageWidget(image: isAction!),
                  )
                : SizedBox(
                    width: 46.w,
                  ))
      ],
    );
  }

  Image imageWidget({image}) {
    return Image.asset(
      image!,
      // color: AppColors.gradient_1,
      alignment: Alignment.center,
      scale: 4.sp,
    );
  }
}

// PreferredSizeWidget? CustomAppBar(
//   BuildContext context,
//   final String? title,
//   final String? isLeading,
//   void Function()? onclickLead,
//   final String? isAction,
//   void Function()? onclickAction,
//   bool? is_registration,
//   Widget? action_widget,
// ) {
//   return AppBar(
//     flexibleSpace:is_registration==true?SizedBox.shrink(): Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             AppColors.primaryBlue,
//             AppColors.darkBlue,
//           ],
//           stops: [0.1, 1.0],
//         ),
//       ),
//     ),
//     leadingWidth: 65.sp,
//     toolbarHeight: 0.09.sh,
//     backgroundColor: AppColors.transparent,
//     elevation: 0.0,
//     title: Text(
//       title ?? "",
//       style: TextStyle(
//         color: is_registration == true
//             ? AppColors.black
//             : AppColors.white,
//         fontSize: 16.sp,
//       ),
//     ),
//     centerTitle: true,
//     leading: isLeading != null
//         ? Builder(builder: (context) {
//             return GestureDetector(
//               onTap: onclickLead,
//               child: Image.asset(
//                 isLeading,
//                 color: is_registration == true
//                     ? AppColors.black
//                     : AppColors.white,
//                 alignment: Alignment.center,
//                 scale: 4,
//               ),
//             );
//           })
//         : const SizedBox(),
//     actions: [
//      action_widget??( isAction != null
//           ? InkWell(
//             onTap: onclickAction,
//             child: Image.asset(isAction,
//                 scale: 3, alignment: Alignment.center),
//           )
//           : const SizedBox()
// )    ],
//   );
// }
