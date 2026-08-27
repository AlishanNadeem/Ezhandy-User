import 'package:ezhandy_user/module/core/notification/controller/notification_controller.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationBellButton extends StatelessWidget {
  const NotificationBellButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 28.w,
        height: 28.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Bell stays outside Obx so count updates don't rebuild the icon.
            Image.asset(AssetPath.bellIcon, width: 20.w, height: 20.h),
            Obx(() {
              final count = NotificationController.i.unreadCount.value;
              if (count <= 0) return const SizedBox.shrink();
              return Positioned(
                right: -2,
                top: -2,
                child: Container(
                  constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    count > 99 ? '99+' : '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
