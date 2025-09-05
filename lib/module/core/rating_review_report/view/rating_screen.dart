import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_shadows.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/indicator/percentage_indicator.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/rating_star/rating_star.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  // double initialRating = 4;

  final List<Map<String, dynamic>> ratings = [
    {"num": "5", "count": "300", "percent": 0.8},
    {"num": "4", "count": "150", "percent": 0.7},
    {"num": "3", "count": "100", "percent": 0.6},
    {"num": "2", "count": "50", "percent": 0.5},
    {"num": "1", "count": "10", "percent": 0.4},
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      title: AppStrings.reviewAndRating,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: Column(
          children: [
            20.verticalSpace,

            /// Row: Ratings chart + Overall rating number
            Row(
              children: [
                ratingBarWidget(),
                10.horizontalSpace,
                avgRatingWidget(),
              ],
            ),
            reviewListWidget(),

            25.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget reviewListWidget() {
    return Expanded(
      child: ListView.separated(
        // scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return reviewContainer();
        },
        separatorBuilder: (context, index) {
          return 10.verticalSpace;
        },
        itemCount: 5,
      ),
    );
  }

  CustomContainer reviewContainer() {
    return CustomContainer(
        boxShadow: AppShadows.shadow1,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ratingWidget(initialRating: 4.5),
            5.verticalSpace,
            CustomText(
                text: AppStrings.dummyEventName,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            5.verticalSpace,
            CustomText(
              text: AppStrings.lorem5,
              color: AppColors.grey,
            ),
          ],
        ));
  }

  Column ratingBarWidget() {
    return Column(
      children: ratings
          .map((r) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: ratingIndicatorWidget(
                  ratNum: r["num"],
                  ratCount: r["count"],
                  percent: r["percent"],
                ),
              ))
          .toList(),
    );
  }

  Column avgRatingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: AppStrings.dummyRating,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.star,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
        CustomText(
          text: "278 ${AppStrings.reviews}",
          is_alignLeft: false,
          fontSize: 10.sp,
        ),
      ],
    );
  }

  Widget ratingWidget({required double initialRating}) {
    return RatingStar(
      ignoreGestures: true, // Change to false if you want it clickable
      itemSize: 25.sp,
      initialRating: initialRating,
      onRatingUpdate: (rating) {
        setState(() {
          initialRating = rating;
        });
      },
    );
  }

  Row ratingIndicatorWidget({
    required String ratNum,
    required String ratCount,
    required double percent,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          align: Alignment.topCenter,
          text: ratNum,
          is_alignLeft: false,
        ),
        10.horizontalSpace,
        SizedBox(
          width: 0.6.sw, // Fixed width for bars so they align neatly
          child: PercentageIndicator(percent: percent),
        ),
        10.horizontalSpace,
        // CustomText(
        //   align: Alignment.topCenter,
        //   text: ratCount,
        //   is_alignLeft: false,
        // ),
      ],
    );
  }
}
