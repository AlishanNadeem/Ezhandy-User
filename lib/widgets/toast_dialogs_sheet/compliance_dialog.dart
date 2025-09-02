import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ComplianceDialog extends StatefulWidget {
  String? stateFiling, permitsRenewal, licenseUpdate;
  final void Function(String) onBtnTap;
  // final void Function(String)? onTapState, onTapPermits, onTapLicense;
  ComplianceDialog(
      {
      //   this.onTapLicense,
      // this.onTapPermits,
      required this.onBtnTap,
      this.stateFiling,
      this.permitsRenewal,
      this.licenseUpdate,
      super.key});

  @override
  State<ComplianceDialog> createState() => _ComplianceDialogState();
}

class _ComplianceDialogState extends State<ComplianceDialog> {
  DateTime? state, permits, license;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: AppPadding.padding16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Close Button
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: AppColors.pinkDark,
                  child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                ),
              ),
            ),

            // fghfgh
            Image.asset(
              AssetPath.complianceCheckIcon,
              width: 100.w,
              height: 100.h,
            ),

            /// Title
            CustomText(
              text: "Compliance Deadlines",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blueDark,
              is_alignLeft: false,
            ),
            10.verticalSpace,

            /// Deadline Rows
            Divider(
              color: AppColors.blueDark,
            ),
            _deadlineRow(title: "Deadline", value: "Due Date"),
            Divider(
              color: AppColors.blueDark,
            ),
            _deadlineRow(
              title: "State filing:",
              value: widget.stateFiling,
              ontap: () async {
                state = await Utils.displayDatePicker(
                    context: context,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                    date: DateTime.now());
                if (state != null) {
                  widget.stateFiling = Utils.formatDate(
                      pattern: AppStrings.MMM_DD_YYYY_FORMAT, date: state);
                  setState(() {});
                  log(widget.stateFiling.toString());
                  log(widget.stateFiling.toString());
                }
              },
            ),
            // Divider(),
            Divider(
              color: AppColors.blueDark,
            ),
            _deadlineRow(
              title: "Permits renewal:",
              value: widget.permitsRenewal,
              ontap: () async {
                permits = await Utils.displayDatePicker(
                    context: context,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                    date: DateTime.now());
                if (permits != null) {
                  widget.permitsRenewal = Utils.formatDate(
                      pattern: AppStrings.MMM_DD_YYYY_FORMAT, date: permits);
                  setState(() {});
                }
              },
            ),
            // Divider(),
            Divider(
              color: AppColors.blueDark,
            ),
            _deadlineRow(
              title: "License update:",
              value: widget.licenseUpdate,
              ontap: () async {
                license = await Utils.displayDatePicker(
                    context: context,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                    date: DateTime.now());
                if (license != null) {
                  widget.licenseUpdate = Utils.formatDate(
                      pattern: AppStrings.MMM_DD_YYYY_FORMAT, date: license);
                  setState(() {});
                }
              },
            ),

            SizedBox(height: 20.h),

            /// Save Button
            CustomButton(
              text: AppStrings.save,
              onclick: () {
                widget.onBtnTap(widget.stateFiling ?? "");
                AppNavigation.navigatorPop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  /// Reusable Row widget
  Widget _deadlineRow({String? title, String? value, ontap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child:
                CustomText(text: title, fontSize: 14.sp, color: Colors.black87),
          ),
          Expanded(
            flex: 1,
            child: CustomText(
              text: value ?? "",
              textAlign: TextAlign.right,
              fontWeight: FontWeight.w600,
              color: AppColors.blueDark,
            ),
          ),
          8.horizontalSpace,
          // SizedBox(width: 8.w),
          GestureDetector(
            onTap: value == "Due Date" ? () {} : ontap,
            child: Image.asset(AssetPath.editIcon,
                color: value == "Due Date" ? AppColors.transparent : null,
                width: 20.w,
                height: 20.h),
          ),
          // SizedBox(width: 8.w),
          8.horizontalSpace,
          Image.asset(AssetPath.deleteRedIcon,
              color: value == "Due Date" ? AppColors.transparent : null,
              width: 20.w,
              height: 20.h),
        ],
      ),
    );
  }
}
