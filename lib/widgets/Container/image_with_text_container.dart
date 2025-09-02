import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ImageWithTextContainer extends StatelessWidget {
  String image, text;
  void Function()? onTap;

  ImageWithTextContainer({
    required this.image,
    required this.text,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        onTap: onTap,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              // scale: 2.5.sp,
              width: 57.w,height: 57.h,
            ),
            10.verticalSpace,
            CustomText(
              text: text,
              is_alignLeft: false,
            )
          ],
        ));
  }
}
