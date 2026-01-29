import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_community_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_dialoge.dart';

// ignore: must_be_immutable
class CommunityLikeDialog extends StatelessWidget {
  CommunityLikeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final totalCount = "15K";
    final likeCount = "200";
    final loveCount = "400";
    final hahaCount = "0";
    final wowCount = "20";
    final sadCount = "150";
    final angryCount = "40";

    return CustomCommunityDialog(
        title: "People Who Reacted",
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // All 15K
                    _statItem(
                      icon: null,
                      label: "All $totalCount",
                    ),

                    // Divider
                    _verticalDivider(),

                    // Like
                    _statItem(
                      icon: Icons.thumb_up,
                      iconColor: Colors.blue,
                      label: likeCount,
                    ),

                    _verticalDivider(),

                    // Heart
                    _statItem(
                      icon: Icons.favorite,
                      iconColor: Colors.red,
                      label: loveCount,
                    ),
                    _verticalDivider(),

                    // Haha
                    _statItem(
                      icon: Icons.emoji_emotions,
                      iconColor: Colors.orange,
                      label: hahaCount,
                    ),
                    _verticalDivider(),

                    // Wow
                    _statItem(
                      icon: Icons.sentiment_satisfied,
                      iconColor: Colors.amber,
                      label: wowCount,
                    ),
                    _verticalDivider(),

                    // Sad
                    _statItem(
                      icon: Icons.sentiment_dissatisfied,
                      iconColor: Colors.blueGrey,
                      label: sadCount,
                    ),
                    _verticalDivider(),

                    // Angry
                    _statItem(
                        icon: Icons.sentiment_very_dissatisfied,
                        iconColor: Colors.redAccent,
                        label: angryCount),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(
                    top: AppPadding.padding20, bottom: AppPadding.padding25),
                shrinkWrap: true,
                itemCount: 100,
                itemBuilder: (context, index) {
                  // final item = notifications[index];
                  return Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            UserImageWidget(
                                // image: image,
                                size: 20.sp),
                            Positioned(
                                bottom: -5,
                                left: 0,
                                right: 0,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 18,
                                ))
                          ],
                        ),
                        5.horizontalSpace,

                        Expanded(
                          child: CustomText(
                            text: AppStrings.dummyName,
                          ),
                        ),
                        // CustomText(
                        //   text: day,
                        //   fontSize: 12.sp,
                        // ),
                      ]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
          ],
        ));
  }

  Widget _statItem({IconData? icon, Color? iconColor, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor ?? Colors.grey,
              size: 16,
            ),
          if (icon != null) const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 18,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
