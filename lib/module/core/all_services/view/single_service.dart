import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class SingleService extends StatefulWidget {
  String? serviceName,type;

  SingleService({this.serviceName,this.type, super.key});

  @override
  State<SingleService> createState() => _SingleServiceState();
}

class _SingleServiceState extends State<SingleService> {
  // String? filterStartValue;

  // bool isLike=false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: widget.serviceName,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              searchTextField(),
              10.verticalSpace,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: AppPadding.padding25),
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    // final item = notifications[index];
                    return singleWidget(
                      ontap: () {
                        AppNavigation.navigateTo(
                            context, AppRoutes.providerProfileScreenRoute,arguments: ServiceRoutingArgument(type: widget.type));
                      },
                      address: AppStrings.lorem5,
                      amount: (index + 12).toString(),
                      rating: "4.3",
                      image: AssetPath.userIcon,
                      lastMes: AppStrings.dummylorem,
                      name: AppStrings.dummyName,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 20.verticalSpace;
                  },
                ),
              ),
              // 25.verticalSpace
            ],
          ),
        ));
  }

  Widget searchTextField() {
    return CustomTextField(
      label: false,
      prefxicon: AssetPath.searchIcon,
      hint: AppStrings.searchAnything,
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      // controller: firstNameController,
    );
  }

  Widget singleWidget({name, image, lastMes, address, amount, rating, ontap}) {
    return CustomContainer(
      onTap: ontap,
      isPadding: false,
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.padding14,
          bottom: AppPadding.padding14,
          left: AppPadding.padding14,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserImageWidget(),
            5.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      CustomText(
                        text: lastMes,
                        maxLines: 1,
                        fontSize: 12.sp,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      10.horizontalSpace,
                      Icon(
                        Icons.star,
                        color: AppColors.orange,
                        size: 15.sp,
                      ),
                      CustomText(
                        text: rating,
                        color: AppColors.orange,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.orange,
                        size: 15.sp,
                      ),
                      2.horizontalSpace,
                      Expanded(
                        child: CustomText(
                          text: address,
                          maxLines: 1,
                          fontSize: 12.sp,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10), // ✅ instead of Spacer
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.r),
                  bottomLeft: Radius.circular(35.r),
                ),
              ),
              child: CustomText(
                text: "\$$amount",
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
