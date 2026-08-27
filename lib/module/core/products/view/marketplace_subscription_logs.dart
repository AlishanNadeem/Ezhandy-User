import 'package:ezhandy_user/module/core/products/controller/marketplace_subscription_controller.dart';
import 'package:ezhandy_user/module/core/products/model/marketplace_subscription_status.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MarketplaceSubscriptionLogs extends StatefulWidget {
  const MarketplaceSubscriptionLogs({super.key});

  @override
  State<MarketplaceSubscriptionLogs> createState() =>
      _MarketplaceSubscriptionLogsState();
}

class _MarketplaceSubscriptionLogsState
    extends State<MarketplaceSubscriptionLogs> {
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
      _controller.loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: AppStrings.subscriptionLogs,
      appBarheight: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: Obx(() {
          if (_controller.isLoadingHistory.value &&
              _controller.history.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final list = _controller.history;
          return RefreshIndicator(
            onRefresh: _controller.loadHistory,
            color: AppColors.orange,
            child: list.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 48.h),
                        child: CustomText(
                          text: AppStrings.noSubscriptionLogsFound,
                          color: AppColors.greyLight,
                          is_alignLeft: false,
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: AppPadding.padding20,
                      bottom: AppPadding.padding25,
                    ),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => 12.verticalSpace,
                    itemBuilder: (context, index) {
                      return _historyCard(list[index]);
                    },
                  ),
          );
        }),
      ),
    );
  }

  Widget _historyCard(MarketplaceSubscriptionHistoryItem item) {
    final statusColor =
        item.isActive ? AppColors.green : AppColors.red;
    final planLabel = item.planTitle.isNotEmpty
        ? item.planTitle
        : AppStrings.subscription;
    final durationLabel =
        item.planDuration.isNotEmpty ? ' (${item.planDuration})' : '';

    return CustomContainer(
      borderColor: item.isActive ? AppColors.orange : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomText(
                  text: '$planLabel$durationLabel',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              CustomText(
                text: item.status,
                color: statusColor,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                is_alignLeft: false,
              ),
            ],
          ),
          10.verticalSpace,
          _infoRow(
            AppStrings.amountPaid,
            item.amount.isNotEmpty ? '\$${item.amount}' : '—',
          ),
          4.verticalSpace,
          _infoRow(
            AppStrings.paymentMethod,
            item.paymentMethod.isNotEmpty
                ? item.paymentMethod.toUpperCase()
                : '—',
          ),
          4.verticalSpace,
          _infoRow(AppStrings.subscribedOn, _formatDate(item.startDate)),
          4.verticalSpace,
          _infoRow(AppStrings.expiresOn, _formatDate(item.endDate)),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            text: label,
            fontSize: 12.sp,
            color: AppColors.greyLight,
          ),
        ),
        CustomText(
          text: value,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          is_alignLeft: false,
        ),
      ],
    );
  }

  String _formatDate(String raw) {
    if (raw.isEmpty) return '—';
    final dt = DateTime.tryParse(raw);
    if (dt == null) return raw;
    return DateFormat('dd MMM yyyy').format(dt.toLocal());
  }
}
