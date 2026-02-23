import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? errorText;
  final double? imageSize;
  final double? textSize;
  int? heightPadding;
  final Color? imageColor;
  final Color? textColor;

  CustomErrorWidget(
      {this.errorText,
      this.heightPadding,
      this.imageSize,
      this.imageColor,
      this.textColor,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (heightPadding ?? 00).verticalSpace,
          Image.asset(
            AssetPath.noDataFoundIcon,
            width: imageSize ?? 70.h,
            color: AppColors.grey,
          ),
          // : Container(),
          SizedBox(
            height: 12.0,
          ),
          CustomText(
            is_alignLeft: false,
            text: errorText,
            fontSize: textSize?.sp ?? 16.sp,
            maxLines: 2,

            textAlign: TextAlign.center,
            // overflow: TextOverflow.ellipsis,
            color: textColor ?? AppColors.grey,
            //fontweight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
