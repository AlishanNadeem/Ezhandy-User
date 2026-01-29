import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/module/core/community/model/reaction_model.dart';
import 'package:ezhandy_user/module/core/community/routing_arguments/add_edit_post_routing_arguments.dart';
import 'package:ezhandy_user/module/core/main_menu/main_menu_user.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/button_widgets/reaction_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
//

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  // String? filterStartValue;

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.myPosts,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: ListView.separated(
              padding: EdgeInsets.only(
                  top: AppPadding.padding20, bottom: AppPadding.padding25),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                // final item = notifications[index];
                return singleWidget(
                    commentCount:
                        Constants.formatFacebookCount(int.parse("15000")),
                    likeCount:
                        Constants.formatFacebookCount(int.parse("85000")),
                    day: AppStrings.dummyDate,
                    name: "john sina",
                    des: AppStrings.lorem5,
                    image: null,
                    onTapComment: () {
                      AppDialogs.showCommunityCommentsDialog(context);
                    },
                    ontapLike: () {
                      AppDialogs.showCommunityLikeDialog(context);
                    });
              },
              separatorBuilder: (context, index) {
                return 10.verticalSpace;
              },
            )));
  }

  Widget searchTextField() {
    return CustomTextField(
      label: false,
      prefxicon: AssetPath.searchIcon,
      hint: AppStrings.searchAnything,
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      // controller: firstNameController,
    );
  }

  Row appbarWidget() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            globalkey.currentState!.openDrawer();
          },
          child: Image.asset(
            AssetPath.menuIcon,
            alignment: Alignment.centerLeft,
            scale: 4.sp,
            color: AppColors.black,
          ),
        ),
        10.horizontalSpace,
        CustomText(
          text: AppStrings.community,
          // fontFamily: AppStrings.montserrat,
          // color: AppColors.blueDark,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        Spacer(),
        notificationWidget(context)
      ],
    );
  }

  GestureDetector notificationWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateTo(context, AppRoutes.notificationScreenRoute);
      },
      child: Image.asset(AssetPath.bellIcon, width: 20.w, height: 20.h),
    );
  }

  Widget singleWidget(
      {day,
      name,
      image,
      des,
      ontapLike,
      onTapComment,
      likeCount,
      commentCount}) {
    return CustomContainer(
      // onTap: ontap,
      child: Column(children: [
        Row(children: [
          UserImageWidget(
            image: image,
            size: 20.sp,
          ),
          5.horizontalSpace,
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(
                text: name, fontSize: 16.sp, fontWeight: FontWeight.bold),
            CustomText(
              text: day,
              fontSize: 12.sp,
            ),
          ]),
          Spacer(),
          GestureDetector(
              onTapDown: (TapDownDetails details) {
                _showPopupMenu(context, details.globalPosition);
              },
              child: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).colorScheme.primary,
              ))
        ]),
        5.verticalSpace,
        CustomText(text: des),
        10.verticalSpace,
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [

              //     const SizedBox(width: 6),
              //     const Text(
              //       "15.5K",
              //       style: TextStyle(
              //         fontSize: 12,
              //         color: Colors.grey,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ],
              // ),

              GestureDetector(
                onTap: ontapLike,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30.w,
                      height: 20,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _staticReactionIcon(
                            icon: Icons.thumb_up,
                            color: Colors.blue,
                            left: 0,
                          ),
                          _staticReactionIcon(
                            icon: Icons.favorite,
                            color: Colors.red,
                            left: 8,
                          ),
                          _staticReactionIcon(
                            icon: Icons.emoji_emotions,
                            color: Colors.orange,
                            left: 15,
                          ),
                        ],
                      ),
                    ),

                    // 5.horizontalSpace,
                    CustomText(
                        text: likeCount,
                        color: AppColors.greyLight,
                        fontSize: 10.sp),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: onTapComment,
                child: CustomText(
                  text: "$commentCount Comment",
                  color: AppColors.greyLight,
                  fontSize: 10.sp,
                ),
              ),
            ]),
        Divider(),
        Row(
          children: [
            // InkWell(
            //   onTap: () {
            //     // LIKE CLICK
            //     print("Like clicked");
            //   },
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.thumb_up_off_alt,
            //         size: 15.sp,
            //         color: AppColors.greyLight,
            //       ),
            //       5.horizontalSpace,
            //       CustomText(
            //         text: "Like",
            //         color: AppColors.greyLight,
            //         fontSize: 10.sp,
            //       ),
            //     ],
            //   ),
            // ),
            FacebookReactionButton(),

            const Spacer(),
            GestureDetector(
              onTap: onTapComment,
              child: Row(
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 15.sp,
                    color: AppColors.greyLight,
                  ),
                  5.horizontalSpace,
                  CustomText(
                    text: "Comment",
                    color: AppColors.greyLight,
                    fontSize: 10.sp,
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget _staticReactionIcon({
    required IconData icon,
    required Color color,
    required double left,
  }) {
    return Positioned(
      left: left,
      child: Center(
        child: Icon(
          icon,
          size: 12,
          color: color,
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context, Offset position) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(position, position),
        Offset.zero & overlay.size,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        )
      ],
    );

    switch (selected) {
      case 'edit':
        AppNavigation.navigateTo(context, AppRoutes.createANewPostScreenRoute,
            arguments: AddEditPostRoutingArgument(type: AddEditType.edit.name));
        break;

      case 'delete':
        AppDialogs.showSuccessDialog(context,
            description: AppStrings.areYouSureWantToDeletePost,
            title: AppStrings.delete + "!",
            image: AssetPath.deletePopUpIcon,
            isDoneShow: false,
            btnTxt1: AppStrings.no,
            onTap1: () {
              AppNavigation.navigatorPop(context);
            },
            btnTxt2: AppStrings.yes,
            onTap2: () {
              AppNavigation.navigatorPop(context);
              AppDialogs.showSuccessDialog(
                context,
                description: "Post has been deleted successfully.",
                title: AppStrings.congratulation,
                btnTxt1: AppStrings.ok,
                onTap1: () {
                  AppNavigation.navigatorPopUntil(
                      context, AppRoutes.myPostsScreenRoute);
                },
              );
            });

        break;
    }
  }
}
