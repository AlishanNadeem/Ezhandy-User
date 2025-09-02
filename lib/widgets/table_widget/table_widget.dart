import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';

// ignore: must_be_immutable
class TableWidget extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  void Function()? ontap;

  TableWidget({required this.headers, required this.rows, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Fixed Header
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppPadding.padding12,
            ),
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.padding12,
            ),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(35.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: headers
                  .map((header) => Expanded(
                        child: Text(header, style: TextStyle(color: AppColors.white), textAlign: TextAlign.center),
                      ))
                  .toList(),
            ),
          ),
          5.h.verticalSpace,
          // Scrollable Rows
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: rows.map((row) => buildTableRow(row)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTableRow(List<String> rowData) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppPadding.padding12,
            vertical: 5.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(35.sp),
            boxShadow: [
              BoxShadow(
                color: AppColors.black,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: List.generate(rowData.length, (index) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                  decoration: BoxDecoration(
                    border: Border(
                      right: index != rowData.length - 1 ? BorderSide(color: AppColors.black) : BorderSide.none,
                    ),
                  ),
                  child: Text(
                    rowData[index],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }),
          )),
    );
  }
}
