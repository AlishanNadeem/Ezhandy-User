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
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
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
        child:
        
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: ListView.separated(
            padding: EdgeInsets.only(
                top: AppPadding.padding20, bottom: AppPadding.padding25),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              // final item = notifications[index];
              return singleWidget(
                date: AppStrings.dummyDate,
                visitTime: "10S",
                additionalFee: "15\$",
                bookingId: "1234567",
                total: "10",
              );
            },
            separatorBuilder: (context, index) {
              return 10.verticalSpace;
            },
          ),
        ));
  
  
  
  }

  Widget singleWidget({date, bookingId, visitTime, additionalFee, total}) {
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
                text:
                    "${AppStrings.visit}: $visitTime ${AppStrings.additional}: $additionalFee",
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
