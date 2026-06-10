import 'package:ezhandy_user/module/core/notification/controller/notification_controller.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController get _controller {
    if (Get.isRegistered<NotificationController>()) {
      return Get.find<NotificationController>();
    }
    return Get.put(NotificationController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<NotificationController>()) {
      Get.delete<NotificationController>();
    }
    super.dispose();
  }

  DateTime? _parseNotificationDate(dynamic value) {
    if (value == null) return null;
    if (value is Map && value.isEmpty) return null;
    final text = value.toString().trim();
    if (text.isEmpty || text == '{}') return null;
    return DateTime.tryParse(text);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.notifications,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              filterRowWidget(),
              Expanded(
                child: Obx(() {
                  if (_controller.isLoading.value &&
                      _controller.notifications.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final items = _controller.filteredNotifications;
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final notificationId = item['id']?.toString() ?? '';
                      return SlidableWidget(
                        child: GestureDetector(
                          onTap: notificationId.isEmpty
                              ? null
                              : () => _controller.markAsRead(notificationId),
                          behavior: HitTestBehavior.opaque,
                          child: notificationWidget(
                            isUnRead: !NotificationController.isNotificationRead(item),
                            image: AssetPath.infoIcon,
                            title: item['title']?.toString() ?? '',
                            description: item['description']?.toString() ?? '',
                            date: _parseNotificationDate(item['createdAt']),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return 20.verticalSpace;
                    },
                  );
                }),
              ),
              20.verticalSpace,
            ],
          ),
        ));
  }

  Widget notificationWidget({
    isUnRead,
    image,
    title,
    description,
    DateTime? date,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.orange,
            ),
            child: Image.asset(
              image,
              width: 14.w,
              height: 14.h,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontWeight: FontWeight.w600,
                ),
                4.verticalSpace,
                CustomText(
                  text: description,
                ),
                if (date != null) ...[
                  4.verticalSpace,
                  Text(
                    DateFormat("dd MMM yyyy - HH:mm a").format(date.toLocal()),
                    style: const TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
                ],
              ],
            ),
          ),
          Visibility(
            visible: isUnRead,
            child: CircleAvatar(
              radius: 5.sp,
              backgroundColor: AppColors.orange,
            ),
          )
        ],
      ),
    );
  }

  Row filterRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [CustomText(text: AppStrings.showing), filterDropDown()],
    );
  }

  Widget filterDropDown() {
    return Obx(
      () => CustomDropDown2(
        width: 110.w,
        dropDownWidth: 150.w,
        dropDownData: NotificationController.readFilterOptions,
        borderColor: AppColors.transparent,
        hintText: "All",
        dropdownValue: _controller.readFilter.value,
        dropdownListColor: AppColors.white,
        hintTextColor: AppColors.black,
        onChanged: (value) {
          _controller.updateReadFilter(value.toString());
        },
      ),
    );
  }
}
