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
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/module/core/products/controller/market_place_controller.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final MarketPlaceController _marketPlaceController = Get.put(MarketPlaceController());
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
                          setState(() {
                            controller.index = val;
                          });
                          if (val == 0) {
                            _marketPlaceController.getProducts();
                          } else {
                            _marketPlaceController.getMyProducts();
                          }
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
        searchTextField(onSearch: _marketPlaceController.updateProductsSearch),
        10.verticalSpace,
        CustomText(text: AppStrings.products, fontWeight: FontWeight.bold),
        10.verticalSpace,
        Expanded(
          child: Obx(() => _buildProductsTab()),
        ),
      ],
    );
  }

  Widget _buildProductsTab() {
    final loading = _marketPlaceController.productsLoading.value;
    final list = _marketPlaceController.filteredProductsList;

    if (loading && _marketPlaceController.productsList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _marketPlaceController.getProducts,
      color: AppColors.orange,
      child: list.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 0.4.sh,
                  child: Center(
                    child: CustomText(
                      text: "No products found",
                      color: AppColors.greyLight,
                      is_alignLeft: false,
                    ),
                  ),
                ),
              ],
            )
          : GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (BuildContext context, int index) {
                final product = list[index];
                final imageUrl = product['mainImagePath'] != null
                    ? "${product['mainImagePath']}"
                    : "https://via.placeholder.com/150";

                return CustomContainer(
                  onTap: () {
                    AppNavigation.navigateTo(
                      context,
                      AppRoutes.productDetailScreenRoute,
                      arguments: product['id'],
                    );
                  },
                  isPadding: false,
                  child: Column(
                    children: [
                      Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 3.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  3.verticalSpace,
                                  CustomText(
                                    text: product['title'] ?? '',
                                    maxLines: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  2.verticalSpace,
                                  CustomText(
                                    text: "\$ ${product['price'] ?? '0.00'}",
                                    color: AppColors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              AssetPath.cartIcon,
                              color: AppColors.orange,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget myProductsWidget() {
    return Column(
      children: [
        searchTextField(onSearch: _marketPlaceController.updateMyProductsSearch),
        10.verticalSpace,
        CustomText(text: AppStrings.myProducts, fontWeight: FontWeight.bold),
        10.verticalSpace,
        Expanded(
          child: Obx(() => _buildMyProductsTab()),
        ),
      ],
    );
  }

  Widget _buildMyProductsTab() {
    final loading = _marketPlaceController.myProductsLoading.value;
    final list = _marketPlaceController.filteredMyProductsList;

    if (loading && _marketPlaceController.myProductsList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _marketPlaceController.getMyProducts,
      color: AppColors.orange,
      child: list.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: AppPadding.padding50),
              children: [
                SizedBox(
                  height: 0.4.sh,
                  child: Center(
                    child: CustomText(
                      text: "No products found",
                      color: AppColors.greyLight,
                      is_alignLeft: false,
                    ),
                  ),
                ),
              ],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: list.length,
              padding: EdgeInsets.only(bottom: AppPadding.padding50),
              itemBuilder: (BuildContext ctxt, int index) {
                final product = list[index];
                final imageUrl = product['mainImagePath'] != null
                    ? "${product['mainImagePath']}"
                    : "https://via.placeholder.com/150";

                return CustomContainer(
                  onTap: () {
                    AppNavigation.navigateTo(
                      context,
                      AppRoutes.productDetailScreenRoute,
                      arguments: product['id'],
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.verticalSpace,
                            CustomText(
                              text: product['title'] ?? '',
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: "\$ ${product['price'] ?? '0.00'}",
                              color: AppColors.orange,
                            ),
                            CustomText(
                              text: product['description'] ?? '',
                              fontSize: 12.sp,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppDialogs.showSuccessDialog(
                            context,
                            description: AppStrings
                                .areYouSureYouWantToDeleteThisProduct,
                            image: AssetPath.deletePopUpIcon,
                            isDoneShow: false,
                            btnTxt1: AppStrings.yes,
                            onTap1: () {
                              AppNavigation.navigatorPop(context);
                              _marketPlaceController.deleteProduct(
                                productId: product['id'],
                                onSuccess: () {
                                  AppDialogs.showSuccessDialog(
                                    context,
                                    description:
                                        "Product has been Deleted Successfully",
                                    title: AppStrings.congratulation,
                                    isDoneShow: true,
                                    btnTxt1: AppStrings.ok,
                                    onTap1: () {
                                      AppNavigation.navigatorPop(context);
                                    },
                                  );
                                },
                              );
                            },
                            btnTxt2: AppStrings.no,
                            onTap2: () {
                              AppNavigation.navigatorPop(context);
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.orange,
                          radius: 10.r,
                          child: Image.asset(
                            AssetPath.deleteIcon,
                            width: 10.w,
                            height: 10.h,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          AppNavigation.navigateTo(
                            context,
                            AppRoutes.addEditProductScreenRoute,
                            arguments: AddEditProductRoutingArgument(
                              type: AddEditType.edit.name,
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.orange,
                          radius: 10.r,
                          child: Image.asset(
                            AssetPath.editIcon,
                            width: 10.w,
                            height: 10.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10.h);
              },
            ),
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

  Widget searchTextField({required void Function(String) onSearch}) {
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
            onchange: onSearch,
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
