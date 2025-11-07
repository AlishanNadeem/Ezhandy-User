import 'dart:io';

import 'package:ezhandy_user/module/core/chat/model/chat_model.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/widgets/Container/bubble_chat_container.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  bool isBooking;
   ChatScreen({this.isBooking=false ,super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  List<ChatModel> messages = [
    ChatModel(
      text: "Welcome to support!",
      isSender: false,
      time: DateTime.parse("2025-08-05T10:00:00Z"),
    ),
    ChatModel(
      text: "I ",
      isSender: true,
      time: DateTime.parse("2025-08-05T11:30:00Z"),
    ),
    ChatModel(
      text: AppStrings.lorem5,
      isSender: false,
      time: DateTime.parse("2025-08-06T08:45:00Z"),
    ),
    ChatModel(
      text: "Any update?",
      isSender: true,
      time: DateTime.parse("2025-08-06T15:09:36Z"), // ← your ISO time
    ),
    ChatModel(
      text: "Yes, your order will arrive tomorrow.",
      isSender: false,
      time: DateTime.parse("2025-08-07T09:00:00Z"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      // appBarheight: 50.h,
      title: AppStrings.dummyName,
      actionWidget: bookingWidget(),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.padding12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final current = messages[index];
                final prev = index > 0 ? messages[index - 1] : null;
                bool showDateDivider =
                    prev == null || !_isSameDate(current.time, prev.time);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showDateDivider) _buildDateDivider(current.time),
                    ChatBubble(
                      
                      time: AppStrings.dummytime,
                      name: AppStrings.dummyName,
                      text: current.text,
                      isSender: current.isSender,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return 20.verticalSpace;
              },
            ),
          ),
          CustomContainer(
            borderColor: AppColors.transparent,
            radius: 0,
            bgColor: AppColors.orange,
            child: Padding(
              padding: Platform.isAndroid
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(bottom: AppPadding.padding25),
              child: Row(
                children: [
                  GestureDetector(
                    child: Image.asset(
                      AssetPath.emojiIcon,
                      width: 27.w,
                      height: 27.h,
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(child: _messageTextField()),
                  10.horizontalSpace,
                  GestureDetector(
                    child: Image.asset(
                      AssetPath.cameraIcon,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                  10.horizontalSpace,
                  GestureDetector(
                    child: Image.asset(
                      AssetPath.mikeIcon,
                      width: 27.w,
                      height: 27.h,
                    ),
                  ),
                  10.horizontalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bookingWidget() {
    return Visibility(visible:widget. isBooking,
      child: Padding(
        padding:  EdgeInsets.only(right: AppPadding.padding12,top: 5.h,bottom: 5.h),
        child: CustomContainer(onTap: (){},
          child: CustomText(
            text: AppStrings.booking,
            color: AppColors.white,
          ),
          bgColor: AppColors.orange,
          
        ),
      ),
    );
  }

  Widget _messageTextField() {
    return CustomTextField(
      borderRadius: 5.r,
      borderColor: AppColors.white,
      fillColor: AppColors.transparent,
      hint: AppStrings.message,
      fontColor: AppColors.white,
      hintColor: AppColors.white,
      divider: false,
      label: false,
      sufixImage: Image.asset(AssetPath.sendIcon, width: 30.w, height: 30.h),
      onclickSufix: () {
        if (messageController.text.trim().isNotEmpty) {
          setState(() {
            messages.add(ChatModel(
              text: messageController.text,
              isSender: true,
              time: DateTime.now().toUtc(), // adds live message
            ));
            messageController.clear();
          });
        }
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: messageController,
    );
  }

  Widget _buildDateDivider(DateTime date) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.grey)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              _formatDate(date.toLocal()), // optional: convert to local time
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        ],
      ),
    );
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatDate(DateTime date) {
    return "${date.day} ${_monthName(date.month)}, ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }
}
