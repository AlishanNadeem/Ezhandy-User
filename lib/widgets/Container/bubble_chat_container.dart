import 'dart:io';

import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/media_url_helper.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ChatBubble extends StatelessWidget {
  final String text, name, time;
  final bool isSender;
  final String? image;
  final String? filePath;

  const ChatBubble({
    required this.text,
    required this.time,
    required this.name,
    required this.isSender,
    this.image,
    this.filePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (isSender) UserImageWidget(image: image),
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
                  if (_hasFilePath) ...[
                    8.verticalSpace,
                    _buildMessageImage(context),
                  ],
                  if (text.trim().isNotEmpty) ...[
                    4.verticalSpace,
                    CustomText(
                      text: text,
                      color: AppColors.grey,
                    ),
                  ],
                ],
              ),
            ),
            
            if (!isSender) 10.horizontalSpace,
            if (!isSender) UserImageWidget(image: image),
          ]
        ),
        Padding(
          padding:  EdgeInsets.only(right: AppPadding.padding45,left:  AppPadding.padding45,top: 5.h),
          child: CustomText(text: time,align:isSender? Alignment.bottomRight:Alignment.bottomLeft,),
        ),
      ],
    );
  }

  bool get _hasFilePath => filePath?.trim().isNotEmpty == true;

  Widget _buildMessageImage(BuildContext context) {
    final raw = filePath?.trim() ?? '';
    if (raw.isEmpty) return _brokenImagePlaceholder();

    final isNetwork =
        raw.startsWith('http://') || raw.startsWith('https://');
    final localFile = !isNetwork ? File(raw) : null;
    final isLocal = localFile != null && localFile.existsSync();
    final networkPath = isNetwork ? raw : resolveMediaUrl(raw);

    if (!isNetwork && !isLocal && networkPath.isEmpty) {
      return _brokenImagePlaceholder();
    }

    return GestureDetector(
      onTap: () {
        Utils.onTapViewImage(
          context: context,
          image: isLocal ? raw : networkPath,
          mediaType: isLocal
              ? MediaPathType.file.name
              : MediaPathType.network.name,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: isLocal
            ? Image.file(
                localFile!,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Image.network(
                networkPath,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _brokenImagePlaceholder(),
              ),
      ),
    );
  }

  Widget _brokenImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 120.h,
      color: AppColors.greybg,
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image_outlined,
        color: AppColors.greyLight,
      ),
    );
  }
}
