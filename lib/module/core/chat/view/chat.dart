import 'dart:io';

import 'package:ezhandy_user/module/core/community/controller/ask_pro_controller.dart';
import 'package:ezhandy_user/module/core/community/widgets/ask_pro_pricing_dialog.dart';
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
  final String? chatType;
  final String? chatId;
  final String? otherUserId;
  final String? otherUserName;
  final String? otherUserImage;

  const ChatScreen({
    this.isBooking = false,
    this.chatType,
    this.chatId,
    this.otherUserId,
    this.otherUserName,
    this.otherUserImage,
    super.key,
  });

  factory ChatScreen.fromArgs(ChatRoutingArgument? args) {
    return ChatScreen(
      isBooking: args?.isBooking ?? false,
      chatType: args?.chatType,
      chatId: args?.chatId,
      otherUserId: args?.otherUserId,
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
  late final String _controllerTag;
  late final ChatController _controller;
  File? _selectedImage;
  bool _creditsPopupVisible = false;

  bool get _isAskProChat =>
      widget.chatType?.trim().toLowerCase() == 'ask_pro';

  @override
  void initState() {
    super.initState();
    _controllerTag = 'chat_${widget.chatId ?? 'none'}';
    _controller = Get.put(
      ChatController(
        chatId: widget.chatId ?? '',
        chatType: widget.chatType,
        otherUserId: widget.otherUserId,
        otherUserName: widget.otherUserName,
        otherUserImage: widget.otherUserImage,
      ),
      tag: _controllerTag,
    );
    ever(_controller.messages, (_) => _scrollToBottom());
    if (_isAskProChat) {
      ever<bool>(_controller.isMessageLimitReached, (reached) {
        if (reached) {
          _showCreditsExhaustedPopup();
        } else {
          _creditsPopupVisible = false;
        }
      });
    }
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
          if (_isAskProChat) _buildCreditsLeftBanner(),
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
                padding: EdgeInsets.only(
                  left: AppPadding.padding12,
                  right: AppPadding.padding12,
                  bottom: AppPadding.padding16,
                ),
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
                        image: _displayImage(current),
                        filePath: current.filePath,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => 20.verticalSpace,
              );
            }),
          ),
          Obx(() {
            if (!_controller.isOtherUserTyping.value) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.padding12,
                vertical: 6.h,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text:
                      '${_controller.otherUserName ?? AppStrings.dummyName} is typing...',
                  fontSize: 12.sp,
                  color: AppColors.grey,
                ),
              ),
            );
          }),
          Obx(() {
            if (_isAskProChat && _controller.isMessageLimitReached.value) {
              return _buildMessageLimitBanner();
            }
            return _buildMessageComposer();
          }),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_selectedImage != null) _selectedImagePreview(),
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
                Expanded(child: _messageTextField()),
                10.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    AppDialogs.showImageSourceDialog(
                      context,
                      setFile: _setImageFile,
                    );
                  },
                  child: Image.asset(
                    AssetPath.cameraIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageLimitBanner() {
    return Obx(
      () => CustomContainer(
        borderColor: AppColors.transparent,
        radius: 0,
        bgColor: AppColors.orange,
        onTap: _showCreditsExhaustedPopup,
        child: Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.symmetric(
                  horizontal: AppPadding.padding12,
                  vertical: 14.h,
                )
              : EdgeInsets.fromLTRB(
                  AppPadding.padding12,
                  14.h,
                  AppPadding.padding12,
                  AppPadding.padding25,
                ),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  text: _controller.messageLimitText.value,
                  color: AppColors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.horizontalSpace,
              Icon(
                Icons.lock_outline,
                color: AppColors.white,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setImageFile(File? file) {
    if (!mounted) return;
    setState(() {
      _selectedImage = file;
    });
  }

  void _removeSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Widget _buildCreditsLeftBanner() {
    return Obx(() {
      final credits = _controller.creditsLeft.value;
      if (credits == null) return const SizedBox.shrink();

      final label = credits == 1
          ? '1 message left'
          : '$credits messages left';

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.padding12,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: credits <= 0
              ? AppColors.orange.withValues(alpha: 0.12)
              : AppColors.greyLight.withValues(alpha: 0.12),
        ),
        child: CustomText(
          text: label,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: credits <= 0 ? AppColors.orange : AppColors.greyLight,
          is_alignLeft: false,
        ),
      );
    });
  }

  Widget _selectedImagePreview() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.padding12,
        vertical: 8.h,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              _selectedImage!,
              height: 72.h,
              width: 72.w,
              fit: BoxFit.cover,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: GestureDetector(
              onTap: _removeSelectedImage,
              child: CustomText(
                text: 'Remove image',
                color: AppColors.orange,
                fontWeight: FontWeight.bold,
                textDecoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _displayName(ChatModel message) {
    if (message.senderName?.trim().isNotEmpty == true) {
      return message.senderName!;
    }
    if (message.isSender) {
      return _controller.otherUserName ?? AppStrings.dummyName;
    }
    return AuthController.i.appUser.value.data?.userModel?.fullName ??
        AppStrings.dummyName;
  }

  String _displayImage(ChatModel message) {
    if (message.isSender) {
      return message.senderImage?.trim().isNotEmpty == true
          ? message.senderImage!
          : (_controller.otherUserImage ?? '');
    }
    return message.senderImage?.trim().isNotEmpty == true
        ? message.senderImage!
        : (AuthController.i.appUser.value.data?.userModel?.profileImage ?? '');
  }

  String _formatMessageTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime.toLocal());
  }

  Widget actionWidget() {
    // if (widget.isBooking) {
    //   return Padding(
    //     padding: EdgeInsets.only(
    //       right: AppPadding.padding12,
    //       top: 5.h,
    //       bottom: 5.h,
    //     ),
    //     child: CustomContainer(
    //       onTap: () {},
    //       bgColor: AppColors.orange,
    //       child: CustomText(
    //         text: AppStrings.booking,
    //         color: AppColors.white,
    //       ),
    //     ),
    //   );
    // } else
    if (_isAskProChat) {
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
      onchange: _controller.onTypingChanged,
    );
  }

  Future<void> _showCreditsExhaustedPopup() async {
    if (!mounted || _creditsPopupVisible) return;
    _creditsPopupVisible = true;

    final pricing = await AskProController().fetchPricing();

    if (!mounted) {
      _creditsPopupVisible = false;
      return;
    }

    if (pricing == null) {
      _creditsPopupVisible = false;
      AppDialogs.showToast(message: 'Unable to load Ask a Pro pricing');
      return;
    }

    await AskProPricingDialog.show(
      context,
      pricing: pricing,
      onDismiss: () {
        if (mounted) {
          _creditsPopupVisible = false;
        }
      },
    );
  }

  void _sendMessage() {
    final text = messageController.text.trim();
    final image = _selectedImage;

    if (text.isEmpty && image == null) return;

    if (_isAskProChat && _controller.isMessagingDisabled) {
      _showCreditsExhaustedPopup();
      return;
    }

    if (image != null) {
      _controller.sendImageFile(image, caption: text);
      setState(() {
        _selectedImage = null;
      });
      messageController.clear();
      return;
    }

    _controller.sendMessage(text);
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
