import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';

// ignore: must_be_immutable
class SlidableWidget extends StatelessWidget {
  final Widget child;
  final Key? slidkey;
  final Function()? onTap;
  final bool? isSlideable;

  SlidableWidget({
    super.key,
    this.slidkey,
    required this.child,
    this.onTap,
    this.isSlideable,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: slidkey,
      enabled: isSlideable ?? true,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        // 👇 Set totalFlex to 4 (100%), and we'll use 1/4 of it
        extentRatio: 0.25, // Optional: Also enforces 1/4 width slide
        children: [
          CustomSlidableAction(
  flex: 1,
  onPressed: (context) => onTap?.call(),
  backgroundColor: Colors.transparent, // 👈 Make transparent so child color shows
  child: Container(
    decoration: BoxDecoration(
      color: AppColors.red,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
    ),
    alignment: Alignment.center,
    child: Image.asset(
      AssetPath.deleteIcon,
      height: 30.h,
      width: 30.w,
      color: AppColors.white,
    ),
  ),
),  ],
      ),
      child: child,
    );
  }
}
