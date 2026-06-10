import 'package:ezhandy_user/module/core/all_services/controller/service_details_controller.dart';

import 'package:ezhandy_user/module/core/all_services/model/provider_service_detail_model.dart';

import 'package:ezhandy_user/module/core/all_services/routing_arguments/past_work_routing_arguments.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';

import 'package:ezhandy_user/module/core/booking/model/active_booking_check_model.dart';

import 'package:ezhandy_user/module/core/booking/routing_arguments/booking_routing_arguments.dart';

import 'package:ezhandy_user/utils/enums.dart';

import 'package:ezhandy_user/widgets/Container/custom_container.dart';

import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'package:ezhandy_user/utils/app_colors.dart';

import 'package:ezhandy_user/utils/app_dialogs.dart';

import 'package:ezhandy_user/utils/app_padding.dart';

import 'package:ezhandy_user/utils/app_strings.dart';

import 'package:ezhandy_user/utils/asset_path.dart';

import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';

import 'package:ezhandy_user/utils/routes/app_route.dart';

import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';

import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';

import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ServiceDetails extends StatefulWidget {
  final String? type;

  final int? serviceId;

  final String? providerId;

  final String? providerServiceId;

  const ServiceDetails({
    this.type,
    this.serviceId,
    this.providerId,
    this.providerServiceId,
    super.key,
  });

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  String get _controllerTag =>
      'service_details_${widget.providerServiceId ?? 'none'}';

  ServiceDetailsController? get _controller {
    final id = widget.providerServiceId?.trim() ?? '';

    if (id.isEmpty) return null;

    if (Get.isRegistered<ServiceDetailsController>(tag: _controllerTag)) {
      return Get.find<ServiceDetailsController>(tag: _controllerTag);
    }

    return Get.put(
      ServiceDetailsController(
        providerServiceId: id,
        providerId: widget.providerId,
      ),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<ServiceDetailsController>(tag: _controllerTag)) {
      Get.delete<ServiceDetailsController>(tag: _controllerTag);
    }

    super.dispose();
  }

  String _resolveMediaUrl(String path) {
    final trimmed = path.trim();

    if (trimmed.isEmpty) return '';

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }

    return '${NetworkStrings.IMAGE_BASE_URL}$trimmed';
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: AppStrings.serviceDetails,
      appBarheight: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: controller == null
            ? _missingServiceBody()
            : Obx(() => _buildBody(controller)),
      ),
    );
  }

  Widget _missingServiceBody() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: CustomText(
              text: 'Missing service. Go back and pick a service.',
              color: AppColors.greyLight,
              is_alignLeft: false,
            ),
          ),
        ),
        25.verticalSpace,
      ],
    );
  }

  Widget _buildBody(ServiceDetailsController controller) {
    if (controller.isLoading.value && controller.detail.value == null) {
      return Column(
        children: [
          Expanded(
            child: const Center(child: CircularProgressIndicator()),
          ),
          25.verticalSpace,
        ],
      );
    }

    final detail = controller.detail.value;

    if (detail == null) {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: CustomText(
                text: 'Unable to load service details',
                color: AppColors.greyLight,
                is_alignLeft: false,
              ),
            ),
          ),
          25.verticalSpace,
        ],
      );
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileRowWidget(detail),
                15.verticalSpace,
                singleContainer(
                  imageUrl: _resolveMediaUrl(detail.imageUrl),
                  isFav: controller.isServiceFavorite.value,
                  ontapLike: _onHeartTap,
                  onTap: () {},
                ),
                15.verticalSpace,
                CustomText(
                  text: detail.title,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
                CustomText(text: detail.description),
                15.verticalSpace,
                Row(
                  children: [
                    keyValueWidget(
                      key: AppStrings.visitCharges,
                      value: '\$${detail.visitCharges}',
                    ),
                    10.horizontalSpace,
                    keyValueWidget(
                      key: AppStrings.hourlyRate,
                      value: '\$${detail.hourlyRate}',
                    ),
                  ],
                ),
                10.verticalSpace,
                CustomText(
                  text: 'A minimum of 2 hours of service booking is mandatory.',
                  color: AppColors.orange,
                  fontSize: 16.sp,
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ),
        Obx(() => _buildBottomActions(controller)),
        25.verticalSpace,
      ],
    );
  }

  Widget _buildBottomActions(ServiceDetailsController controller) {
    if (controller.canCheckActiveBooking &&
        controller.isCheckingActiveBooking.value) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final activeCheck = controller.activeBookingCheck.value;

    final hasActive = controller.hasActiveBooking.value && activeCheck != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasActive) ...[
          _activeBookingBanner(activeCheck),
          12.verticalSpace,
        ],
        CustomButton(
          text: hasActive
              ? AppStrings.viewMyBooking
              : (widget.type == ServiceType.instant.name
                  ? AppStrings.bookQuickServices
                  : 'Book Service'),
          onclick: hasActive
              ? () => _openActiveBooking(activeCheck)
              : () => _showBookServiceDialog(),
        ),
      ],
    );
  }

  Widget _activeBookingBanner(ActiveBookingCheckResult activeCheck) {
    final statusLabel = activeCheck.statusLabel.isNotEmpty
        ? activeCheck.statusLabel
        : (activeCheck.booking?.statusLabel ?? '');

    final bookingDate = activeCheck.booking?.bookingDate ?? '';

    return CustomContainer(
      borderColor: AppColors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.activeBookingTitle,
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
          ),
          8.verticalSpace,
          CustomText(
            text:
                '${AppStrings.activeBookingMessagePrefix} $statusLabel. ${AppStrings.activeBookingMessageSuffix}',
            color: AppColors.greyLight,
            fontSize: 13.sp,
          ),
          if (bookingDate.isNotEmpty) ...[
            8.verticalSpace,
            CustomText(
              text:
                  '${AppStrings.bookedFor} ${_formatActiveBookingDate(bookingDate)}',
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ],
        ],
      ),
    );
  }

  String _formatActiveBookingDate(String rawDate) {
    final dt = DateTime.tryParse(rawDate);

    if (dt != null) {
      return DateFormat('EEE, MMM d, yyyy').format(dt);
    }

    return rawDate;
  }

  void _openActiveBooking(ActiveBookingCheckResult activeCheck) {
    final bookingId = activeCheck.booking?.id ?? 0;

    if (bookingId <= 0) return;

    final statusLabel = activeCheck.statusLabel.isNotEmpty
        ? activeCheck.statusLabel
        : (activeCheck.booking?.statusLabel ?? '');

    AppNavigation.navigateTo(
      context,
      AppRoutes.bookingScreenRoute,
      arguments: BookingRoutingArgument(
        bookingId: bookingId,
        Status: statusLabel,
      ),
    );
  }

  void _showBookServiceDialog() {
    AppDialogs.showSuccessDialog(context,
        description: widget.type == ServiceType.instant.name
            ? AppStrings.bookQuiceServiceDetails
            : AppStrings.bookServiceDetails,
        image: AssetPath.tumbIcon,
        isDoneShow: false,
        btnTxt1: AppStrings.yes,
        onTap1: () {
          AppNavigation.navigatorPop(context);

          final detail = _controller?.detail.value;
          final service = detail != null
              ? <String, dynamic>{
                  'id': widget.providerServiceId,
                  'providerServiceId': widget.providerServiceId,
                  'visitCharges': detail.visitCharges,
                  'hourlyRate': detail.hourlyRate,
                  'title': detail.title,
                  'description': detail.description,
                }
              : null;

          if (widget.type == ServiceType.instant.name) {
            AppNavigation.navigateTo(
              context,
              AppRoutes.serviceSelectionScreenRoute,
              arguments: ServiceRoutingArgument(
                type: widget.type,
                serviceId: widget.serviceId,
                providerId: widget.providerId,
                providerServiceId: widget.providerServiceId,
                service: service,
              ),
            );
          } else {
            AppNavigation.navigateTo(
              context,
              AppRoutes.scheduleBookingScreenRoute,
              arguments: ServiceRoutingArgument(
                type: widget.type,
                serviceId: widget.serviceId,
                providerId: widget.providerId,
                providerServiceId: widget.providerServiceId,
              ),
            );
          }
        },
        btnTxt2: AppStrings.no,
        onTap2: () {
          AppNavigation.navigatorPop(context);
        });
  }

  void _onHeartTap() {
    final c = _controller;

    if (c == null) return;

    if (c.isServiceFavoriteToggling.value) return;

    c.toggleServiceFavorite();
  }

  Widget singleContainer({
    required VoidCallback onTap,
    required String imageUrl,
    required VoidCallback ontapLike,
    required bool isFav,
  }) {
    final image = imageUrl.isNotEmpty
        ? DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl),
            onError: (_, __) {},
          )
        : const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AssetPath.tempCleaningImage),
          );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 250.h,
        width: 1.sw,
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: image,
        ),
        child: Column(
          children: [
            10.verticalSpace,
            Align(
              alignment: Alignment.centerLeft,
              child: Obx(() {
                final c = _controller;

                final filled = c?.isServiceFavorite.value ?? isFav;

                final busy = c?.isServiceFavoriteToggling.value ?? false;

                return GestureDetector(
                  onTap: busy ? null : ontapLike,
                  child: Icon(
                    filled
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 30.sp,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget keyValueWidget({required String value, required String key}) {
    return Expanded(
      child: CustomContainer(
        borderColor: AppColors.orange,
        child: Column(
          children: [
            CustomText(
              text: value,
              is_alignLeft: false,
              color: AppColors.orange,
            ),
            CustomText(
              text: key,
              is_alignLeft: false,
            ),
          ],
        ),
      ),
    );
  }

  Row profileRowWidget(ProviderServiceDetailModel detail) {
    final profileImage = _resolveMediaUrl(detail.providerImage);

    return Row(
      children: [
        UserImageWidget(
          size: 28,
          image: profileImage.isEmpty ? null : profileImage,
          onAvatarTap: profileImage.isEmpty
              ? null
              : () {
                  Utils.onTapViewImage(
                    context: context,
                    image: profileImage,
                    mediaType: MediaPathType.network.name,
                  );
                },
        ),
        5.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: detail.providerName,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              text: detail.serviceTypeName,
            ),
          ],
        ),
        const Spacer(),
        CustomContainer(
          onTap: () {
            AppNavigation.navigateTo(
              context,
              AppRoutes.pastworkScreenRoute,
              arguments: PastWorkRoutingArgument(
                providerId: widget.providerId,
                serviceId: widget.providerServiceId,
              ),
            );
          },
          bgColor: AppColors.orange,
          borderColor: AppColors.orange,
          radius: 35.r,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: CustomText(
              text: AppStrings.pastWork,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
