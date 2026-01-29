import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/reaction_button.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_community_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_dialoge.dart';

// ignore: must_be_immutable
class CommunityCommentsDialog extends StatelessWidget {
  CommunityCommentsDialog({super.key});
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final totalCount = "15K";

    return CustomCommunityDialog(
        title: "Comments",
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                        text: totalCount,
                        color: AppColors.greyLight,
                        fontSize: 10.sp),
                  ],
                ),
                FacebookReactionButton(
                  onTap: () {},
                ),
              ],
            ),
            //  g

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(
                    top: AppPadding.padding20, bottom: AppPadding.padding25),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  // final item = notifications[index];
                  return singleWidget(
                      likeCount:
                          Constants.formatFacebookCount(int.parse("85000")),
                      day: AppStrings.dummyDate,
                      name: "john sina",
                      des: AppStrings.lorem5,
                      image: null,
                      ontapLike: () {
                        AppDialogs.showCommunityLikeDialog(context);
                      });
                },
                separatorBuilder: (context, index) {
                  return 10.verticalSpace;
                },
              ),
            ),

            10.verticalSpace,
            _messageTextField()
          ],
        ));
  }

  Widget _messageTextField() {
    return CustomTextField(
      borderRadius: 5.r,
      borderColor: AppColors.greyBorder,
      fillColor: AppColors.transparent,
      hint: AppStrings.writeComment,
      // fontColor: AppColors.white,
      hintColor: AppColors.greyLight,
      divider: false,
      label: false,
      sufixImage: Image.asset(AssetPath.sendIcon, width: 30.w, height: 30.h,color: AppColors.orange,),
      onclickSufix: () {
        // if (messageController.text.trim().isNotEmpty) {
        //   setState(() {
        //     messages.add(ChatModel(
        //       text: messageController.text,
        //       isSender: true,
        //       time: DateTime.now().toUtc(), // adds live message
        //     ));
        messageController.clear();
        //   });
        // }
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: messageController,
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

  Widget singleWidget({
    day,
    name,
    image,
    des,
    ontapLike,
    likeCount,
  }) {
    return CustomContainer(bgColor: AppColors.transparent,
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
        ]),
        5.verticalSpace,
        CustomText(text: des),
        5.verticalSpace,
        Divider(),
        5.verticalSpace,
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FacebookReactionButton(),
              Spacer(),
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
            ]),
      ]),
    );
  }
}
