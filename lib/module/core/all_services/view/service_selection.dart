import 'package:ezhandy_user/module/core/all_services/controller/create_booking_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/checkout_browser.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
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

class ServiceSelection extends StatefulWidget {
  final ServiceRoutingArgument? args;

  const ServiceSelection({this.args, super.key});

  factory ServiceSelection.fromArgs(ServiceRoutingArgument? args) {
    return ServiceSelection(args: args);
  }

  @override
  State<ServiceSelection> createState() => _ServiceSelectionState();
}

class _ServiceSelectionState extends State<ServiceSelection> {
  final CreateBookingController _createBookingController =
      Get.put(CreateBookingController());

  static const _hourOptions = <MapEntry<String, int>>[
    MapEntry('2 hrs', 120),
    MapEntry('3 hrs', 180),
    MapEntry('4 hrs', 240),
    MapEntry('5 hrs', 300),
    MapEntry('6 hrs', 360),
    MapEntry('7 hrs', 420),
    MapEntry('8 hrs', 480),
  ];

  String? primaryServiceValue;
  String? secondaryServiceValue;
  String? filterStartValue;
  var serviceList = ["Service 1", "Service 2", "Service 3"];

  String? selectedHoursLabel;
  int? selectedDurationMinutes;

  ServiceRoutingArgument? get _bookingArgs => widget.args;

  Map<String, dynamic>? get _service => _bookingArgs?.service;

  int get _selectedHours => (selectedDurationMinutes ?? 0) ~/ 60;

  double get _visitCharges => _parseAmount(_service?['visitCharges']);

  double get _hourlyRate => _parseAmount(_service?['hourlyRate']);

  double get _hourlyTotal => _hourlyRate * _selectedHours;

  double get _subtotal => _visitCharges + _hourlyTotal;

  double get _total => _subtotal;

  List<String> get _hourLabels =>
      _hourOptions.map((option) => option.key).toList();

