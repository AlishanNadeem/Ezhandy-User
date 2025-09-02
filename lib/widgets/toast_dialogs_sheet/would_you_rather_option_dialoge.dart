import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/button_widgets/cross_button.dart';

class OptionDialog extends StatefulWidget {
  final String question1;
  final String question2;
  final Function(String) onSelect;
  OptionDialog({required this.question1, required this.question2, required this.onSelect});
  @override
  _OptionDialogState createState() => _OptionDialogState();
}

class _OptionDialogState extends State<OptionDialog> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: 400,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          color: Color(0xffF4EEF6),
        ),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50.w,
                    ),
                    Text(
                      'Would you Rather',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CrossButton(
                        iconColor: AppColors.white,
                        circleColor: AppColors.black,
                        onTap: () {
                          AppNavigation.navigatorPop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Option No. 1
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Option No.1:",
                    style: TextStyle(color: Color(0xff222222), fontSize: 16.sp, fontWeight: FontWeight.w300),
                  ),
                  5.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 'Option No.1';
                      });
                      widget.onSelect('Option No.1');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 308,
                      height: 79,
                      decoration: BoxDecoration(
                        color: selectedOption == 'Option No.1' ? Color(0xff7272FF) : AppColors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(0),
                        ),
                        border: Border.all(color: selectedOption == 'Option No.1' ? Color(0xff7272FF) : Color(0xff7272FF)),
                      ),
                      child: Text(widget.question1,
                          style: TextStyle(
                              color: selectedOption == "Option No.1" ? Color(0xffFFFFFF) : Color(0xff393636),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Option No. 2
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Option No.2:",
                    style: TextStyle(color: Color(0xff222222), fontSize: 16.sp, fontWeight: FontWeight.w300),
                  ),
                  5.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 'Option No.2';
                      });
                      widget.onSelect('Option No.2');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 308,
                      height: 79,
                      decoration: BoxDecoration(
                        color: selectedOption == 'Option No.2' ? Color(0xff7272FF) : AppColors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(0),
                        ),
                        border: Border.all(color: selectedOption == 'Option No.2' ? Color(0xff7272FF) : Color(0xff7272FF)),
                      ),
                      child: Text(
                        widget.question2,
                        style: TextStyle(
                            color: selectedOption == "Option No.2" ? Color(0xffFFFFFF) : Color(0xff393636),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Submit Button
            Container(
              width: 308.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.r),
                gradient: LinearGradient(
                  colors: [Color(0xffE3A1FF), Color(0xff7272FF)],
                ),
              ),
              child: TextButton(
                onPressed: () {
                  print('Selected option: $selectedOption');
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
