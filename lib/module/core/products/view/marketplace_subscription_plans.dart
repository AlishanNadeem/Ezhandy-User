import 'package:ezhandy_user/module/core/products/controller/marketplace_subscription_controller.dart';
import 'package:ezhandy_user/module/core/products/data/repository/marketplace_subscription_checkout_repository.dart';
import 'package:ezhandy_user/module/core/products/model/marketplace_subscription_status.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MarketplaceSubscriptionPlans extends StatefulWidget {
  const MarketplaceSubscriptionPlans({super.key});

  @override
  State<MarketplaceSubscriptionPlans> createState() =>
      _MarketplaceSubscriptionPlansState();
}

class _MarketplaceSubscriptionPlansState
    extends State<MarketplaceSubscriptionPlans> {
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
      _controller.loadPlans();
    });
  }

  void _subscribe() {
    final plan = _controller.selectedPlan;
    if (plan == null) {
      AppDialogs.showToast(message: AppStrings.pleaseSelectAPlan);
      return;
    }

    if (_controller.isCurrentActivePlan(plan.id)) {
      AppDialogs.showToast(message: AppStrings.alreadyOnThisPlan);
      return;
    }

    MarketplaceSubscriptionCheckoutRepository().startCheckout(
      context,
      planId: plan.id,
      onSuccess: () {
        _controller.fetchStatus();
        AppDialogs.showToast(message: AppStrings.subscribedSuccessful);
        if (mounted) {
          Get.back();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: AppStrings.marketplaceSubscriptions,
      appBarheight: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: Obx(() {
          if (_controller.isLoadingPlans.value &&
              _controller.plans.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final list = _controller.plans;
          final selectedId = _controller.selectedPlanId.value;
          final alreadyActive = _controller.isSelectedPlanAlreadyActive;
          // Touch status so Obx rebuilds when active plan loads.
          _controller.status.value;

          if (list.isEmpty) {
            return RefreshIndicator(
              onRefresh: _controller.loadPlans,
              color: AppColors.orange,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 48.h),
                    child: CustomText(
                      text: AppStrings.noSubscriptionPlansFound,
                      color: AppColors.greyLight,
                      is_alignLeft: false,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _controller.loadPlans,
                  color: AppColors.orange,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: AppPadding.padding20,
                      bottom: AppPadding.padding16,
                    ),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => 12.verticalSpace,
                    itemBuilder: (context, index) {
                      final plan = list[index];
                      return _planCard(
                        plan,
                        isSelected: selectedId == plan.id,
                        isCurrent: _controller.isCurrentActivePlan(plan.id),
                      );
                    },
                  ),
                ),
              ),
              CustomButton(
                text: alreadyActive
                    ? AppStrings.alreadyOnThisPlan
                    : AppStrings.subscribe,
                color: alreadyActive ? AppColors.greyBorder : AppColors.orange,
                textcolor:
                    alreadyActive ? AppColors.greyLight : AppColors.white,
                onclick: (selectedId == null || alreadyActive)
                    ? null
                    : _subscribe,
              ),
              20.verticalSpace,
            ],
          );
        }),
      ),
    );
  }

  Widget _planCard(
    MarketplaceSubscriptionPlan plan, {
    required bool isSelected,
    required bool isCurrent,
  }) {
    return GestureDetector(
      onTap: () => _controller.selectPlan(plan.id),
      child: CustomContainer(
        borderColor: isSelected || isCurrent
            ? AppColors.orange
            : AppColors.greyBorder,
        bgColor: isSelected
            ? AppColors.orange.withOpacity(0.06)
            : AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    text: plan.title,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                if (isCurrent)
                  Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      text: AppStrings.currentPlan,
                      color: AppColors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      is_alignLeft: false,
                    ),
                  )
                else if (plan.popular)
                  Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      text: AppStrings.popular,
                      color: AppColors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      is_alignLeft: false,
                    ),
                  ),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected ? AppColors.orange : AppColors.greyLight,
                  size: 22.sp,
                ),
              ],
            ),
            6.verticalSpace,
            CustomText(
              text: plan.price.isNotEmpty
                  ? '${plan.price}${plan.duration.isNotEmpty ? ' / ${plan.duration}' : ''}'
                  : '\$${plan.priceValue}${plan.duration.isNotEmpty ? ' / ${plan.duration}' : ''}',
              color: AppColors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
            8.verticalSpace,
            CustomText(
              text: '${AppStrings.maxProductsLabel}: ${plan.maxProducts}',
              fontSize: 12.sp,
              color: AppColors.greyLight,
            ),
            if (plan.features.isNotEmpty) ...[
              12.verticalSpace,
              ...plan.features.map(
                (feature) => Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
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
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