  @override
  void dispose() {
    if (Get.isRegistered<CreateBookingController>()) {
      Get.delete<CreateBookingController>();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    primaryServiceValue = 'Service 1';
    selectedHoursLabel = _hourOptions.first.key;
    selectedDurationMinutes = _hourOptions.first.value;
  }
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.serviceSelection,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  CustomText(
                    text: AppStrings.howManyHoursDoYouNeed,
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                  20.verticalSpace,
                  hoursDropDown(),
                  20.verticalSpace,
                  CustomText(
                    text: AppStrings.primaryService,
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                  20.verticalSpace,
                  primaryServiceDropDown(),
                  20.verticalSpace,
                  CustomText(
                    text: AppStrings.secondaryService,
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                  20.verticalSpace,
                  secondaryServiceDropDown(),
                  20.verticalSpace,
                  bookingSummaryWidget(),
                  20.verticalSpace,
                  noteWidget(),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
          btnWidget(context),
          20.verticalSpace,
        ]),
      ),
    );
  }

  double _parseAmount(dynamic value) {
    if (value == null) return 0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^\d.-]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  String _formatMoney(double amount) {
    if (amount == amount.roundToDouble()) {
      return '\$${amount.toInt()}';
    }
    return '\$${amount.toStringAsFixed(2)}';
  }

  Widget bookingSummaryWidget() {
    final hours = _selectedHours;

    return CustomContainer(
      borderColor: AppColors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.bookingSummary,
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
          12.verticalSpace,
          _summaryRow(AppStrings.visitCharges, _formatMoney(_visitCharges)),
          8.verticalSpace,
          _summaryRow(
            '${AppStrings.hourlyRate} ($hours hrs × ${_formatMoney(_hourlyRate)})',
            _formatMoney(_hourlyTotal),
          ),
          12.verticalSpace,
          const Divider(thickness: 1),
          12.verticalSpace,
          _summaryRow(
            AppStrings.subtotal,
            _formatMoney(_subtotal),
            isBold: true,
          ),
          8.verticalSpace,
          _summaryRow(
            AppStrings.total,
            _formatMoney(_total),
            isBold: true,
            valueColor: AppColors.orange,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    final style = TextStyle(
      fontSize: 14.sp,
      fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
      color: AppColors.black,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(label, style: style),
        ),
        Text(
          value,
          style: style.copyWith(
            color: valueColor ?? AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget hoursDropDown() {
    return CustomDropDown2(
      dropDownWidth: 0.95.sw,
      dropDownData: _hourLabels,
      borderColor: AppColors.greyBorder,
      borderRadius: 10.r,
      hintText: AppStrings.selectHours,
      dropdownValue: selectedHoursLabel,
      dropdownListColor: AppColors.white,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        final label = value.toString();
        final minutes = _hourOptions
            .firstWhere(
              (option) => option.key == label,
              orElse: () => _hourOptions.first,
            )
            .value;
        setState(() {
          selectedHoursLabel = label;
          selectedDurationMinutes = minutes;
          _bookingArgs?.durationMinutes = minutes;
        });
      },
    );
  }

  Widget primaryServiceDropDown() {
    return CustomDropDown2(
      // width: 110.w, // 👈 Controls button width
      dropDownWidth: 0.95.sw, // 👈 Controls dropdown menu width
      dropDownData: serviceList,
      borderColor: AppColors.greyBorder, borderRadius: 10.r,

      hintText: AppStrings.selectService,
      dropdownValue: primaryServiceValue,
      dropdownListColor: AppColors.white,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        setState(() {
          primaryServiceValue = value.toString();
        });
      },
    );
  }

  Widget secondaryServiceDropDown() {
    return CustomDropDown2(
      // width: 110.w, // 👈 Controls button width
      dropDownWidth: 0.95.sw, // 👈 Controls dropdown menu width
      dropDownData: serviceList,
      borderColor: AppColors.greyBorder,
      hintText: AppStrings.selectService,
      dropdownValue: secondaryServiceValue,
      borderRadius: 10.r,
      dropdownListColor: AppColors.white,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        setState(() {
          secondaryServiceValue = value.toString();
        });
      },
    );
  }

  Widget btnWidget(BuildContext context) {
    return Obx(
      () => CustomButton(
        text: AppStrings.confirmBooking,
        onclick: _createBookingController.isSubmitting.value
            ? () {}
            : () => _onConfirmBooking(context),
      ),
    );
  }

  Future<void> _onConfirmBooking(BuildContext context) async {
    final args = _bookingArgs;
    if (args == null) {
      AppDialogs.showToast(message: 'Missing booking details. Go back and try again.');
      return;
    }

    final duration = selectedDurationMinutes;
    if (duration == null || duration <= 0) {
      AppDialogs.showToast(message: 'Please select hours.');
      return;
    }
    if (args.selectedDate == null) {
      AppDialogs.showToast(message: 'Please select a booking date.');
      return;
    }
    if (args.selectedTimeSlot == null) {
      AppDialogs.showToast(message: 'Please select a time slot.');
      return;
    }

    args.durationMinutes = duration;

    final checkoutUrl = await _createBookingController.startBookingDraftCheckout(
      args: args,
      durationMinutes: duration,
      totalAmount: _total,
    );

    if (!mounted) return;

    if (checkoutUrl == null || checkoutUrl.isEmpty) {
      AppDialogs.showToast(message: 'Unable to start checkout.');
      return;
    }

    CheckoutBrowser.open(
      context,
      checkoutUrl: checkoutUrl,
      successUrl: NetworkStrings.bookingCheckoutSuccessUrl,
      cancelUrl: NetworkStrings.bookingCheckoutCancelUrl,
      successRoute: AppRoutes.bookingHistoryScreenRoute,
    );
  }

  Text noteWidget() {
    return Text.rich(
      TextSpan(
        style: TextStyle(
            color: AppColors.orange,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500),
        text: "Note: ",
        children: [
          TextSpan(
              style: const TextStyle(
                color: AppColors.black,
                // fontFamily: AppStrings.mon0tserrat,
                // fontWeight: FontWeight.bold,
                // fontStyle: FontStyle.italic,
                // fontSize: 14,
                // decoration: TextDecoration.underline
              ),
              text: AppStrings.discussAndConfirmDetails),
        ],
      ),
    );
  }
}
