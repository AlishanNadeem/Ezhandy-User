import 'package:ezhandy_user/module/core/all_services/controller/create_booking_controller.dart';
import 'package:ezhandy_user/module/core/all_services/controller/service_selection_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/module/core/booking/controller/booking_history_controller.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/utils/api_enums.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/constant.dart';
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

  String get _selectionControllerTag =>
      'service_selection_${_bookingArgs?.providerId ?? 'none'}';

  ServiceSelectionController? get _selectionController {
    final providerId = _bookingArgs?.providerId?.trim() ?? '';
    if (providerId.isEmpty) return null;

    final ServiceSelectionController controller;
    if (Get.isRegistered<ServiceSelectionController>(tag: _selectionControllerTag)) {
      controller =
          Get.find<ServiceSelectionController>(tag: _selectionControllerTag);
    } else {
      controller = Get.put(
        ServiceSelectionController(providerId: providerId),
        tag: _selectionControllerTag,
      );
    }

    controller.syncExclusions(
      excludedProviderServiceIds: _excludedProviderServiceIds(),
      excludedServiceTypeId: _bookingArgs?.serviceId,
      excludedServiceLabel: _excludedServiceLabel(),
    );

    return controller;
  }

  static const _noneSecondaryOption = 'None';

  static const _hourOptions = <MapEntry<String, int>>[
    MapEntry('2 hrs', 120),
    MapEntry('3 hrs', 180),
    MapEntry('4 hrs', 240),
    MapEntry('5 hrs', 300),
    MapEntry('6 hrs', 360),
    MapEntry('7 hrs', 420),
    MapEntry('8 hrs', 480),
  ];

  String? secondaryServiceValue;

  String? selectedHoursLabel;
  int? selectedDurationMinutes;

  ServiceRoutingArgument? get _bookingArgs => widget.args;

  Map<String, dynamic>? get _service => _bookingArgs?.service;

  int get _selectedHours => (selectedDurationMinutes ?? 0) ~/ 60;

  Map<String, dynamic>? get _secondaryService =>
      _selectionController?.findSecondaryServiceByLabel(secondaryServiceValue);

  bool get _hasSecondaryService => _secondaryService != null;

  double get _primaryVisitCharges => _parseAmount(_service?['visitCharges']);

  double get _primaryHourlyRate => _parseAmount(_service?['hourlyRate']);

  double get _primaryHourlyTotal => _primaryHourlyRate * _selectedHours;

  double get _secondaryVisitCharges =>
      _parseAmount(_secondaryService?['visitCharges']);

  double get _secondaryHourlyRate =>
      _parseAmount(_secondaryService?['hourlyRate']);

  double get _secondaryHourlyTotal => _secondaryHourlyRate * _selectedHours;

  double get _subtotal {
    var total = _primaryVisitCharges + _primaryHourlyTotal;
    if (_hasSecondaryService) {
      total += _secondaryVisitCharges + _secondaryHourlyTotal;
    }
    return total;
  }

  double get _total => _subtotal;

  List<String> get _hourLabels =>
      _hourOptions.map((option) => option.key).toList();

  @override
  void dispose() {
    if (Get.isRegistered<CreateBookingController>()) {
      Get.delete<CreateBookingController>();
    }
    if (Get.isRegistered<ServiceSelectionController>(tag: _selectionControllerTag)) {
      Get.delete<ServiceSelectionController>(tag: _selectionControllerTag);
    }
    super.dispose();
  }

  bool get _isInstantBooking =>
      _bookingArgs?.type == ServiceType.instant.name;

  void _applyInstantBookingDefaults() {
    if (!_isInstantBooking) return;

    final args = _bookingArgs;
    if (args == null) return;

    final now = DateTime.now();
    args.selectedDate = DateTime(now.year, now.month, now.day);
    args.selectedTimeSlot = TimeSlotEnum.morning;
  }

  @override
  void initState() {
    super.initState();
    selectedHoursLabel = _hourOptions.first.key;
    selectedDurationMinutes = _hourOptions.first.value;
    _applyInstantBookingDefaults();
  }

  String _selectedServiceName() {
    final service = _service;
    if (service != null) {
      final title = service['title']?.toString().trim() ?? '';
      if (title.isNotEmpty) return title;

      final serviceType = service['serviceType'];
      if (serviceType is Map) {
        final name = serviceType['name']?.toString().trim() ?? '';
        if (name.isNotEmpty) return name;
      }
    }

    final name = _bookingArgs?.serviceName?.trim() ?? '';
    if (name.isNotEmpty) return name;

    return '-';
  }

  String? _excludedServiceLabel() {
    final name = _selectedServiceName();
    return name == '-' ? null : name;
  }

  Set<String> _excludedProviderServiceIds() {
    final ids = <String>{};
    for (final value in [
      _bookingArgs?.providerServiceId,
      _service?['id'],
      _service?['providerServiceId'],
    ]) {
      final id = value?.toString().trim() ?? '';
      if (id.isNotEmpty) ids.add(id);
    }
    return ids;
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
                  CustomText(
                    text: _selectedServiceName(),
                    fontWeight: FontWeight.w500,
                  ),
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

  String _secondaryServiceName() {
    final service = _secondaryService;
    if (service == null) return '';
    return ServiceSelectionController.serviceLabel(service);
  }

  Widget bookingSummaryWidget() {
    final hours = _selectedHours;
    final secondaryName = _secondaryServiceName();

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
          ..._serviceChargeSection(
            serviceName: _selectedServiceName(),
            visitCharges: _primaryVisitCharges,
            hourlyRate: _primaryHourlyRate,
            hours: hours,
          ),
          if (_hasSecondaryService) ...[
            12.verticalSpace,
            ..._serviceChargeSection(
              serviceName: secondaryName,
              visitCharges: _secondaryVisitCharges,
              hourlyRate: _secondaryHourlyRate,
              hours: hours,
            ),
          ],
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

  List<Widget> _serviceChargeSection({
    required String serviceName,
    required double visitCharges,
    required double hourlyRate,
    required int hours,
  }) {
    return [
      CustomText(
        text: serviceName,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),
      8.verticalSpace,
      _summaryRow(AppStrings.visitCharges, _formatMoney(visitCharges)),
      8.verticalSpace,
      _summaryRow(
        '${AppStrings.hourlyRate} ($hours hrs × ${_formatMoney(hourlyRate)})',
        _formatMoney(hourlyRate * hours),
      ),
    ];
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

  Widget secondaryServiceDropDown() {
    final controller = _selectionController;
    if (controller == null) {
      return CustomDropDown2(
        dropDownWidth: 0.95.sw,
        dropDownData: const [],
        borderColor: AppColors.greyBorder,
        hintText: AppStrings.selectService,
        borderRadius: 10.r,
        dropdownListColor: AppColors.white,
        hintTextColor: AppColors.black,
        onChanged: (_) {},
      );
    }

    return Obx(() {
      final serviceOptions = controller.secondaryServiceLabels;
      final isLoading = controller.isLoadingProviderServices.value;
      final options = [_noneSecondaryOption, ...serviceOptions];

      return CustomDropDown2(
        dropDownWidth: 0.95.sw,
        dropDownData: options,
        borderColor: AppColors.greyBorder,
        hintText: isLoading
            ? 'Loading services...'
            : AppStrings.selectService,
        dropdownValue: secondaryServiceValue != null &&
                serviceOptions.contains(secondaryServiceValue)
            ? secondaryServiceValue
            : _noneSecondaryOption,
        borderRadius: 10.r,
        dropdownListColor: AppColors.white,
        hintTextColor: AppColors.black,
        onChanged: isLoading
            ? (_) {}
            : (value) {
                setState(() {
                  final selected = value.toString();
                  secondaryServiceValue =
                      selected == _noneSecondaryOption ? null : selected;
                });
              },
      );
    });
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

    _applyInstantBookingDefaults();

    final duration = selectedDurationMinutes;
    if (duration == null || duration <= 0) {
      AppDialogs.showToast(message: 'Please select hours.');
      return;
    }
    if (!_isInstantBooking && args.selectedDate == null) {
      AppDialogs.showToast(message: 'Please select a booking date.');
      return;
    }
    if (!_isInstantBooking && args.selectedTimeSlot == null) {
      AppDialogs.showToast(message: 'Please select a time slot.');
      return;
    }

    args.durationMinutes = duration;

    final secondaryServiceId =
        ServiceSelectionController.resolveServiceId(_secondaryService);

    final success = await _createBookingController.createBookingAndPay(
      args: args,
      durationMinutes: duration,
      secondaryServiceId: secondaryServiceId,
    );

    if (!mounted) return;

    if (!success) {
      AppDialogs.showToast(message: 'Unable to confirm booking.');
      return;
    }

    AppDialogs.showSuccessDialog(
      context,
      description: AppStrings.yourBookingHasBeenDone,
      title: AppStrings.congratulation,
      btnTxt1: AppStrings.ok,
      onTap1: () => _onBookingSuccess(),
    );
  }

  void _onBookingSuccess() {
    final navContext = Constants.navigatorKey.currentContext;
    if (navContext == null) return;

    AppNavigation.navigatorPopUntil(
      navContext,
      AppRoutes.mainMenuScreenRoute,
    );
    HomeController.i.selectedTab.value = 2;

    const myBookingTag = 'my_booking';
    if (Get.isRegistered<BookingHistoryController>(tag: myBookingTag)) {
      Get.find<BookingHistoryController>(tag: myBookingTag).fetchUserBookings();
    }
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
