import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class WorkDocuments extends StatefulWidget {
  WorkDocuments({super.key});

  @override
  State<WorkDocuments> createState() => _WorkDocumentsState();
}

class _WorkDocumentsState extends State<WorkDocuments> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        // appBarheight: 50.h,
        title: AppStrings.workDocuments,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding12,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    // final item = notifications[index];
                    return singleQuestionWidget(
                        number: index + 1,
                        task: "Service Performed",
                        taskDetail: AppStrings.lorem5);
                  },
                  separatorBuilder: (context, index) {
                    return 10.verticalSpace;
                  },
                ),
                15.verticalSpace,
                CustomText(
                  text: AppStrings.beforeImage,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
                5.verticalSpace,
                imageListWidget(),
                10.verticalSpace,
                CustomText(
                  text: AppStrings.afterImage,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
                5.verticalSpace,
                imageListWidget(),
                25.verticalSpace,
              ],
            ),
          ),
        ));
  }

  Widget singleQuestionWidget({number, task, taskDetail}) {
    return Column(children: [
      20.verticalSpace,
      CustomText(
          text: "${number}. $task:",
          // fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.orange),
      10.verticalSpace,
      CustomText(
        text: taskDetail,
      ),
      // 10.verticalSpace,
      // imageListWidget(),
    ]);
  }

  Widget imageListWidget() {
    return Container(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: .45.sw,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://t4.ftcdn.net/jpg/02/14/20/51/360_F_214205168_JqvyKVeKzYGTpQEdy3Y1c7CUh6fRMg0W.jpg"))),
          );
        },
        separatorBuilder: (context, index) {
          return 10.horizontalSpace;
        },
        itemCount: 5,
      ),
    );
  }
}
