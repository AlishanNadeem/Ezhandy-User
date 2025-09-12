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

class ListOfServices extends StatefulWidget {
  String? type;

  ListOfServices({this.type, super.key});

  @override
  State<ListOfServices> createState() => _ListOfServicesState();
}

class _ListOfServicesState extends State<ListOfServices> {
  // String? filterStartValue;
  List<bool> servicesList = [
    false,
    false,
    false,
    true,
    false,
    false,
    false,
    false,
    false,
  ];
  // bool isLike=false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.listOfServices,
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
                  itemCount: servicesList.length,
                  itemBuilder: (context, index) {
                    // final item = notifications[index];
                    return singleContainer(
                        index: index,
                        onTap: () {
                          AppNavigation.navigateTo(
                              context, AppRoutes.servicesScreenRoute,
                              arguments: ServiceRoutingArgument(
                                  serviceName: AppStrings.titleName,
                                  type: widget.type));
                        }
                        // ontap: () {
                        //   // AppNavigation.navigateTo(context, AppRoutes.chatScreenRoute,
                        //   //     arguments: ChatRoutingArgument(isBooking: true));
                        // },
                        // time: "1 min ago",
                        // des: "Hello everyone",
                        // image: AssetPath.userIcon,
                        // lastMes: AppStrings.lorem5,
                        // name: AppStrings.dummyName,
                        );
                  },
                  separatorBuilder: (context, index) {
                    return 20.verticalSpace;
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget singleContainer({onTap, index}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: .45.sw,
        height: .3.sh,
        // padding: EdgeInsets.all(AppPadding.padding12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetPath.tempCleaningImage)

                // NetworkImage(
                //     "https://www.pristinehome.com.au/wp-content/uploads/2018/07/How-to-Choose-the-Best-House-Cleaning-Service.jpg")
                )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [10.verticalSpace, detailsContainer()],
        ),
      ),
    );
  }

  Widget detailsContainer() {
    return Padding(
      padding: EdgeInsets.all(AppPadding.padding12),
      child: CustomContainer(
          child: Row(
        children: [
          Image.asset(
            AssetPath.cleaningIcon,
            width: 30.w,
            height: 30.h,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              children: [
                CustomText(text: AppStrings.titleName),
                5.verticalSpace,
                CustomText(
                  text: AppStrings.lorem5,
                  maxLines: 3,
                )
              ],
            ),
          ),
        ],
      )),
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
}
