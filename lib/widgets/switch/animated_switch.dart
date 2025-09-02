// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';

class AnimatedSwitch extends StatefulWidget {
  final void Function(bool)? onCallBack;
  bool isSwitched;
  Color? offColor, onColor, switchButtonColor;
  AnimatedSwitch({this.onCallBack, this.onColor, this.offColor, this.switchButtonColor, required this.isSwitched, super.key});

  @override
  State<AnimatedSwitch> createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.isSwitched = !widget.isSwitched;
          });
          widget.onCallBack!(widget.isSwitched);
        },
        child: Container(
          width: 30.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: widget.isSwitched ? widget.onColor ?? AppColors.orange : widget.offColor ?? AppColors.white,
            border: Border.all(
              color:
                  // widget. isSwitched ?
                  // AppColors.red:
                  AppColors.orange,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Transparent background
              Positioned.fill(
                child: Container(
                  color: const Color.fromARGB(0, 255, 20, 20),
                ),
              ),
              // Thumb
              AnimatedAlign(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: widget.isSwitched ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 15.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: widget.isSwitched ? AppColors.white : widget.switchButtonColor ?? AppColors.orange,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          // isSwitched ?
                          AppColors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
