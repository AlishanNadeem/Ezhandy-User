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

class _TransactionHistoryState extends State<TransactionHistory> {
  TransactionHistoryController get _controller {
    if (Get.isRegistered<TransactionHistoryController>()) {
      return Get.find<TransactionHistoryController>();
    }
    return Get.put(TransactionHistoryController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<TransactionHistoryController>()) {
      Get.delete<TransactionHistoryController>();
    }
    super.dispose();
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
          child: Obx(() {
            if (_controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            final list = _controller.items;
            if (list.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 48.h),
                  child: CustomText(
                    text: AppStrings.noTransactionsFound,
                    color: AppColors.greyLight,
                    is_alignLeft: false,
                  ),
                ),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.only(
                  top: AppPadding.padding20, bottom: AppPadding.padding25),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final row = list[index];
                return singleWidget(
                  date: _formatCreatedAt(row['createdAt']),
                  additionalFee: _formatCommission(row['commission']),
                  bookingId: _bookingIdForUi(row),
                  total: _amountForUi(row),
                );
              },
              separatorBuilder: (context, index) {
                return 10.verticalSpace;
              },
            );
          }),
        ));
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

  String _bookingIdForUi(Map<String, dynamic> row) {
    final ids = row['bookingIds'];
    if (ids is List && ids.isNotEmpty) {
      return ids.first.toString();
    }
    return row['referenceId']?.toString() ??
        row['id']?.toString() ??
        '—';
  }

  String _amountForUi(Map<String, dynamic> row) {
    final v = row['totalAmount'] ?? row['amount'];
    if (v == null) return '0';
    return v.toString();
  }

  Widget singleWidget({date, bookingId, additionalFee, total}) {
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
              CustomText(
                text: "${AppStrings.additional}: $additionalFee",
                color: AppColors.greyLight,
                fontSize: 10.sp,
              )
            ],
          ),
          10.verticalSpace,
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "${AppStrings.bookingId}: #$bookingId",
                  fontWeight: FontWeight.bold,
                  // color: AppColors.greyLight,
                  // fontSize: 14.sp,
                ),
                CustomText(
                  text: "\$ $total",
                  color: AppColors.orange,
                  // fontSize: 14.sp,
                )
              ]),
          5.verticalSpace,
        ],
      ),
    );
  }
}
