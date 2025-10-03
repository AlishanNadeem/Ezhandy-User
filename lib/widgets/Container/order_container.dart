import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class OrderContainer extends StatelessWidget {
  String? image,status, productName, amount, description, date, quantity;
  void Function()? ontap;
  bool isDetail;
  OrderContainer(
      {this.isDetail = false,
      this.ontap,
      this.productName,
      this.quantity,
      this.image,
      this.amount,
      this.status,
      this.description,
      this.date,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(onTap: ontap,
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center, // center middle column
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
              image: NetworkImage(image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        10.horizontalSpace,

        /// Middle Column (center vertically)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start, // 👈 centers vertically
            children: [
              CustomText(
                text: "Hammers",
                fontWeight: FontWeight.bold,
              ),
              CustomText(text: "\$ 10.00"),
              CustomText(
                text: AppStrings.lorem3,
                fontSize: 12.sp,
                maxLines: 2,
                // overflow: TextOverflow.ellipsis,
              ),
              5.verticalSpace,

              /// Right Side Text (stick to bottom)
              Row(
                children: [
                  CustomText(text:status),
                  2.horizontalSpace,
                  Visibility(visible: status=="Delivered",
                    child: CircleAvatar(
                      radius: 5.r,
                      backgroundColor: AppColors.orange,
                    ),
                  ),
                  Spacer(),
                  CustomText(text: AppStrings.dummyDate),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
