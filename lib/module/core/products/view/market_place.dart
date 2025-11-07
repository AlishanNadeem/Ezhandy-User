import 'package:ezhandy_user/module/core/products/routing_arguments/add_edit_product_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_shadows.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_bottom_sheet.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_gradients.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/event_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:printing/printing.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this, initialIndex: 0);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        // is_registration: widget.isRegistration,
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        appBarheight: 50.h,
        title: AppStrings.marketPlace,
        // actionWidget: cartWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: addButtonWidget(context),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: DefaultTabController(
                length: 2,
                child: Column(children: [
                  // createNewEventButton(context),
                  15.verticalSpace,

                  Container(
                    // margin: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                      // border: Border.all(color: AppColors.green),
                      color: AppColors.greyBorder
                          .withOpacity(0.6), // Background color of the tab bar
                      borderRadius:
                          BorderRadius.circular(15.r), // Rounded corners
                    ),
                    child: TabBar(
                        // indicatorPadding: EdgeInsets.symmetric(vertical: 5.h),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              15.r), // Rounded corners for indicator
                          // gradient: AppGradients.backgroundGradient,
                          color: AppColors
                              .orange, // Color of the active tab indicator
                        ),
                        unselectedLabelColor: AppColors.black,
                        onTap: (val) {
                          if (val == 0) {
                            // HomeController.i.getStory();
                          } else {
                            // HomeController.i.getFlics();
                          }
                          setState(() {
                            // index = val;
                            controller.index = val;
                          });
                        },
                        labelStyle: TextStyle(
                          fontSize: 14.sp,
                          // fontFamily: AppStrings.roboto,
                        ),
                        labelColor: AppColors.white,
                        // indicatorColor: AppColors.pink,
                        controller: controller,
                        tabs: [
                          Tab(
                            text: AppStrings.products,
                          ),
                          Tab(
                            text: AppStrings.myProducts,
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        productsWidget(),
                        // eventList(),
                        myProductsWidget(),
                      ],
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  25.verticalSpace
                ]))));
  }

  Visibility addButtonWidget(BuildContext context) {
    return Visibility(
        visible: controller.index == 1,
        child: GestureDetector(
            onTap: () {
              AppNavigation.navigateTo(
                  context, AppRoutes.addEditProductScreenRoute,
                  arguments: AddEditProductRoutingArgument(
                      type: AddEditType.add.name));
            },
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppColors.orange,
                    boxShadow: AppShadows.shadow2,
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 50.sp,
                ))));
  }

  GestureDetector cartWidget() {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateTo(context, AppRoutes.addToCartScreenRoute);
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            // boxShadow: AppShadows.shadow4,
            color: AppColors.orange,
            shape: BoxShape.circle),
        child: Image.asset(AssetPath.cartIcon,
            // color: AppColors.gradient_1,
            alignment: Alignment.center,
            scale: 4.sp),
      ),
    );
  }

  // Widget createNewEventButton(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       // AppBottomSheet.showPrivatePublicBottomSheetSheet(context: context);
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(left: 210.w),
  //       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
  //       decoration: BoxDecoration(
  //           color: AppColors.blueDark,
  //           borderRadius: BorderRadius.circular(25.r)),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Icon(
  //             Icons.add,
  //             color: AppColors.white,
  //           ),
  //           CustomText(
  //             is_alignLeft: false,
  //             text: AppStrings.createEvent,
  //             color: AppColors.white,
  //             fontSize: 16.sp,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget productsWidget() {
    return Column(
      children: [
        searchTextField(),
        10.verticalSpace,
        // 10.verticalSpace,
        CustomText(text: AppStrings.products, fontWeight: FontWeight.bold),
        10.verticalSpace,
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            // physics:
            //     NeverScrollableScrollPhysics(), // so it doesn't conflict with parent scroll
            padding: EdgeInsets.zero,
            itemCount: 15,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 items per row
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.85, // adjust height/width ratio
            ),
            itemBuilder: (BuildContext context, int index) {
              return CustomContainer(
                onTap: () {
                  AppNavigation.navigateTo(
                      context, AppRoutes.productDetailScreenRoute);
                },
                isPadding: false,
                child: Column(
                  children: [
                    Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r)),
                          image: DecorationImage(
                              image: NetworkImage((index % 2 == 0)
                                  ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvkwjZwZRu4oZI77vfJ8-HBpILp4KL-gPX5w&s"
                                  : "https://plus.unsplash.com/premium_photo-1664035152480-b13ff54094f5?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                3.verticalSpace,
                                CustomText(
                                  text: "Hamkmers",
                                  maxLines: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                                2.verticalSpace,
                                CustomText(
                                  text: "\$ 10.00",
                                  color: AppColors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          Image.asset(AssetPath.cartIcon,
                              color: AppColors.orange,
                              width: 20.w,
                              height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget myProductsWidget() {
    return Column(
      children: [
        searchTextField(),
        10.verticalSpace,
        // 10.verticalSpace,
        CustomText(text: AppStrings.products, fontWeight: FontWeight.bold),
        10.verticalSpace,
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 15,
            padding: EdgeInsets.only(bottom: AppPadding.padding50),
            itemBuilder: (BuildContext ctxt, int index) {
              return CustomContainer(
                onTap: () {
                  AppNavigation.navigateTo(
                      context, AppRoutes.productDetailScreenRoute);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                              image: NetworkImage((index % 2 == 0)
                                  ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvkwjZwZRu4oZI77vfJ8-HBpILp4KL-gPX5w&s"
                                  : "https://plus.unsplash.com/premium_photo-1664035152480-b13ff54094f5?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                              fit: BoxFit.cover)),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          10.verticalSpace,
                          CustomText(
                            text: "Hammers",
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(text: "\$ 10.00"),
                          CustomText(
                            text: AppStrings.lorem3,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
                    GestureDetector(
                      onTap: () {
                        AppDialogs.showSuccessDialog(context,
                            description:
                                AppStrings.areYouSureYouWantToDeleteThisProduct,
                            // title: AppStrings.logout,
                            image: AssetPath.deletePopUpIcon,
                            isDoneShow: false,
                            btnTxt1: AppStrings.yes,
                            onTap1: () { AppDialogs.showSuccessDialog(
                                context,
                                description: "Product has been Deleted Successfully",
                                title: AppStrings.congratulation,
                                // image: AssetPath.deletePopUpIcon,
                                isDoneShow: true,
                                btnTxt1: AppStrings.ok,
                                onTap1: () {
                                  // AppNavigation.navigatorPop(context);
                                   AppNavigation.navigatorPopUntil(
                                  context, AppRoutes.marketPlaceScreenRoute);
                                },
                              );

                            },
                            btnTxt2: AppStrings.no,
                            onTap2: () {
                              AppNavigation.navigatorPop(context);
                             
                             
                            });
                      },
                      child: CircleAvatar(
                          backgroundColor: AppColors.orange,
                          radius: 10.r,
                          child: Image.asset(
                            AssetPath.deleteIcon,
                            width: 10.w,
                            height: 10.h,
                          )),
                    ),
                    10.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        AppNavigation.navigateTo(
                            context, AppRoutes.addEditProductScreenRoute,
                            arguments: AddEditProductRoutingArgument(
                                type: AddEditType.edit.name));
                      },
                      child: CircleAvatar(
                          backgroundColor: AppColors.orange,
                          radius: 10.r,
                          child: Image.asset(
                            AssetPath.editIcon,
                            width: 10.w,
                            height: 10.h,
                          )),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10.h,
              );
            },
          ),
        )
      ],
    );
  }

  // Widget filterWidget(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       AppBottomSheet.showExploreFilterSheet(context: context);
  //     },
  //     child: Image.asset(
  //       AssetPath.filterIcon,
  //       scale: 3.sp,
  //     ),
  //   );
  // }

  Widget searchTextField() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            // borderRadius: 25.r,
            // fillColor: AppColors.fieldColor,
            fontColor: AppColors.black,
            // hintColor: AppColors.iconGrey,
            // prefixIconColor: AppColors.fontColor,
            // borderColor: AppColors.backButtonPurple,
            divider: false,
            label: false,
            prefxicon: AssetPath.searchIcon,
            prefixIconColor: AppColors.greyBorder,
            hint: AppStrings.searchAnything,
            hintColor: AppColors.greyBorder,
            inputFormatters: [LengthLimitingTextInputFormatter(35)],
            // controller: firstNameController,
          ),
        ),
        10.horizontalSpace,
        CustomContainer(
            onTap: () {
              AppBottomSheet.showFilterSheet(context: context);
            },
            isPadding: false,
            bgColor: AppColors.orange,
            child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: Image.asset(
                  AssetPath.filterIcon,
                  width: 25.w,
                  height: 25.h,
                )))
      ],
    );
  }
}
