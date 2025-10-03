import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/module/auth/content/routing_arguments/content_routing_arguments.dart';
import 'package:ezhandy_user/module/auth/content/view/content_screen.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_gradients.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_shadows.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/Container/event_container.dart';
import 'package:ezhandy_user/widgets/Container/order_container.dart';
import 'package:ezhandy_user/widgets/Container/restaurant_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/switch/animated_switch.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/toast.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        // is_registration: widget.isRegistration,
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        appBarheight: 50.h,
        title: AppStrings.orders,
        child: Column(children: [
          10.verticalSpace,
          tabList(),
          5.verticalSpace,
          orderList(),
        ]));
  }

  Widget tabList() {
    return Container(
      height: 40.h,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return tabWidget(
            text: AppStrings.bookingTabList[index],
            // bgColor: currentIndex == index ? null : AppColors.transparent,
            // borderColor: currentIndex == index ? null : AppColors.green,
            // textColor: currentIndex == index ? AppColors.white : null,
            isSelected: currentIndex == index,
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 5.w,
          );
        },
        itemCount: AppStrings.bookingTabList.length,
      ),
    );
  }

  Widget tabWidget(
      {String? text, void Function()? onTap, bool isSelected = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch, // make child use full width
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: text,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
              SizedBox(height: 2),
              Visibility(
                visible: isSelected,
                child: Container(
                  height: 2,

                  width: 25.w,
                  // line thickness
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: AppColors.orange,
                ),
              ),
            ],
          )),
    );
  }

  Widget orderList() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 15,
        padding: EdgeInsets.only(left: AppPadding.padding12,right: AppPadding.padding12,bottom: AppPadding.padding25),
        itemBuilder: (BuildContext ctxt, int index) {
          return OrderContainer(
              image: (index % 2 == 0)
                  ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvkwjZwZRu4oZI77vfJ8-HBpILp4KL-gPX5w&s"
                  : "https://plus.unsplash.com/premium_photo-1664035152480-b13ff54094f5?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              productName: "Hammers",
              amount: "\$10.99",
              description: AppStrings.lorem1,
              date: AppStrings.dummyDate,
              status: getStatusText(currentIndex),
              ontap: () {
                if (currentIndex == 0) {
                  AppNavigation.navigateTo(
                    context, AppRoutes.orderDetailScreenRoute,
                    // arguments: OrderDetailsRoutingArgument(
                    //     status: AppStrings.bookingTabList[currentIndex])
                  );
                }
              });
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 15.h,
          );
        },
      ),
    );
  }

  String getStatusText(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return "";
      case 1:
        return "Mark as Deliverd";
      case 2:
        return "Delivered";
      case 3:
        return "Canceled";
      default:
        return "";
    }
  }
}
