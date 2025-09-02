import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// ignore: must_be_immutable
class MultiSelectDropdown extends StatefulWidget {
  final String? hintText;
  final List<String>? dropDownData;
  final Color? color, dropdownListColor;
  final Color? fillColor;
  final String? Function(List<String>?)?
      validator; // ✅ validator for multiple values
  final double? width,
      borderRadius,
      fontSize,
      dropDownWidth,
      menuItemPadding,
      horizontalPadding,
      verticalPadding;
  final Color? borderColor, hintTextColor;
  final Offset? offset;

  const MultiSelectDropdown({
    Key? key,
    this.dropDownData,
    this.width,
    this.borderRadius,
    this.validator,
    this.fontSize = 15.5,
    this.fillColor,
    this.dropdownListColor,
    this.hintText,
    this.hintTextColor,
    this.verticalPadding,
    this.horizontalPadding,
    this.menuItemPadding,
    this.dropDownWidth,
    this.offset,
    this.borderColor,
    this.color,
  }) : super(key: key);

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> selectedValues = [];
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return FormField<List<String>>(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: selectedValues,
      builder: (FormFieldState<List<String>> state) {
        _errorText = state.errorText;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 35),
                border: Border.all(
                  color: state.hasError
                      ? AppColors.red // 🔴 red border if error
                      : (widget.borderColor ?? AppColors.greyBorder),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 35),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2<String>(
                    style: TextStyle(
                      color: widget.color ?? AppColors.black,
                      fontSize: widget.fontSize!.sp,
                    ),
                    hint: Text(
                      widget.hintText ?? "",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: widget.hintTextColor ?? AppColors.black,
                      ),
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16, right: 12),
                      border: InputBorder.none,
                    ),
                    items: widget.dropDownData!
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: CustomText(
                                text: value,
                                color: widget.color ?? AppColors.black,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null &&
                          !selectedValues.contains(newValue)) {
                        setState(() {
                          selectedValues.add(newValue);
                        });
                        state.didChange(selectedValues);
                      }
                    },
                    selectedItemBuilder: (context) {
                      return widget.dropDownData!
                          .map((_) => Text(
                                widget.hintText ?? "",
                                style: TextStyle(
                                  color:
                                      widget.hintTextColor ?? AppColors.black,
                                ),
                              ))
                          .toList();
                    },
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: widget.dropdownListColor ?? AppColors.white,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: widget.horizontalPadding ?? 5.w),
                      elevation: 1,
                      width: widget.dropDownWidth ?? 0.91.sw,
                      offset: widget.offset ?? const Offset(5, 0),
                      isOverButton: false,
                    ),
                  ),
                ),
              ),
            ),

            // ✅ Error Text
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  _errorText!,
                  style: const TextStyle(
                    color: AppColors.red,
                    fontSize: 12,
                  ),
                ),
              ),

            // ✅ Chips for selected values
            Wrap(
              spacing: 10.sp,
              children: selectedValues.map((value) {
                return Chip(
                  backgroundColor: AppColors.blueDark,
                  deleteIconColor: AppColors.white,
                  label: Text(
                    value,
                    style: const TextStyle(color: AppColors.white),
                  ),
                  onDeleted: () {
                    setState(() {
                      selectedValues.remove(value);
                      state.didChange(selectedValues);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
