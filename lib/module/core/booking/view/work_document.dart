import 'package:ezhandy_user/module/core/booking/routing_arguments/work_documents_routing_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/media_url_helper.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class WorkDocuments extends StatefulWidget {
  final String? serviceTitle;
  final String? serviceDescription;
  final List<String> beforeImagePaths;
  final List<String> afterImagePaths;

  const WorkDocuments({
    required this.beforeImagePaths,
    required this.afterImagePaths,
    this.serviceTitle,
    this.serviceDescription,
    super.key,
  });

  factory WorkDocuments.fromArgs(WorkDocumentsRoutingArgument args) {
    return WorkDocuments(
      serviceTitle: args.serviceTitle,
      serviceDescription: args.serviceDescription,
      beforeImagePaths: args.beforeImagePaths,
      afterImagePaths: args.afterImagePaths,
    );
  }

  @override
  State<WorkDocuments> createState() => _WorkDocumentsState();
}

class _WorkDocumentsState extends State<WorkDocuments> {
  @override
  Widget build(BuildContext context) {
    final title = widget.serviceTitle?.trim();
    final description = widget.serviceDescription?.trim();

    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: Get.back,
        title: AppStrings.workDocuments,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding12,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.verticalSpace,
                singleQuestionWidget(
                  number: 1,
                  task: title != null && title.isNotEmpty
                      ? title
                      : AppStrings.service,
                  taskDetail: description != null && description.isNotEmpty
                      ? description
                      : '—',
                ),
                15.verticalSpace,
                CustomText(
                  text: AppStrings.beforeImage,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
                5.verticalSpace,
                imageListWidget(widget.beforeImagePaths),
                10.verticalSpace,
                CustomText(
                  text: AppStrings.afterImage,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
                5.verticalSpace,
                imageListWidget(widget.afterImagePaths),
                25.verticalSpace,
              ],
            ),
          ),
        ));
  }

  Widget singleQuestionWidget({
    required int number,
    required String task,
    required String taskDetail,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "$number. $task:",
          fontWeight: FontWeight.bold,
          color: AppColors.orange,
        ),
        10.verticalSpace,
        CustomText(text: taskDetail),
      ],
    );
  }

  Widget imageListWidget(List<String> imagePaths) {
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
          return GestureDetector(
            onTap: () {
              if (url.isEmpty) return;
              Utils.onTapViewImage(
                context: context,
                image: url,
                mediaType: MediaPathType.network.name,
              );
            },
            child: ClipRRect(
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
            ),
          );
        },
        separatorBuilder: (_, __) => 10.horizontalSpace,
      ),
    );
  }
}
