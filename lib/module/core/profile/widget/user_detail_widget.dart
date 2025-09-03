// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:ezhandy_user/Modules/Profile/widget/followers_tab.dart';
// import 'package:ezhandy_user/Modules/Profile/widget/profile_picture_widget.dart';
// import 'package:ezhandy_user/Widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/Widgets/image_viewer/custom_view_full_image.dart';
// import 'package:ezhandy_user/Widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/utils/Routes/app_routes.dart';
// import 'package:ezhandy_user/utils/app_color.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/assets_paths.dart';
// import 'package:ezhandy_user/utils/common_function.dart';
// import 'package:ezhandy_user/utils/enum.dart';
// import 'package:ezhandy_user/utils/utils.dart';

// import '../view/view_followers_and_following.dart';

// class UserDetailWidget extends StatefulWidget {
//   dynamic Function()? onclickFollow;
//   dynamic Function()? onclickChat;
//   bool? isUser;
//   int? userId;
//   String? follow;
//   String? profileUrl;
//   String? name, userName, postCount, followersCount, followingCount;
//   UserDetailWidget({
//     super.key,
//     this.userId,
//     this.profileUrl,
//     this.onclickFollow,
//     this.onclickChat,
//     this.name,
//     this.userName,
//     this.postCount,
//     this.followersCount,
//     this.followingCount,
//     this.isUser = false,
//     this.follow,
//   });

//   @override
//   State<UserDetailWidget> createState() => _UserDetailWidgetState();
// }

// class _UserDetailWidgetState extends State<UserDetailWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return profile_detail_widget();
//   }

//   Widget profile_detail_widget() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       margin: EdgeInsets.only(top: 0.12.sh),
//       width: 1.sw,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Flexible(
//             flex: 1,
//             child: Column(
//               children: [
//                 ProfilePictureWidget(
//                   onTap: () {
//                     CommonFunction.onTapViewImage(
//                       context: context,
//                       mediaType: widget.profileUrl == null
//                           ? MediaPathType.asset.name
//                           : MediaPathType.network.name,
//                       image: widget.profileUrl,
//                     );
//                     // Get.to(ViewFullImageScreen(
//                     //   mediaType: widget.profileUrl == null ? "asset" : "network",
//                     //   image: widget.profileUrl,
//                     // ));
//                   },
//                   profileImageUrl: widget.profileUrl,
//                   size: 90,
//                   assetPath: AssetPaths.USER_IMAGE_1,
//                   borderColor: AppColors.WHITE_COLOR,
//                 ),
//                 const SizedBox(height: 10),
//                 CustomText(
//                   text: widget.name,
//                   color: AppColors.WHITE_COLOR,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: AppStrings.CAVIAR_DREAMS,
//                   maxLines: 1,
//                 ),
//                 CustomText(
//                   text: "@${widget.userName ?? ""}",
//                   color: const Color.fromARGB(255, 208, 207, 207),
//                   fontFamily: AppStrings.CAVIAR_DREAMS,
//                   maxLines: 1,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(width: 20.w),
//           Flexible(
//             flex: 2,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Row(
//                   children: [
//                     follwers_numbers_widget(AppStrings.POST, widget.postCount),
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       height: 30,
//                       width: 1,
//                       color: AppColors.WHITE_COLOR,
//                     ),
//                     GestureDetector(
//                         onTap: () {
//                           // showDialog(context: context,
      
//                           // builder: (context){
//                           //   return
//                           //       Dialog(
//                           //         insetPadding: const  EdgeInsets.all(25).r,
//                           //         shape: RoundedRectangleBorder(
//                           //           borderRadius: BorderRadius.circular(12)
//                           //         ),
      
//                           //         child: const  ViewFollowersAndFollowingTab(
//                           //           tabIndex: 0,
//                           //         ),
//                           //       );
//                           //     }
//                           //   );
//                           // });
      
//                           Utils().showAppDialog(
//                               context: context,
//                               child: ViewFollowersAndFollowingTab(
//                                   userId: widget.userId, tabIndex: 0));
//                         },
//                         child: follwers_numbers_widget(
//                             AppStrings.FOLLOWERS, widget.followersCount)),
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       height: 30,
//                       width: 1,
//                       color: AppColors.WHITE_COLOR,
//                     ),
//                     GestureDetector(
//                         onTap: () {
//                           Utils().showAppDialog(
//                               context: context,
//                               child: ViewFollowersAndFollowingTab(
//                                   userId: widget.userId, tabIndex: 1));
//                         },
//                         child: follwers_numbers_widget(
//                             AppStrings.FOLLOWING, widget.followingCount)),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 25.h,
//                 ),
//                 widget.isUser != true
//                     ? CustomButton(
//                         onclick: () {
//                           Get.toNamed(Paths.CREATE_PROFILE_USER_SCREEN_ROUTE,
//                               arguments: AppStrings.EDIT_PROFILE);
//                         },
//                         height: 40,
//                         is_shadow: false,
//                         text: AppStrings.EDIT_PROFILE)
//                     : Row(
//                         children: [
//                           Expanded(
//                               child: CustomButton(
//                                   onclick: widget.onclickFollow,
//                                   //  () {
//                                   //   setState(() {
//                                   //     widget.follow = !widget.follow;
//                                   //   });
//                                   // },
//                                   height: 40,
//                                   is_shadow: false,
//                                   text: widget.follow ?? "")),
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           Expanded(
//                               child: CustomButton(
//                                   onclick:widget.onclickChat,
//                                   //  () {
//                                   //   Get.toNamed(Paths.CHAT_SCREEN_ROUTE);
//                                   // },
//                                   height: 40,
//                                   is_shadow: false,
//                                   text: AppStrings.MESSAGES)),
//                         ],
//                       )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget follwers_numbers_widget(txet1, text2) {
//     return Column(
//       children: [
//         CustomText(
//           text: txet1,
//           color: AppColors.WHITE_COLOR,
//         ),
//         CustomText(
//           text: text2,
//           color: AppColors.WHITE_COLOR,
//         )
//       ],
//     );
//   }
// }
