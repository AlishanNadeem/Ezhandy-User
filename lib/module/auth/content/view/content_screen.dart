// ignore_for_file: must_be_immutable

import 'package:ezhandy_user/module/auth/content/controller/content_controller.dart';
import 'package:ezhandy_user/module/auth/content/util/content_slug_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ContentScreen extends StatefulWidget {
  String? title;
  String? type;

  ContentScreen({super.key, this.title, this.type});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late final ContentController _controller;
  late final String _slug;

  @override
  void initState() {
    super.initState();
    _slug = ContentSlugHelper.fromType(widget.type);
    _controller = Get.put(
      ContentController(slug: _slug),
      tag: 'content_$_slug',
    );
  }

  @override
  void dispose() {
    Get.delete<ContentController>(tag: 'content_$_slug');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final page = _controller.page.value;
      final screenTitle = page?.title.isNotEmpty == true
          ? page!.title
          : (widget.title ?? '');

      return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: Get.back,
        title: screenTitle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: _buildBody(),
        ),
      );
    });
  }

  Widget _buildBody() {
    if (_controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final page = _controller.page.value;
    if (page == null || page.content.trim().isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 48.h),
          child: CustomText(
            text: 'Content not available',
            color: AppColors.greyLight,
            is_alignLeft: false,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          Html(
            data: page.content,
            style: {
              'body': Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontSize: FontSize(14.sp),
                color: AppColors.black,
                lineHeight: const LineHeight(1.5),
              ),
              'h1': Style(
                fontSize: FontSize(20.sp),
                fontWeight: FontWeight.bold,
                margin: Margins.only(bottom: 8),
              ),
              'h2': Style(
                fontSize: FontSize(18.sp),
                fontWeight: FontWeight.bold,
                margin: Margins.only(top: 12, bottom: 8),
              ),
              'h3': Style(
                fontSize: FontSize(16.sp),
                fontWeight: FontWeight.w600,
                margin: Margins.only(top: 10, bottom: 6),
              ),
              'p': Style(
                margin: Margins.only(bottom: 10),
              ),
              'ul': Style(margin: Margins.only(bottom: 10)),
              'ol': Style(margin: Margins.only(bottom: 10)),
              'li': Style(margin: Margins.only(bottom: 4)),
              'a': Style(color: AppColors.orange),
            },
          ),
          25.verticalSpace,
        ],
      ),
    );
  }
}
