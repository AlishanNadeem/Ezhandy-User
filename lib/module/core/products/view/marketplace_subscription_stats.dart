import 'package:ezhandy_user/module/core/products/controller/marketplace_subscription_controller.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MarketplaceSubscriptionStats extends StatefulWidget {
  const MarketplaceSubscriptionStats({super.key});

  @override
  State<MarketplaceSubscriptionStats> createState() =>
      _MarketplaceSubscriptionStatsState();
}

class _MarketplaceSubscriptionStatsState
    extends State<MarketplaceSubscriptionStats> {
  MarketplaceSubscriptionController get _controller {
    if (Get.isRegistered<MarketplaceSubscriptionController>()) {
      return Get.find<MarketplaceSubscriptionController>();
    }
    return Get.put(MarketplaceSubscriptionController());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: AppStrings.subscriptionStats,
      appBarheight: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: Obx(() {
          final status = _controller.status.value;
          final loading =
              _controller.isLoadingStatus.value && status == null;

          if (loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (status == null || !status.hasActiveSubscription) {
            return RefreshIndicator(
              onRefresh: _controller.fetchStatus,
              color: AppColors.orange,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 48.h),
                    child: CustomText(
                      text: AppStrings.noActiveMarketplaceSubscription,
                      color: AppColors.greyLight,
                      is_alignLeft: false,
                    ),
                  ),
                ],
              ),
            );
          }

          final planLabel = status.planTitle.isNotEmpty
              ? status.planTitle
              : AppStrings.subscription;
          final durationLabel = status.planDuration;
          final max = status.maxProducts <= 0 ? 1 : status.maxProducts;
          final progress = (status.usedProducts / max).clamp(0.0, 1.0);
          final remainingColor =
              status.remainingProducts > 0 ? AppColors.green : AppColors.red;

          return RefreshIndicator(
            onRefresh: _controller.fetchStatus,
            color: AppColors.orange,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: AppPadding.padding20,
                bottom: AppPadding.padding25,
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppPadding.padding12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: AppColors.orange.withOpacity(0.22),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.orange.withOpacity(0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: AppColors.orange.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.storefront_rounded,
                              color: AppColors.orange,
                              size: 22.sp,
                            ),
                          ),
                          10.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: planLabel,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                                if (durationLabel.isNotEmpty) ...[
                                  2.verticalSpace,
                                  CustomText(
                                    text: durationLabel,
                                    fontSize: 11.sp,
                                    color: AppColors.greyLight,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.green.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: CustomText(
                              text: AppStrings.active,
                              color: AppColors.green,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              is_alignLeft: false,
                            ),
                          ),
                        ],
                      ),
                      14.verticalSpace,
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.productsUsed,
                            fontSize: 11.sp,
                            color: AppColors.greyLight,
                          ),
                          const Spacer(),
                          CustomText(
                            text:
                                '${status.usedProducts}/${status.maxProducts}',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            is_alignLeft: false,
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8.h,
                          backgroundColor:
                              AppColors.greyBorder.withOpacity(0.5),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            status.remainingProducts > 0
                                ? AppColors.orange
                                : AppColors.red,
                          ),
                        ),
                      ),
                      12.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: _statChip(
                              label: AppStrings.remainingProducts,
                              value: '${status.remainingProducts}',
                              valueColor: remainingColor,
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: _statChip(
                              label: AppStrings.currentPlan,
                              value: durationLabel.isNotEmpty
                                  ? durationLabel
                                  : AppStrings.subscription,
                              valueColor: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                      12.verticalSpace,
                      _actionRow(
                        icon: Icons.workspace_premium_rounded,
                        label: AppStrings.upgradeYourPlan,
                        onTap: () {
                          AppNavigation.navigateTo(
                            context,
                            AppRoutes.marketplaceSubscriptionPlansScreenRoute,
                          );
                        },
                      ),
                      8.verticalSpace,
                      _actionRow(
                        icon: Icons.history_rounded,
                        label: AppStrings.subscriptionLogs,
                        onTap: () {
                          AppNavigation.navigateTo(
                            context,
                            AppRoutes.marketplaceSubscriptionLogsScreenRoute,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _actionRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.orange.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: AppColors.orange,
            ),
            8.horizontalSpace,
            Expanded(
              child: CustomText(
                text: label,
                color: AppColors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.sp,
              color: AppColors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _statChip({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.greyBorder.withOpacity(0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            fontSize: 10.sp,
            color: AppColors.greyLight,
          ),
          4.verticalSpace,
          CustomText(
            text: value,
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ],
      ),
    );
  }
}
