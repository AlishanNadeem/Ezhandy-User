import 'package:ezhandy_user/module/core/rating_review_report/controller/rating_screen_controller.dart';
import 'package:ezhandy_user/module/core/rating_review_report/model/provider_ratings_model.dart';
import 'package:ezhandy_user/module/core/rating_review_report/routing_arguments/review_routing_arguments.dart';
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
  final String? providerId;

  const RatingScreen({this.providerId, super.key});

  factory RatingScreen.fromArgs(ReviewRoutingArgument? args) {
    return RatingScreen(providerId: args?.providerId);
  }

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  static const _tagPrefix = 'rating_screen_';

  String get _controllerTag => '$_tagPrefix${widget.providerId ?? 'none'}';

  RatingScreenController get _controller {
    if (Get.isRegistered<RatingScreenController>(tag: _controllerTag)) {
      return Get.find<RatingScreenController>(tag: _controllerTag);
    }
    return Get.put(
      RatingScreenController(providerId: widget.providerId ?? ''),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<RatingScreenController>(tag: _controllerTag)) {
      Get.delete<RatingScreenController>(tag: _controllerTag);
    }
    super.dispose();
  }

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
        child: Obx(() {
          if (_controller.isLoading.value && _controller.ratingsData.value == null) {
            return const Expanded(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final data = _controller.ratingsData.value;
          final breakdown = data?.starBreakdown ??
              [
                {"num": "5", "count": "0", "percent": 0.0},
                {"num": "4", "count": "0", "percent": 0.0},
                {"num": "3", "count": "0", "percent": 0.0},
                {"num": "2", "count": "0", "percent": 0.0},
                {"num": "1", "count": "0", "percent": 0.0},
              ];

          return Column(
            children: [
              20.verticalSpace,
              Row(
                children: [
                  ratingBarWidget(breakdown),
                  10.horizontalSpace,
                  avgRatingWidget(data),
                ],
              ),
              reviewListWidget(data?.ratings ?? const []),
              25.verticalSpace,
            ],
          );
        }),
      ),
    );
  }

  Widget reviewListWidget(List<ProviderRatingItem> reviews) {
    if (reviews.isEmpty) {
      return Expanded(
        child: Center(
          child: CustomText(
            text: AppStrings.noReviewsFound,
            color: AppColors.greyLight,
            is_alignLeft: false,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return reviewContainer(reviews[index]);
        },
        separatorBuilder: (context, index) {
          return 10.verticalSpace;
        },
        itemCount: reviews.length,
      ),
    );
  }

  CustomContainer reviewContainer(ProviderRatingItem review) {
    return CustomContainer(
        boxShadow: AppShadows.shadow1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ratingWidget(initialRating: review.rating.toDouble()),
            5.verticalSpace,
            CustomText(
              text: review.ratingUser?.fullName ?? '',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            5.verticalSpace,
            CustomText(
              text: review.review,
              color: AppColors.grey,
            ),
          ],
        ));
  }

  Column ratingBarWidget(List<Map<String, dynamic>> ratings) {
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

  Column avgRatingWidget(ProviderRatingsData? data) {
    final ratingText = data?.currentRating ?? '0';
    final totalReviews = data?.totalRatings ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: ratingText,
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
          text: "$totalReviews ${AppStrings.reviews}",
          is_alignLeft: false,
          fontSize: 10.sp,
        ),
      ],
    );
  }

  Widget ratingWidget({required double initialRating}) {
    return RatingStar(
      ignoreGestures: true,
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
          width: 0.6.sw,
          child: PercentageIndicator(percent: percent),
        ),
        10.horizontalSpace,
      ],
    );
  }
}
