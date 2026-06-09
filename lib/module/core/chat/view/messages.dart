import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/chat/controller/messages_controller.dart';
import 'package:ezhandy_user/module/core/chat/model/my_chat_model.dart';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/module/core/main_menu/main_menu_user.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
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

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final MessagesController _controller = Get.put(MessagesController());
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    if (Get.isRegistered<MessagesController>()) {
      Get.delete<MessagesController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          10.verticalSpace,
          appbarWidget(),
          20.verticalSpace,
          searchTextField(),
          10.verticalSpace,
          CustomButton(
            text: 'Pro Chats',
            color: AppColors.black,
            onclick: () {
              AppNavigation.navigateTo(context, AppRoutes.proChatScreenRoute);
            },
          ),
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
                            isBooking: true,
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

  Row appbarWidget() {
    return Row(
      children: [
        GestureDetector(
          onTap: (!AuthController.i.isLoginSignUp.value)
              ? () {
                  signinSignUpPopup();
                }
              : () {
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
          text: AppStrings.messages,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        const Spacer(),
        notificationWidget(context),
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

  Widget singleWidget({
    required MyChatItem chat,
    required VoidCallback ontap,
  }) {
    final time = _formatTimeAgo(chat.displayTime);
    final preview = chat.lastMessagePreview;

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
                if (preview.isNotEmpty) ...[
                  4.verticalSpace,
                  CustomText(
                    text: preview,
                    maxLines: 1,
                    fontSize: 12.sp,
                    color: chat.unreadCount > 0
                        ? AppColors.black
                        : AppColors.greyLight,
                  ),
                ],
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

  void signinSignUpPopup() {
    AppDialogs.showSuccessDialog(
      context,
      barrierDismissible: true,
      description: AppStrings.inOrderToAccessThis,
      image: AssetPath.tumbIcon,
      isDoneShow: false,
      btnTxt1: AppStrings.logIn.toUpperCase(),
      onTap1: () {
        AppNavigation.navigateToRemovingAll(
          context,
          AppRoutes.loginScreenRoute,
        );
      },
      btnTxt2: AppStrings.signUp.toUpperCase(),
      onTap2: () {
        AppNavigation.navigateToRemovingAll(
          context,
          AppRoutes.loginScreenRoute,
        );
        AppNavigation.navigateTo(context, AppRoutes.signupScreenRoute);
      },
    );
  }
}
