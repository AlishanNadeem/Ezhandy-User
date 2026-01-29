import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/module/core/main_menu/main_menu_user.dart';
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

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // String? filterStartValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          10.verticalSpace,
          appbarWidget(),
          20.verticalSpace,
          searchTextField(),
          10.verticalSpace,
                    CustomButton(text: "Pro Chats",color: AppColors.black,onclick: (){AppNavigation.navigateTo(context, AppRoutes.proChatScreenRoute);},),

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
                    AppNavigation.navigateTo(context, AppRoutes.chatScreenRoute,
                        arguments: ChatRoutingArgument(isBooking: true));
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

  Row appbarWidget() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              globalkey.currentState!.openDrawer();
            },
            child: Image.asset(
              AssetPath.menuIcon,
              alignment: Alignment.centerLeft,
              scale: 4.sp,
              color: AppColors.black,
            ),
          ),
          10.horizontalSpace,
      
        CustomText(
          text: AppStrings.messages,
          // fontFamily: AppStrings.montserrat,
          // color: AppColors.blueDark,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        Spacer(),
        notificationWidget(context)
      ],
    );
  }

  GestureDetector notificationWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateTo(context, AppRoutes.notificationScreenRoute);
      },
      child: Image.asset(AssetPath.bellIcon, width: 20.w, height: 20.h),
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
