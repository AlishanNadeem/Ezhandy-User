import 'dart:io';

import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/chat/controller/chat_controller.dart';
import 'package:ezhandy_user/module/core/chat/model/chat_model.dart';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  final bool isBooking;
  final bool isCalls;
  final String? chatId;
  final String? otherUserName;
  final String? otherUserImage;

  const ChatScreen({
    this.isBooking = false,
    this.isCalls = false,
    this.chatId,
    this.otherUserName,
    this.otherUserImage,
    super.key,
  });

  factory ChatScreen.fromArgs(ChatRoutingArgument? args) {
    return ChatScreen(
      isBooking: args?.isBooking ?? false,
      isCalls: args?.isCalls ?? false,
      chatId: args?.chatId,
      otherUserName: args?.otherUserName,
      otherUserImage: args?.otherUserImage,
    );
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int count = 0;
  late final String _controllerTag;
  late final ChatController _controller;

  @override
  void initState() {
    super.initState();
    _controllerTag = 'chat_${widget.chatId ?? 'none'}';
    _controller = Get.put(
      ChatController(
        chatId: widget.chatId ?? '',
        otherUserName: widget.otherUserName,
        otherUserImage: widget.otherUserImage,
      ),
      tag: _controllerTag,
    );
    ever(_controller.messages, (_) => _scrollToBottom());
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    if (Get.isRegistered<ChatController>(tag: _controllerTag)) {
      Get.delete<ChatController>(tag: _controllerTag);
    }
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: _controller.title,
      actionWidget: actionWidget(),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value && _controller.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if ((widget.chatId ?? '').trim().isEmpty) {
                return Center(
                  child: CustomText(
                    text: 'Missing chat. Go back and open a conversation.',
                    color: AppColors.greyLight,
                    is_alignLeft: false,
                  ),
                );
              }

              final messages = _controller.messages;
              if (messages.isEmpty) {
                return Center(
                  child: CustomText(
                    text: AppStrings.noMessagesFound,
                    color: AppColors.greyLight,
                    is_alignLeft: false,
                  ),
                );
              }

              return ListView.separated(
                controller: _scrollController,
                padding:
                    EdgeInsets.symmetric(horizontal: AppPadding.padding12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final current = messages[index];
                  final prev = index > 0 ? messages[index - 1] : null;
                  final showDateDivider = prev == null ||
                      !_isSameDate(current.time, prev.time);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showDateDivider) _buildDateDivider(current.time),
                      ChatBubble(
                        time: _formatMessageTime(current.time),
                        name: _displayName(current),
                        text: current.text,
                        isSender: current.isSender,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => 20.verticalSpace,
              );
            }),
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

  String _displayName(ChatModel message) {
    if (message.isSender) {
      return message.senderName?.trim().isNotEmpty == true
          ? message.senderName!
          : (AuthController.i.appUser.value.data?.userModel?.fullName ??
              AppStrings.dummyName);
    }
    return message.senderName?.trim().isNotEmpty == true
        ? message.senderName!
        : (_controller.otherUserName ?? AppStrings.dummyName);
  }

  String _formatMessageTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime.toLocal());
  }

  Widget actionWidget() {
    if (widget.isBooking) {
      return Padding(
        padding: EdgeInsets.only(
          right: AppPadding.padding12,
          top: 5.h,
          bottom: 5.h,
        ),
        child: CustomContainer(
          onTap: () {},
          bgColor: AppColors.orange,
          child: CustomText(
            text: AppStrings.booking,
            color: AppColors.white,
          ),
        ),
      );
    } else if (widget.isCalls) {
      return Padding(
        padding: EdgeInsets.only(
          right: AppPadding.padding12,
          top: 5.h,
          bottom: 5.h,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                AppDialogs.showSuccessDialog(
                  context,
                  description: 'Make a payment for audio call.',
                  title: '\$9.99/ for 10 minutes',
                  image: AssetPath.proUserIcon,
                  isDoneShow: false,
                  btnTxt1: AppStrings.continuee,
                  onTap1: () {
                    AppDialogs.showSuccessDialog(
                      context,
                      description: AppStrings.paymentHasBeenDoneSuccessfully,
                      title: AppStrings.congratulation,
                      isDoneShow: true,
                      btnTxt1: AppStrings.ok,
                      onTap1: () {
                        AppNavigation.navigatorPopUntil(
                          context,
                          AppRoutes.chatScreenRoute,
                        );
                      },
                    );
                  },
                  btnTxt2: AppStrings.cancel,
                  onTap2: () => AppNavigation.navigatorPop(context),
                );
              },
              child: Image.asset(
                AssetPath.audioCallIcon,
                width: 20.w,
                height: 20.h,
              ),
            ),
            10.horizontalSpace,
            GestureDetector(
              onTap: () {
                AppDialogs.showSuccessDialog(
                  context,
                  description: 'Make a payment for video session.',
                  title: '\$9.99/ for 15 minutes',
                  image: AssetPath.proUserIcon,
                  isDoneShow: false,
                  btnTxt1: AppStrings.continuee,
                  onTap1: () {
                    AppDialogs.showSuccessDialog(
                      context,
                      description: AppStrings.paymentHasBeenDoneSuccessfully,
                      title: AppStrings.congratulation,
                      isDoneShow: true,
                      btnTxt1: AppStrings.ok,
                      onTap1: () {
                        AppNavigation.navigatorPopUntil(
                          context,
                          AppRoutes.chatScreenRoute,
                        );
                      },
                    );
                  },
                  btnTxt2: AppStrings.cancel,
                  onTap2: () => AppNavigation.navigatorPop(context),
                );
              },
              child: Image.asset(
                AssetPath.videoCallIcon,
                width: 25.w,
                height: 25.h,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
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
      onclickSufix: _sendMessage,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength),
      ],
      controller: messageController,
    );
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    if (widget.isCalls) {
      if (count >= 5) {
        AppDialogs.showSuccessDialog(
          context,
          description:
              'You’ve sent 5 messages in this pro chat. Make a payment to send more 5 messages.',
          title: '\$9.99/ 5 more text messages',
          image: AssetPath.proUserIcon,
          isDoneShow: false,
          btnTxt1: AppStrings.continuee,
          onTap1: () {
            AppDialogs.showSuccessDialog(
              context,
              description: AppStrings.paymentHasBeenDoneSuccessfully,
              title: AppStrings.congratulation,
              isDoneShow: true,
              btnTxt1: AppStrings.ok,
              onTap1: () {
                count = 0;
                AppNavigation.navigatorPopUntil(
                  context,
                  AppRoutes.chatScreenRoute,
                );
              },
            );
          },
          btnTxt2: AppStrings.cancel,
          onTap2: () => AppNavigation.navigatorPop(context),
        );
        return;
      }
      count++;
    }

    _controller.addLocalMessage(messageController.text);
    messageController.clear();
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
              _formatDate(date.toLocal()),
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
    return '${date.day} ${_monthName(date.month)}, ${date.year}';
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
      'December',
    ];
    return months[month];
  }
}
