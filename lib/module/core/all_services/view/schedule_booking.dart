import 'package:ezhandy_user/module/core/all_services/controller/schedule_booking_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
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
  final String? providerServiceId;
  final String? providerId;
  final int? serviceId;
  final String? type;

  const ScheduleBooking({
    this.providerServiceId,
    this.providerId,
    this.serviceId,
    this.type,
    super.key,
  });

  factory ScheduleBooking.fromArgs(ServiceRoutingArgument? args) {
    return ScheduleBooking(
      providerServiceId: args?.providerServiceId,
      providerId: args?.providerId,
      serviceId: args?.serviceId,
      type: args?.type,
    );
  }

  @override
  State<ScheduleBooking> createState() => _ScheduleBookingState();
}

class _ScheduleBookingState extends State<ScheduleBooking> {
  String get _controllerTag =>
      'schedule_booking_${widget.providerServiceId ?? 'none'}';

  ScheduleBookingController? get _controller {
    final id = widget.providerServiceId?.trim() ?? '';
    if (id.isEmpty) return null;
    if (Get.isRegistered<ScheduleBookingController>(tag: _controllerTag)) {
      return Get.find<ScheduleBookingController>(tag: _controllerTag);
    }
    return Get.put(
      ScheduleBookingController(providerServiceId: id),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<ScheduleBookingController>(tag: _controllerTag)) {
      Get.delete<ScheduleBookingController>(tag: _controllerTag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

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
            child: controller == null
                ? Expanded(
                    child: Center(
                      child: CustomText(
                        text: 'Missing service. Go back and try again.',
                        color: AppColors.greyLight,
                        is_alignLeft: false,
                      ),
                    ),
                  )
                : Obx(() {
                    if (controller.isLoading.value &&
                        controller.detail.value == null) {
                      return const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final _ = controller.availableTimeSlots.length;
                    return Column(children: [
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            calendarWidget(controller),
                            15.verticalSpace,
                            CustomText(
                                text: AppStrings.availabilityHour,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                            10.verticalSpace,
                            hourListWidget(controller),
                            10.verticalSpace,
                          ],
                        ),
                      )),
                      btnWidget(context, controller),
                      20.verticalSpace
                    ]);
                  })));
  }

  Widget calendarWidget(ScheduleBookingController controller) {
    final dates = controller.availableDates.toList();
    if (dates.isEmpty) {
      return CustomText(
        text: 'No available dates for this provider.',
        color: AppColors.greyLight,
      );
    }

    return Obx(() {
      final selected = controller.selectedDate.value ?? dates.first;
      return CustomCalendar(
        key: ValueKey(dates.map((d) => d.toIso8601String()).join(',')),
        highlightedDates: dates,
        initialFocusedDate: dates.first,
        selectedDate: selected,
        onDateSelected: controller.setSelectedDate,
      );
    });
  }




  Widget hourListWidget(ScheduleBookingController controller) {
    return Obx(() {
      final slots = controller.availableTimeSlots.toList();
      if (slots.isEmpty) {
        return CustomText(
          text: controller.selectedDate.value == null
              ? 'Select a date to see available time slots.'
              : 'No time slots available for this date.',
          color: AppColors.greyLight,
        );
      }

      final selected = controller.selectedTimeSlot.value;
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: slots.length,
        itemBuilder: (context, index) {
          final slot = slots[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: AppPadding.padding12),
            child: CheckBoxWidget(
              isChecked: selected == slot,
              ontapCheck: () => controller.selectedTimeSlot.value = slot,
              title: slot.displayLabel,
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1),
      );
    });
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

  CustomButton btnWidget(
    BuildContext context,
    ScheduleBookingController controller,
  ) {
    return CustomButton(
      text: AppStrings.next,
      onclick: () {
        final date = controller.selectedDate.value;
        final slot = controller.selectedTimeSlot.value;

        if (date == null) {
          AppDialogs.showToast(message: 'Please select a date.');
          return;
        }
        if (slot == null) {
          AppDialogs.showToast(message: 'Please select a time slot.');
          return;
        }

        final service = controller.servicePayload.value;
        if (service == null || service.isEmpty) {
          AppDialogs.showToast(message: 'Service details are not loaded yet.');
          return;
        }

        AppNavigation.navigateTo(
          context,
          AppRoutes.serviceSelectionScreenRoute,
          arguments: ServiceRoutingArgument(
            type: widget.type,
            serviceId: widget.serviceId,
            providerId: widget.providerId,
            providerServiceId: widget.providerServiceId,
            service: Map<String, dynamic>.from(service),
            selectedDate: date,
            selectedTimeSlot: slot,
          ),
        );
      },
    );
  }
}
