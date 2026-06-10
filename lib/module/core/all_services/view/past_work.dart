import 'package:ezhandy_user/module/core/all_services/controller/past_work_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/past_work_routing_arguments.dart';
import 'package:ezhandy_user/module/core/booking/model/booking_detail_model.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/media_url_helper.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PastWork extends StatefulWidget {
  final String? providerId;
  final String? serviceId;

  const PastWork({
    super.key,
    this.providerId,
    this.serviceId,
  });

  factory PastWork.fromArgs(PastWorkRoutingArgument? args) {
    return PastWork(
      providerId: args?.providerId,
      serviceId: args?.serviceId,
    );
  }

  @override
  State<PastWork> createState() => _PastWorkState();
}

class _PastWorkState extends State<PastWork> {
  String get _controllerTag =>
      'past_work_${widget.providerId ?? 'none'}_${widget.serviceId ?? 'none'}';

  PastWorkController? get _controller {
    final providerId = widget.providerId?.trim() ?? '';
    final serviceId = widget.serviceId?.trim() ?? '';
    if (providerId.isEmpty || serviceId.isEmpty) return null;

    if (Get.isRegistered<PastWorkController>(tag: _controllerTag)) {
      return Get.find<PastWorkController>(tag: _controllerTag);
    }

    return Get.put(
      PastWorkController(providerId: providerId, serviceId: serviceId),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<PastWorkController>(tag: _controllerTag)) {
      Get.delete<PastWorkController>(tag: _controllerTag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: Get.back,
      title: AppStrings.pastWork,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: controller == null
            ? _missingIdsBody()
            : Obx(() => _buildBody(controller)),
      ),
    );
  }

  Widget _missingIdsBody() {
    return Center(
      child: CustomText(
        text: AppStrings.noPastWorkFound,
        color: AppColors.greyLight,
        is_alignLeft: false,
      ),
    );
  }

  Widget _buildBody(PastWorkController controller) {
    if (controller.isLoading.value && controller.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.items.isEmpty) {
      return Center(
        child: CustomText(
          text: AppStrings.noPastWorkFound,
          color: AppColors.greyLight,
          is_alignLeft: false,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(top: 20.h, bottom: 25.h),
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        return _pastWorkItem(controller.items[index]);
      },
      separatorBuilder: (_, __) => 20.verticalSpace,
    );
  }

  Widget _pastWorkItem(Map<String, dynamic> item) {
    final service = item['service'] is Map
        ? Map<String, dynamic>.from(item['service'] as Map)
        : null;
    final customer = item['customer'] is Map
        ? Map<String, dynamic>.from(item['customer'] as Map)
        : null;
    final workDocs = item['workDocuments'] is Map
        ? Map<String, dynamic>.from(item['workDocuments'] as Map)
        : null;

    final serviceTitle = service?['title']?.toString().trim() ?? '';
    final customerName = customer?['fullName']?.toString().trim() ?? '';
    final beforeImages =
        BookingWorkDocuments.imagePathsFromJson(workDocs, 'before');
    final afterImages =
        BookingWorkDocuments.imagePathsFromJson(workDocs, 'after');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (serviceTitle.isNotEmpty)
          CustomText(
            text: serviceTitle,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        if (customerName.isNotEmpty) ...[
          8.verticalSpace,
          CustomText(
            text: '${AppStrings.bookedBy}: $customerName',
            color: AppColors.grey,
          ),
        ],
        12.verticalSpace,
        CustomText(
          text: AppStrings.beforeWork,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
        8.verticalSpace,
        _imageListWidget(beforeImages),
        12.verticalSpace,
        CustomText(
          text: AppStrings.afterWork,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
        8.verticalSpace,
        _imageListWidget(afterImages),
      ],
    );
  }

  Widget _imageListWidget(List<String> imagePaths) {
    if (imagePaths.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: CustomText(
          text: 'No images available',
          color: AppColors.greyLight,
          fontSize: 12.sp,
        ),
      );
    }

    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          final url = resolveMediaUrl(imagePaths[index]);
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: .45.sw,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.greyLight.withValues(alpha: 0.3),
                  alignment: Alignment.center,
                  child: Icon(Icons.broken_image_outlined, size: 32.sp),
                ),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppColors.greyLight.withValues(alpha: 0.2),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  );
                },
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => 10.horizontalSpace,
      ),
    );
  }
}
