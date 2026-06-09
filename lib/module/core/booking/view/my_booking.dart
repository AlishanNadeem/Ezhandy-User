import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/booking/controller/booking_history_controller.dart';
import 'package:ezhandy_user/module/core/booking/model/user_booking_model.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/booking_routing_arguments.dart';
import 'package:ezhandy_user/module/core/main_menu/main_menu_user.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  static const _controllerTag = 'my_booking';

  final TextEditingController _searchController = TextEditingController();

  BookingHistoryController get _controller {
    if (Get.isRegistered<BookingHistoryController>(tag: _controllerTag)) {
      return Get.find<BookingHistoryController>(tag: _controllerTag);
    }
    return Get.put(BookingHistoryController(), tag: _controllerTag);
  }

  @override
  void dispose() {
    _searchController.dispose();
    if (Get.isRegistered<BookingHistoryController>(tag: _controllerTag)) {
      Get.delete<BookingHistoryController>(tag: _controllerTag);
    }
    super.dispose();
  }

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
          Expanded(
            child: Obx(() => _buildBookingList(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList(BuildContext context) {
    if (_controller.isLoading.value && _controller.bookings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final list = _controller.filteredBookings;

    return RefreshIndicator(
      onRefresh: _controller.fetchUserBookings,
      color: AppColors.orange,
      child: list.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: AppPadding.padding20,
                bottom: AppPadding.padding25,
              ),
              children: [
                SizedBox(
                  height: 0.5.sh,
                  child: Center(
                    child: CustomText(
                      text: AppStrings.noBookingsFound,
                      color: AppColors.greyLight,
                      is_alignLeft: false,
                    ),
                  ),
                ),
              ],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: AppPadding.padding20,
                bottom: AppPadding.padding25,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final booking = list[index];
                return singleWidget(
                  ontap: () {
                    AppNavigation.navigateTo(
                      context,
                      AppRoutes.bookingScreenRoute,
                      arguments: BookingRoutingArgument(
                        bookingId: booking.bookingId,
                        Status: booking.statusLabel,
                      ),
                    );
                  },
                  date: _formatBookingDate(booking),
                  status: booking.statusLabel,
                  bookingId: booking.bookingId.toString(),
                  total: booking.amount,
                );
              },
              separatorBuilder: (context, index) => 10.verticalSpace,
            ),
    );
  }

  Widget searchTextField() {
    return CustomTextField(
      label: false,
      prefxicon: AssetPath.searchIcon,
      hint: AppStrings.searchAnything,
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      controller: _searchController,
      onchange: _controller.updateSearch,
    );
  }

  String _formatBookingDate(UserBooking booking) {
    final dt = DateTime.tryParse(booking.bookingDate);
    if (dt != null) {
      return DateFormat('dd MMM yyyy').format(dt);
    }
    return booking.bookingDate;
  }

  Row appbarWidget() {
    return Row(
      children: [
        GestureDetector(
          onTap: (!AuthController.i.isLoginSignUp.value)
              ? () {
                  signinSignUpPopup();
                }
              : () {
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
          text: AppStrings.myBookings,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        const Spacer(),
        notificationWidget(context),
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

  Widget singleWidget({date, bookingId, status, total, ontap}) {
    return CustomContainer(
      onTap: ontap,
      child: Column(
        children: [
          5.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: date,
                color: AppColors.greyLight,
                fontSize: 10.sp,
              ),
              CustomText(
                text: "${AppStrings.status}: $status",
                color: AppColors.greyLight,
                fontSize: 10.sp,
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "${AppStrings.bookingId}: #$bookingId",
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "\$ $total",
                color: AppColors.orange,
              ),
            ],
          ),
          5.verticalSpace,
        ],
      ),
    );
  }

  void signinSignUpPopup() {
    AppDialogs.showSuccessDialog(
      context,
      barrierDismissible: true,
      description: AppStrings.inOrderToAccessThis,
      image: AssetPath.tumbIcon,
      isDoneShow: false,
      btnTxt1: AppStrings.logIn.toUpperCase(),
      onTap1: () {
        AppNavigation.navigateToRemovingAll(
            context, AppRoutes.loginScreenRoute);
      },
      btnTxt2: AppStrings.signUp.toUpperCase(),
      onTap2: () {
        AppNavigation.navigateToRemovingAll(
            context, AppRoutes.loginScreenRoute);
        AppNavigation.navigateTo(context, AppRoutes.signupScreenRoute);
      },
    );
  }
}
