import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomSlidableWidget extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onTapPin;
  final bool? isenable;
  final bool enablePin;

  CustomSlidableWidget({
    super.key,
    required this.child,
    this.onTap,
    this.isenable,
    this.onTapPin,
    this.enablePin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: isenable ?? true,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onTap?.call(),
            backgroundColor: AppColors.transparent,
            foregroundColor: AppColors.white,
            icon: Icons.delete,
            label: AppStrings.delete,
          ),
        ],
      ),
      startActionPane: enablePin
          ? ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => onTapPin?.call(),
                  backgroundColor: AppColors.transparent,
                  foregroundColor: AppColors.white,
                  icon: Icons.push_pin,
                  label: 'Pin',
                ),
              ],
            )
          : null,
      child: child,
    );
  }
}