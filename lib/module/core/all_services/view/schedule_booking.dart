import 'package:ezhandy_user/module/core/booking/routing_arguments/booking_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/calendar/calendar.dart';
import 'package:ezhandy_user/widgets/checkbox/custom_checkbox.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/terms_privacy_text_widget.dart';
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

class ScheduleBooking extends StatefulWidget {
  // String? serviceName;
  ScheduleBooking({super.key});

  @override
  State<ScheduleBooking> createState() => _ScheduleBookingState();
}

class _ScheduleBookingState extends State<ScheduleBooking> {
  String methodValue =   "Morning (8am - 12pm)";
  int? currentHourIndex;
  List<String> shiftList = [
    "Morning (8am - 12pm)",
    "Afternoon (12pm - 5pm)",
    "Evening (5pm - 9:30pm)"
  ];
  // String? filterStartValue;

  // bool isLike=false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.scheduleABooking,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    calendarWidget(),
                    15.verticalSpace,
                    CustomText(
                        text: AppStrings.availabilityHour,
                        // color: AppColors.blueDark,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                    10.verticalSpace,
                    hourListWidget(),
                    10.verticalSpace,
                  ],
                ),
              )),
              btnWidget(context),
              20.verticalSpace
            ])));
  }

  CustomCalendar calendarWidget() {
    return CustomCalendar(
      highlightedDates: [
        DateTime(2021, 9, 2),
        DateTime(2021, 9, 6),
        DateTime(2021, 9, 15),
        DateTime(2021, 9, 18),
        DateTime(2021, 9, 24),
        DateTime(2021, 9, 28),
      ],
      initialFocusedDate: DateTime(2021, 9, 1), // optional
      onDateSelected: (date) {
        print('Selected: $date');
      },
    );
  }

  Widget hourListWidget() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      // scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.padding12),
          child: CheckBoxWidget(
              isChecked: methodValue == shiftList[index],
              ontapCheck: () {
                setState(() {
                  methodValue = shiftList[index];
                });
              },
              title: shiftList[index]),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
        );
      },
      itemCount: shiftList.length,
    );
  }

  CustomContainer availabilityHour({onTap, required bool isChecked}) {
    return CustomContainer(
      onTap: onTap,
      radius: 25.r,
      child: Row(
        children: [
          Image.asset(
            AssetPath.timeIcon,
            width: 24.w,
            height: 24.h,
          ),
          10.horizontalSpace,
          CustomText(text: "${AppStrings.dummytime} - ${AppStrings.dummytime}"),
          Spacer(),
          isChecked
              ? Icon(Icons.check, color: AppColors.blueDark)
              : SizedBox.shrink(),
          10.horizontalSpace,
        ],
      ),
    );
  }

  CustomButton btnWidget(BuildContext context) {
    return CustomButton(
      text: AppStrings.next,
      onclick: () {
          AppNavigation.navigateTo(
            context,
            AppRoutes.serviceSelectionScreenRoute,
          );
      
      
      },
    );
  }
}
