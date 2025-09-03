import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? filterStartValue;
  var filterList = ["All", "Weekly", "Monthly"];
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.notifications,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              // CustomText(
              //     text: AppStrings.notifications,
              //     fontFamily: AppStrings.montserrat,
              //     color: AppColors.blueDark,
              //     fontSize: 20.sp,
              //     fontWeight: FontWeight.bold),
              // 20.verticalSpace,
              filterRowWidget(),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    // final item = notifications[index];
                    return SlidableWidget(
                      child: notificationWidget(
                        image: AssetPath.infoIcon,
                        title: "Lorem Ipsum Dolor",
                        description:
                            "Lorem Ipsum is simply dummy text of the printing and typesetting",
                        date: DateTime(2023, 12, 29, 16, 45),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 20.verticalSpace;
                  },
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ));
  }

  Widget notificationWidget({image, title, description, date}) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white, // 👈 Make the card white
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.orange,
            ),
            child: Image.asset(
              image,
              width: 14.w,
              height: 14.h,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontWeight: FontWeight.w600,
                ),
                4.verticalSpace,
                CustomText(
                  text: description,
                ),
                4.verticalSpace,
                Text(
                  DateFormat("dd MMM yyyy - HH:mm a").format(date),
                  style: const TextStyle(fontSize: 12, color: AppColors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row filterRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [CustomText(text: AppStrings.showing), filterDropDown()],
    );
  }

  Widget filterDropDown() {
    return CustomDropDown2(
      width: 110.w, // 👈 Controls button width
      dropDownWidth: 150.w, // 👈 Controls dropdown menu width
      dropDownData: filterList,
      borderColor: AppColors.transparent,
      hintText: "All",
      dropdownValue: filterStartValue,
      dropdownListColor: AppColors.white,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        setState(() {
          filterStartValue = value.toString();
        });
      },
    );
  }
}
