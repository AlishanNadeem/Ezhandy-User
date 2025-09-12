import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import '../../utils/app_color.dart';

// typedef OnCheckBoxStateChanged = Function(bool? value);

///Custom CheckBoxes Used in App

class CheckBoxWidget extends StatefulWidget {
  final bool isChecked;
  final String title;
  Color? checkColor;
  void Function()? ontapCheck;
  // final OnCheckBoxStateChanged onCheckBoxStateChanged;

  CheckBoxWidget({
    super.key,
    this.checkColor,
    required this.isChecked,
    required this.ontapCheck,
    required this.title,
    // required this.onCheckBoxStateChanged,
  });

  @override
  CheckBoxWidgetState createState() => CheckBoxWidgetState();
}

class CheckBoxWidgetState extends State<CheckBoxWidget> {
  // late bool _isChecked;

  @override
  void initState() {
    super.initState();
    widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.ontapCheck,
          child: Container(
            width: 25.0.w, // Set the width of the checkbox
            height: 25.0.h, // Set the height of the checkbox
            margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(5.0),
              shape: BoxShape.circle,

              color: widget.isChecked ? AppColors.orange : AppColors.transparent,
              // gradient: widget.isChecked ? AppGradients.buttonGradient : null,
              border: widget.isChecked
                  ? null
                  : Border.all(
                      color:  AppColors.orange,
                      // width: 2.0, // Border width
                    ),
            ),
            child: widget.isChecked
                ? const Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 20.0, // Size of the checkmark icon
                  )
                : null,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomText(
            text: widget.title,
            fontSize: 16.sp,

            // color:
            //     widget.checkColor == null ? AppColors.white : AppColors.black,
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}
