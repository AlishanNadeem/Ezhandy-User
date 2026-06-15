import 'package:ezhandy_user/module/core/chat/controller/messages_controller.dart';
import 'package:ezhandy_user/module/core/chat/model/my_chat_model.dart';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
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
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ProChat extends StatefulWidget {
  ProChat({super.key});

  @override
  State<ProChat> createState() => _ProChatState();
}

class _ProChatState extends State<ProChat> {
  static const _controllerTag = 'pro_chat';

  late final MessagesController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      MessagesController(chatType: 'ask_pro'),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    if (Get.isRegistered<MessagesController>(tag: _controllerTag)) {
      Get.delete<MessagesController>(tag: _controllerTag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      title: AppStrings.proChat,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding14),
        child: Column(
          children: [
            10.verticalSpace,
            searchTextField(),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value && _controller.chats.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = _controller.filteredChats;
                if (items.isEmpty) {
                  return Center(
                    child: CustomText(
                      text: AppStrings.noChatsFound,
                      color: AppColors.greyLight,
                      is_alignLeft: false,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _controller.fetchMyChats,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: AppPadding.padding20,
                      bottom: AppPadding.padding25,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final chat = items[index];
                      return singleWidget(
                        chat: chat,
                        ontap: () {
                          AppNavigation.navigateTo(
                            context,
                            AppRoutes.chatScreenRoute,
                            arguments: ChatRoutingArgument(
                              isBooking: false,
                              isCalls: true,
                              chatId: chat.chatId,
                              otherUserName: chat.displayName,
                              otherUserImage: chat.otherUser.profileImage,
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => 10.verticalSpace,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchTextField() {
    return CustomTextField(
      label: false,
      prefxicon: AssetPath.searchIcon,
      hint: AppStrings.searchAnything,
      controller: _searchController,
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      onchange: _controller.updateSearch,
    );
  }

  Widget singleWidget({
    required MyChatItem chat,
    required VoidCallback ontap,
  }) {
    final time = _formatTimeAgo(chat.displayTime);
    final preview = chat.lastMessagePreview;
    final previewText =
        preview.isNotEmpty ? preview : AppStrings.startConversation;

    return CustomContainer(
      onTap: ontap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserImageWidget(
            image: chat.otherUser.profileImage,
            size: 28,
          ),
          5.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: chat.displayName,
                        color: AppColors.orange,
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                      ),
                    ),
                    if (chat.unreadCount > 0) ...[
                      8.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: CustomText(
                          text: chat.unreadCount.toString(),
                          color: AppColors.white,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ],
                ),
                4.verticalSpace,
                CustomText(
                  text: previewText,
                  maxLines: 1,
                  fontSize: 12.sp,
                  color: preview.isNotEmpty
                      ? (chat.unreadCount > 0
                          ? AppColors.black
                          : AppColors.greyLight)
                      : AppColors.greyLight,
                ),
              ],
            ),
          ),
          8.horizontalSpace,
          CustomText(
            text: time,
            color: AppColors.greyLight,
            fontWeight: FontWeight.w500,
            fontSize: 11.sp,
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';
    final dt = dateTime.toLocal();
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    if (diff.inDays < 7) return '${diff.inDays} d ago';
    return DateFormat('dd MMM yyyy').format(dt);
  }
}
