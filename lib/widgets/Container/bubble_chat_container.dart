import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/chat_media_helper.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/video_player/full_screen_video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final String text, name, time;
  final bool isSender;
  final String messageType;
  final String? image;
  final String? filePath;

  const ChatBubble({
    required this.text,
    required this.time,
    required this.name,
    required this.isSender,
    this.messageType = 'text',
    this.image,
    this.filePath,
    Key? key,
  }) : super(key: key);

  ChatMessageMediaType get _mediaType => resolveChatMessageType(
        messageType: messageType,
        filePath: filePath,
      );

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
              width: 250.w,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topRight:
                      isSender ? Radius.circular(16) : Radius.circular(0),
                  topLeft:
                      isSender ? Radius.circular(0) : Radius.circular(16),
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
                  if (_mediaType == ChatMessageMediaType.image) ...[
                    8.verticalSpace,
                    _buildMessageImage(context),
                  ],
                  if (_mediaType == ChatMessageMediaType.video) ...[
                    8.verticalSpace,
                    _buildViewVideoButton(context),
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
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            right: AppPadding.padding45,
            left: AppPadding.padding45,
            top: 5.h,
          ),
          child: CustomText(
            text: time,
            align: isSender ? Alignment.bottomRight : Alignment.bottomLeft,
          ),
        ),
      ],
    );
  }

  Widget _buildMessageImage(BuildContext context) {
    final media = resolveChatMedia(filePath);
    if (!media.hasMedia) return _brokenImagePlaceholder();

    if (media.isLocal && media.localFile != null) {
      return GestureDetector(
        onTap: () {
          Utils.onTapViewImage(
            context: context,
            image: media.localFile!.path,
            mediaType: MediaPathType.file.name,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.file(
            media.localFile!,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (media.networkPath.isEmpty) return _brokenImagePlaceholder();

    return GestureDetector(
      onTap: () {
        Utils.onTapViewImage(
          context: context,
          image: media.networkPath,
          mediaType: MediaPathType.network.name,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.network(
          media.networkPath,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _brokenImagePlaceholder(),
        ),
      ),
    );
  }

  Widget _buildViewVideoButton(BuildContext context) {
    final media = resolveChatMedia(filePath);
    if (!media.hasMedia) {
      return CustomText(
        text: 'Video unavailable',
        color: AppColors.grey,
        fontSize: 12.sp,
      );
    }

    return CustomButton(
      text: 'View Video',
      width: double.infinity,
      height: 36.h,
      borderRadius: 8.r,
      color: AppColors.orange,
      textcolor: AppColors.white,
      onclick: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => FullScreenVideoPlayerScreen(
              videoPath: media.isLocal
                  ? media.localFile!.path
                  : (filePath?.trim() ?? media.networkPath),
              isLocal: media.isLocal,
            ),
          ),
        );
      },
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
