import 'package:ezhandy_user/module/core/transaction_history/transaction_history_controller.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  TransactionHistoryController get _controller {
    if (Get.isRegistered<TransactionHistoryController>()) {
      return Get.find<TransactionHistoryController>();
    }
    return Get.put(TransactionHistoryController());
  }

  static const List<String?> _tabTypeFilters = [
    null, // All
    'booking_payment', // Payments
    'refund', // Refunds
    'referral', // Referrals
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _tabTypeFilters.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    if (Get.isRegistered<TransactionHistoryController>()) {
      Get.delete<TransactionHistoryController>();
    }
    super.dispose();
  }

  List<Map<String, dynamic>> _filteredList(
      List<Map<String, dynamic>> list, String? typeFilter) {
    if (typeFilter == null) return list;
    return list.where((row) => row['type']?.toString() == typeFilter).toList();
  }

  // String? filterStartValue;
  // var filterList = ["All", "Weekly", "Monthly"];
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.transactionHistory,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greyBorder.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.orange,
                  ),
                  dividerColor: AppColors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor:
                      const WidgetStatePropertyAll(AppColors.transparent),
                  onTap: (index) {
                    setState(() {});
                  },
                  tabs: [
                    _tabLabel(AppStrings.all, 0),
                    _tabLabel(AppStrings.payments, 1),
                    _tabLabel(AppStrings.refunds, 2),
                    _tabLabel(AppStrings.referrals, 3),
                  ],
                ),
              ),
              10.verticalSpace,
              Expanded(
                child: Obx(() {
                  if (_controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final list = _filteredList(
                      _controller.items, _tabTypeFilters[_tabController.index]);
                  return RefreshIndicator(
                    onRefresh: _controller.fetchTransactions,
                    color: AppColors.orange,
                    child: list.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 48.h),
                                child: CustomText(
                                  text: AppStrings.noTransactionsFound,
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
                                bottom: AppPadding.padding25),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final row = list[index];
                              return singleWidget(
                                date: _formatCreatedAt(
                                    row['date'] ?? row['createdAt']),
                                additionalFee:
                                    _formatCommission(row['commission']),
                                label: _labelForUi(row),
                                total: _amountForUi(row),
                                amountColor: _amountColor(row),
                                type: row['type']?.toString(),
                                provider: row['provider']?.toString(),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return 10.verticalSpace;
                            },
                          ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  Tab _tabLabel(String label, int index) {
    return Tab(
      child: ListenableBuilder(
        listenable: _tabController,
        builder: (context, _) {
          final selected = _tabController.index == index;
          return CustomText(
            text: label,
            is_alignLeft: false,
            fontSize: 12.sp,
            fontFamily: AppStrings.montserrat,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? AppColors.white : AppColors.black,
          );
        },
      ),
    );
  }

  String _formatCreatedAt(dynamic createdAt) {
    if (createdAt == null) return '';
    final dt = DateTime.tryParse(createdAt.toString());
    if (dt == null) return createdAt.toString();
    return DateFormat('dd MMM yyyy, hh:mm a').format(dt.toLocal());
  }

  String _formatCommission(dynamic commission) {
    if (commission == null) return '\$0';
    return '\$${commission.toString()}';
  }

  String _labelForUi(Map<String, dynamic> row) {
    return row['label']?.toString() ??
        row['referenceId']?.toString() ??
        row['id']?.toString() ??
        '—';
  }

  String _amountForUi(Map<String, dynamic> row) {
    final v = row['totalAmount'] ?? row['amount'];
    if (v == null) return '+\$0.00';
    final amount = double.tryParse(v.toString().replaceAll(',', '')) ?? 0;
    final absFormatted = amount.abs().toStringAsFixed(2);
    return amount < 0 ? '-\$$absFormatted' : '+\$$absFormatted';
  }

  Color _amountColor(Map<String, dynamic> row) {
    final v = row['totalAmount'] ?? row['amount'];
    final amount = double.tryParse(v?.toString().replaceAll(',', '') ?? '0') ?? 0;
    return amount < 0 ? AppColors.red : AppColors.green;
  }

  Widget singleWidget(
      {date, label, additionalFee, total, type, provider, Color? amountColor}) {
    final showProvider =
        type != 'booking_payment' && provider != null && provider != '';

    return CustomContainer(
      child: Column(
        children: [
          5.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: date,
                color: AppColors.greyLight,
                fontSize: 10.sp,
              ),
              // CustomText(
              //   text: "${AppStrings.additional}: $additionalFee",
              //   color: AppColors.greyLight,
              //   fontSize: 10.sp,
              // )
            ],
          ),
          10.verticalSpace,
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    text: label,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    // color: AppColors.greyLight,
                    // fontSize: 14.sp,
                  ),
                ),
                CustomText(
                  text: total,
                  color: amountColor ?? AppColors.green,
                  fontWeight: FontWeight.bold,
                  // fontSize: 14.sp,
                )
              ]),
          if (showProvider) ...[
            5.verticalSpace,
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: "Provider: $provider",
                color: AppColors.greyLight,
                fontSize: 10.sp,
              ),
            ),
          ],
          5.verticalSpace,
        ],
      ),
    );
  }
}
