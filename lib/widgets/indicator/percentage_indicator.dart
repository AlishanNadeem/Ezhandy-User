// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentageIndicator extends StatelessWidget {
  double percent;
  PercentageIndicator({required this.percent, super.key});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      // width: 1.sw,
      lineHeight: 8.h,
      percent: percent,
      backgroundColor: AppColors.greyBorder,
      progressColor: AppColors.orange,
      barRadius: Radius.circular(9),
    );
  }
}
