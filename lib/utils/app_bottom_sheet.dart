import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/explore_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppBottomSheet {
  static void showToast({String? message}) {
    Fluttertoast.showToast(
      msg: message ?? "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  static void showFilterSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.orange.withOpacity(0.6),
      context: context,
      builder: (BuildContext context) {
        return FilterBottomSheet();
      },
    );
  }

  // static void showExploreFilterSheet({
  //   required BuildContext context,
  // }) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     backgroundColor: AppColors.transparent,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return ExploreFilterBottomSheet();
  //     },
  //   );
  // }

  // static void showPrivatePublicBottomSheetSheet({
  //   required BuildContext context,
  // }) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     backgroundColor: AppColors.transparent,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return PrivatePublicBottomSheet();
  //     },
  //   );
  // }

  // static void showRideSelectionSheet({
  //   required BuildContext context,
  // }) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     backgroundColor: AppColors.transparent,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return RideSelectionBottomSheet();
  //     },
  //   );
  // }

  // static void showAddEditEventSheet({
  //   required BuildContext context,
  //   String? type,
  // }) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     backgroundColor: AppColors.transparent,
  //     isDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AddEditEvent(
  //         type: type,
  //       );
  //     },
  //   );
  // }

  // static void showEventDetailsSheet({
  //   required BuildContext context,
  // }) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     backgroundColor: AppColors.transparent,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return EventDetailsBottomSheet();
  //     },
  //   );
  // }
}
