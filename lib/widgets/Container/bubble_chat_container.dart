import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ChatBubble extends StatelessWidget {
  final String text, name;
  final bool isSender;

  const ChatBubble({
    required this.text,
    required this.name,
    required this.isSender,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isSender) UserImageWidget(),
        if (isSender) 10.horizontalSpace,
        Container(
          width: 250.w, // fixed width for both sender and receiver
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topRight: isSender ? Radius.circular(16) : Radius.circular(0),
              topLeft: isSender ? Radius.circular(0) : Radius.circular(16),
            ),
            border: Border.all(color: AppColors.greyBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: name,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              4.verticalSpace,
              CustomText(
                text: text,
                color: AppColors.grey,
              ),
            ],
          ),
        ),
        if (!isSender) 10.horizontalSpace,
        if (!isSender) UserImageWidget(),
      ],
    );
  }
}
