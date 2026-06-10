import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingStar extends StatefulWidget {
  double initialRating;
  bool? ignoreGestures;
  double? itemSize;
  void Function(double) onRatingUpdate;
  RatingStar({required this.onRatingUpdate, required this.initialRating, this.ignoreGestures = false, this.itemSize, super.key});

  @override
  State<RatingStar> createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      ignoreGestures: widget.ignoreGestures!,
      initialRating: widget.initialRating,
      // unratedColor: Colors.red,
      glow: false,
      allowHalfRating: true,
      direction: Axis.horizontal,
      itemSize: widget.itemSize ?? 30.sp,
      ratingWidget: RatingWidget(
        full: Icon(Icons.star, color: AppColors.orange),
        half: Icon(Icons.star_half, color: AppColors.orange),
        empty: Icon(Icons.star_outline, color: AppColors.greyBorder),
      ),
      onRatingUpdate: (rating) {
        // log(rating.toString());
        widget.onRatingUpdate(rating);
        setState(() {
          widget.initialRating = rating;
        });
        print(rating.toString());
      },
    );
  }
}
