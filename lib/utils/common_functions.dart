// import 'package:elpistoken/utils/routes/app_navigation.dart';
// import 'package:elpistoken/utils/routes/app_route.dart';
// import 'package:flutter/material.dart';

class CommonFunctions {
  CommonFunctions._();
  // static onTapViewImage({
  //   required BuildContext context,
  //   String? image,
  //   String? mediaType,
  // }) {
  //   if (image != "" && image != null) {
  //     AppNavigation.navigateTo(context, AppRoutes.viewFullImageScreenRoute,
  //         arguments: ViewFullImageRoutingArgumentss(
  //             mediaType: mediaType ?? MediaPathType.network.name,
  //             image: image));
  //   }
  // }
  // /// To navigate to Role selection Screen
  // static Future<bool> navigateToRemoveAllRoleSelection() async {
  //   AppNavigation.navigateToRemovingAll(StaticData.navigatorKey.currentContext!,
  //       AppRouteName.roleSelectionScreenRoute);
  //   return false;
  // }
  //
  // /// To get user object
  // static UserModelData? getUserProfileData({required BuildContext context}) {
  //   if (context.read<UserProvider>().getCurrentUser != null) {
  //     return context.read<UserProvider>().getCurrentUser?.data;
  //   } else {
  //     return null;
  //   }
  // }
  //
  // /// To get user object
  // static String? getUserRole({required BuildContext context}) {
  //   if (context.read<UserProvider>().getCurrentUser != null) {
  //     return context.read<UserProvider>().getCurrentUser?.data?.userType;
  //   } else {
  //     return null;
  //   }
  // }
  //
  // /// To view image

  //
  // /// To view pdf
  // static onTapViewPdf({
  //   required BuildContext context,
  //   String? media,
  //   String? mediaType,
  // }) {
  //   if (media != "" && media != null) {
  //     AppNavigation.navigateTo(context, AppRouteName.viewPdfScreenRoute,
  //         arguments: ViewPdfRoutingArguments(
  //             mediaPathType: mediaType ?? MediaPathType.network.name,
  //             mediaPath: NetworkStrings.IMAGE_BASE_URL + media));
  //   }
  // }
  //
  // /// get reason list for cancel request
  // static void fetchReasonRequestCancel(
  //     {RequestCancelReasonListProvider? reasonListProvider,
  //     required BuildContext context}) async {
  //   reasonListProvider = context.read<RequestCancelReasonListProvider>();
  //   if ((reasonListProvider.reasonList ?? []).isEmpty) {
  //     await reasonListProvider.fetchData(context: context);
  //   }
  // }
  //
  // /// Check User Profile Completion
  // static bool isProfileCompleted({required BuildContext context}) {
  //   UserModelData? user = context.read<UserProvider>().getCurrentUser?.data;
  //   return [
  //     user?.address,
  //     user?.gender,
  //     user?.ageRange,
  //     user?.educationLevel,
  //     user?.interests,
  //     user?.isPet,
  //     user?.state,
  //     user?.city,
  //     user?.zipCode,
  //     // user?.bio
  //   ].every((Object? field) => field != null);
  // }
  //
  // /// Join text comma Seperated
  // static String? joinWithCommasString(List<String?>? inputList) {
  //   if ((inputList ?? []).isNotEmpty) {
  //     if ((inputList?.length ?? 0) <= 3) {
  //       return inputList?.join(',');
  //     } else {
  //       return (inputList?.sublist(0, 3).join(',') ?? "") + '...';
  //     }
  //   } else {
  //     return null;
  //   }
  // }
  //
  // static String? convertDateToAmericanFormat({String? date, String? format}) {
  //   DateTime? _date = Constants.parseDateTime(
  //       parseFormat: AppStrings.DATE_MONTH_YEAR_FORMAT_YYYY_MM_DD,
  //       inputDateTime: (date ?? DateTime.now().toString()));
  //   date = Constants.formatDateTime(
  //       parseFormat: format ?? AppStrings.DATE_MONTH_YEAR_FORMAT_YYYY_MM_DD,
  //       inputDateTime: _date);
  //   return date;
  // }
  //
  // /// Notification Navigation Route
  //
  // /// Navigate to Incoming Reservation
  // static goToIncomingRequestDetails(
  //     {required BuildContext context, int? reservationId, String? pushType}) {
  //   AppNavigation.navigateTo(
  //       context, AppRouteName.incomingInProgressDetailScreenRoute,
  //       arguments: IncomingOrInProgressArguments(
  //           requestId: reservationId,
  //           pushType: pushType,
  //           title: AppStrings.incomingRequests));
  // }
  //
  // /// Navigate to Booking History
  // static goToBookingHistoryDetails(
  //     {required BuildContext context, int? reservationId, String? pushType}) {
  //   AppNavigation.navigateTo(
  //       context, AppRouteName.incomingInProgressDetailScreenRoute,
  //       arguments: IncomingOrInProgressArguments(
  //           pushType: pushType,
  //           requestId: reservationId,
  //           title: AppStrings.bookingDetail));
  // }
  //
  // /// Navigate to Reservation  Inprogress Details
  // static goToInProgressDetails(
  //     {required BuildContext context, int? reservationId, String? pushType}) {
  //   AppNavigation.navigateTo(
  //       context, AppRouteName.incomingInProgressDetailScreenRoute,
  //       arguments: IncomingOrInProgressArguments(
  //           pushType: pushType,
  //           requestId: reservationId,
  //           title: AppStrings.inProgres));
  // }
  //
  // /// Navigate to Rating
  // static goToRatingList({
  //   required BuildContext context,
  // }) {
  //   AppNavigation.navigateTo(context, AppRouteName.moverMainMenuScreenRoute,
  //       arguments: MoverHomeArguments(index: 1));
  // }
  //
  // static String convertTo12HourFormat(String time24Hour) {
  //   // Parse the input time
  //   DateTime dateTime = DateFormat.Hm().parse(time24Hour);
  //
  //   // Format the time in 12-hour format
  //   String time12Hour = DateFormat.jm().format(dateTime);
  //
  //   return time12Hour;
  // }
  //
  // static Future<bool> checkKilledNotification({required bool? isKilled}) async {
  //   StaticData.currentRoute = null;
  //   if (isKilled == true) {
  //     navigateToRemoveAllHomeScreen();
  //   } else {
  //     AppNavigation.navigatorPop(StaticData.navigatorKey.currentContext!);
  //   }
  //
  //   return true;
  // }
  //
  // /// Navigate To User Home Screen
  // static Future<bool> navigateToRemoveAllHomeScreen() async {
  //   AppNavigation.navigateToRemovingAll(
  //     StaticData.navigatorKey.currentContext!,
  //     AppRouteName.userMainMenuScreenRoute,
  //   );
  //   return false;
  // }
}
