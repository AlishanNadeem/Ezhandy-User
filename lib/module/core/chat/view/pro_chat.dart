import 'dart:developer';
import 'package:ezhandy_user/module/core/booking/routing_arguments/booking_routing_arguments.dart';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/row/two_text_row.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ProChat extends StatefulWidget {
  ProChat({super.key});

  @override
  State<ProChat> createState() => _ProChatState();
}

class _ProChatState extends State<ProChat> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      // appBarheight: 50.h,
      title: AppStrings.proChat,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding14),
        child: Column(
          children: [
            10.verticalSpace,

            searchTextField(),
            // 10.verticalSpace,
            // 10.verticalSpace,
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(
                    top: AppPadding.padding20, bottom: AppPadding.padding25),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  // final item = notifications[index];
                  return singleWidget(
                    ontap: () {
                      AppNavigation.navigateTo(
                          context, AppRoutes.chatScreenRoute,
                          arguments: ChatRoutingArgument(
                              isBooking: false, isCalls: true));
                    },
                    time: "1 min ago",
                    des: "Hello everyone",
                    image: AssetPath.userIcon,
                    lastMes: AppStrings.lorem5,
                    name: AppStrings.dummyName,
                  );
                },
                separatorBuilder: (context, index) {
                  return 10.verticalSpace;
                },
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget singleWidget({time, name, image, des, ontap, lastMes}) {
    return CustomContainer(
      onTap: ontap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserImageWidget(),
          5.horizontalSpace,
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: name,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w500,
                  // fontSize: 10.sp,
                ),
                CustomText(
                  text: des,
                  // color: AppColors.orange,
                  // fontWeight: FontWeight.w500,
                  maxLines: 1,

                  fontSize: 12.sp,
                ),
                CustomText(
                  text: lastMes,
                  // color: AppColors.orange,
                  // fontWeight: FontWeight.w500,
                  maxLines: 1,
                  fontSize: 12.sp,
                  // fontSize: 10.sp,
                ),
              ],
            ),
          ),
          Spacer(),
          CustomText(
            text: time,
            color: AppColors.greyLight,
            fontWeight: FontWeight.w500,
            // fontSize: 10.sp,
          ),
        ],
      ),
    );
  }
}
