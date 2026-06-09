import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/affiliate_earning/controller/affiliate_earning_controller.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/toast.dart';

class AffiliateEarning extends StatefulWidget {
  const AffiliateEarning({super.key});

  @override
  State<AffiliateEarning> createState() => _AffiliateEarningState();
}

class _AffiliateEarningState extends State<AffiliateEarning> {
  AffiliateEarningController get _controller {
    if (Get.isRegistered<AffiliateEarningController>()) {
      return Get.find<AffiliateEarningController>();
    }
    return Get.put(AffiliateEarningController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<AffiliateEarningController>()) {
      Get.delete<AffiliateEarningController>();
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
        title: AppStrings.affiliateEarning,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      20.verticalSpace,
                      CustomText(
                          text: AppStrings.yourReferralCode,
                          is_alignLeft: false,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Obx(() {
                          final apiCode = _controller
                              .referralData.value?['referralCode']
                              ?.toString()
                              .trim();
                          final authCode = AuthController.i
                                  .appUser
                                  .value
                                  .data
                                  ?.userModel
                                  ?.referralCode
                                  ?.trim() ??
                              '';
                          final code = (apiCode != null && apiCode.isNotEmpty)
                              ? apiCode
                              : authCode;
                          final display = code.isNotEmpty ? code : '—';
                          return CustomContainer(
                            borderColor: AppColors.orange,
                            isPadding: false,
                            radius: 35.r,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomText(
                                      text: display,
                                      color: AppColors.orange,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                  20.horizontalSpace,
                                  CustomButton(
                                    borderRadius: 35.r,
                                    width: 80.w,
                                    text: "Copy",
                                    onclick: code.isEmpty
                                        ? null
                                        : () async {
                                            await Clipboard.setData(
                                              ClipboardData(text: code),
                                            );
                                            ToastMessage(
                                              toastmsg:
                                                  'Referral code copied to clipboard',
                                            );
                                          },
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      20.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 90.w),
                        child: Obx(() {
                          final raw =
                              _controller.referralData.value?['totalEarned'];
                          final amountLabel = _earningLabel(raw);
                          return CustomContainer(
                            borderColor: AppColors.orange,
                            child: Column(
                              children: [
                                CustomText(
                                  text: amountLabel,
                                  color: AppColors.orange,
                                  is_alignLeft: false,
                                ),
                                CustomText(
                                  text: AppStrings.totalEarnings,
                                  is_alignLeft: false,
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                      20.verticalSpace,
                      Obx(() {
                        final list = _controller.referrals;
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final r = list[index];
                            return singleWidget(
                              name: r['referredUserName']?.toString() ??
                                  AppStrings.dummyName,
                              lastMes: r['referredEmail']?.toString() ??
                                  AppStrings.lorem5,
                              earning: r['earning'],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return 20.verticalSpace;
                          },
                        );
                      }),
                      25.verticalSpace,
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: AppStrings.withdraw,
                onclick: () {
                  AppDialogs.showSuccessDialog(context,
                      description: AppStrings.amountToBankAccount,
                      title: AppStrings.withdraw + "!",
                      image: AssetPath.bankIcon,
                      isDoneShow: false,
                      btnTxt1: AppStrings.cancel,
                      onTap1: () {
                        AppNavigation.navigatorPop(context);
                      },
                      btnTxt2: AppStrings.confirm,
                      onTap2: () {
                        AppNavigation.navigatorPop(context);
                      });
                },
              ),
              25.verticalSpace
            ],
          ),
        ));
  }

  /// Matches previous placeholder style; uses API [totalEarned] when present.
  String _earningLabel(dynamic v) {
    if (v == null) return AppStrings.dummyAmount;
    final n = v is num ? v.toDouble() : double.tryParse(v.toString());
    if (n == null) return AppStrings.dummyAmount;
    if (n == n.roundToDouble()) {
      return '\$${n.toInt()}';
    }
    return '\$${n.toStringAsFixed(2)}';
  }

  String _earningSuffix(dynamic v) {
    if (v == null) return '\$0';
    final n = v is num ? v.toDouble() : double.tryParse(v.toString());
    if (n == null) return '\$0';
    if (n == n.roundToDouble()) {
      return '\$${n.toInt()}';
    }
    return '\$${n.toStringAsFixed(2)}';
  }

  Widget singleWidget({
    required dynamic name,
    required dynamic lastMes,
    dynamic earning,
  }) {
    return CustomContainer(
      isPadding: false,
      child: Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.padding14,
            bottom: AppPadding.padding14,
            left: AppPadding.padding14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserImageWidget(),
            5.horizontalSpace,
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  CustomText(
                    text: name,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: lastMes,
                    maxLines: 1,
                    fontSize: 12.sp,
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.r),
                      bottomLeft: Radius.circular(35.r))),
              child: CustomText(
                text: _earningSuffix(earning),
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
