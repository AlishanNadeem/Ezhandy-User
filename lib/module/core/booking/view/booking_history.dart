import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/routes/routing_arguments/booking_routing_arguments.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  // String? filterStartValue;
  var statusList = [
    // AppStrings.pending,
    AppStrings.rejected,
    // AppStrings.accepted,
    AppStrings.cancelled,
    // AppStrings.inRoute,
    // AppStrings.started,
    AppStrings.completedUnPaid,
    AppStrings.completedPaid,
    // AppStrings.assigned,
  ];
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        // appBarheight: 50.h,
        title: AppStrings.bookingHistory,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              10.verticalSpace,
                   
              searchTextField(),
              10.verticalSpace,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                      top: AppPadding.padding20, bottom: AppPadding.padding25),
                  shrinkWrap: true,
                  itemCount: statusList.length,
                  itemBuilder: (context, index) {
                    // final item = notifications[index];
                    return singleWidget(
                      ontap: () {
                        AppNavigation.navigateTo(
                            context, AppRoutes.bookingScreenRoute,
                            arguments: BookingRoutingArgument(
                                Status: statusList[index]));
                      },
                      date: AppStrings.dummyDate,
                      status: statusList[index],
                      // additionalFee: "15\$",
                      bookingId: "1234567",
                      total: "10",
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 10.verticalSpace;
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget searchTextField() {
    return CustomTextField(
      label: false,
      prefxicon: AssetPath.searchIcon,
      hint: AppStrings.searchAnything,
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      // controller: firstNameController,
    );
  }



  Widget singleWidget({date, bookingId, status, total, ontap}) {
    return CustomContainer(
      onTap: ontap,
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
                text: "${AppStrings.status}: $status",
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

  // String statusType(String? status) {
  //   switch (status) {
  //     case AppStrings.inProgress:
  //       return BookingType.InProcess.name;
  //     case AppStrings.past:
  //       return BookingType.Past.name;
  //     case AppStrings.pending:
  //       return BookingType.Pending.name;
  //     case AppStrings.rejected:
  //       return BookingType.Rejected.name;
  //     case AppStrings.reschedule:
  //       return BookingType.Reschedule.name;
  //     case AppStrings.upcoming:
  //       return BookingType.Upcoming.name;
  //     default:
  //       return 'N/A';
  //   }
  // }
}
