import 'package:ezhandy_user/module/core/community/model/ask_pro_pricing_model.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_dialoge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AskProPricingDialog extends StatelessWidget {
  const AskProPricingDialog({
    super.key,
    required this.pricing,
    required this.onCancel,
    this.onContinue,
    this.showContinue = true,
  });

  final AskProPricing pricing;
  final VoidCallback? onContinue;
  final VoidCallback onCancel;
  final bool showContinue;

  @override
  Widget build(BuildContext context) {
    return CustomDialogs(
      image: AssetPath.proUserIcon,
      isDoneShow: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AssetPath.proUserIcon,
            scale: 4.sp,
          ),
          10.verticalSpace,
          CustomText(
            text: pricing.amountLabel.isNotEmpty
                ? pricing.amountLabel
                : '\$${pricing.amount.toStringAsFixed(2)}',
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            is_alignLeft: false,
            textDecoration: TextDecoration.none,
          ),
          10.verticalSpace,
          if (pricing.description.isNotEmpty)
            CustomText(
              text: pricing.description,
              is_alignLeft: false,
              textAlign: TextAlign.center,
              color: AppColors.greyLight,
              textDecoration: TextDecoration.none,
            ),
          if (pricing.features.isNotEmpty) ...[
            16.verticalSpace,
            ...pricing.features.map(
              (feature) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16.sp,
                      color: AppColors.orange,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: CustomText(
                        text: feature,
                        fontSize: 13.sp,
                        color: AppColors.black,
                        textDecoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          24.verticalSpace,
          if (showContinue)
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderRadius: 35.r,
                    text: AppStrings.continuee,
                    onclick: onContinue ?? () {},
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: CustomButton(
                    borderRadius: 35.r,
                    text: AppStrings.cancel,
                    onclick: onCancel,
                    color: AppColors.black,
                  ),
                ),
              ],
            )
          else
            CustomButton(
              borderRadius: 35.r,
              text: AppStrings.cancel,
              onclick: onCancel,
              color: AppColors.black,
            ),
        ],
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required AskProPricing pricing,
    VoidCallback? onContinue,
    VoidCallback? onDismiss,
    bool showContinue = true,
  }) {
    return showDialog<void>(
      barrierDismissible: false,
      barrierColor: AppColors.orange.withOpacity(0.8),
      context: context,
      builder: (dialogContext) {
        return AskProPricingDialog(
          pricing: pricing,
          showContinue: showContinue,
          onContinue: onContinue == null
              ? null
              : () {
                  AppNavigation.navigateCloseDialog(dialogContext);
                  onContinue();
                },
          onCancel: () {
            AppNavigation.navigatorPop(dialogContext);
          },
        );
      },
    ).whenComplete(() => onDismiss?.call());
  }
}
