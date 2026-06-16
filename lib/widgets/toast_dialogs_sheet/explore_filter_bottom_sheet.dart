import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_bottom_sheet.dart';

// ignore: must_be_immutable
class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? categoryValue;
  var categoryList = [
    "Adhesives",
    "Allen keys",
    "Angle grinders",
    "Chalk lines",
    "Chisels & hand planes",
    "Circular saws",
    "Circuit testers",
    "Crimping tools",
    "Drill bit sets & blade replacements",
    "Drills",
    "Drop cloths & painter’s tape",
    "Ear protection",
    "Electrical tape",
    "Extension ladders",
    "Faucet & basin wrenches",
    "Fish tape",
    "Hand saws",
    "Hard hats",
    "Hammers",
    "Heat guns",
    "Impact drivers",
    "Jigsaws",
    "Knee pads",
    "Levels",
    "Measuring & marking tools",
    "Nail guns & staplers",
    "Nail sets & hammers",
    "Paint brushes",
    "Paint sprayers",
    "Pipe cutters",
    "Pipe wrenches",
    "Pliers",
    "Power drills",
    "Putty knives & scrapers",
    "Reciprocating saws",
    "Rollers & roller trays",
    "Rotary tools",
    "Safety goggles",
    "Sanders",
    "Sandpaper & sanding blocks",
    "Saws",
    "Screws, nails, bolts, anchors",
    "Screwdrivers",
    "Step ladders",
    "Stud finders",
    "Tape measures & rulers",
    "Teflon tape & sealant tools",
    "Tool belts & pouches",
    "Toolboxes & storage cases",
    "Utility knives & blades",
    "Voltage testers & multimeters",
    "Wire cutters & strippers",
    "Work gloves",
    "Workbenches"
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomBottomSheet(
        isPadding: true,
        isTopPadding: true,
        // isGradient: true,
        // showBar: true,
        // showCross: true,
        title: AppStrings.searchFilter,
        // titleColor: AppColors.white,
        height: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.95.sh : 0.65.sh,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(thickness: 1.5),
            10.verticalSpace,
            CustomText(
              text: AppStrings.category,
              // color: AppColors.white,
              fontSize: 16.sp,
            ),
            10.verticalSpace,
            categoryDropDown(),
            10.verticalSpace,
            CustomText(
                text: AppStrings.priceRange,
                // color: AppColors.white,
                fontSize: 16.sp),
            10.verticalSpace,
            Row(
              children: [
                Expanded(child: minTextField()),
                20.horizontalSpace,
                Expanded(child: maxTextField())
              ],
            ),
            20.verticalSpace,
            .03.sh.verticalSpace,
            MediaQuery.of(context).viewInsets.bottom > 0
                ? SizedBox.shrink()
                : btnWidget(),
          ],
        ),
      ),
    );
  }

  Widget categoryDropDown() {
    return CustomDropDown2(
      dropDownHeight: 220.h,
      // width: 95.w, // 👈 Controls button width
      dropDownWidth: .93.sw, // 👈 Controls dropdown menu width
      dropDownData: categoryList,
      borderRadius: 10.r,
      hintText: AppStrings.selectCategory,
      dropdownValue: categoryValue,
      dropdownListColor: AppColors.white,
      borderColor: AppColors.greyBorder,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        setState(() {
          categoryValue = value.toString();
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.selectCategory;
        }
        return null;
      },
    );
  }

  Widget minTextField() {
    return CustomTextField(
      borderRadius: 8.r,
      // fillColor: AppColors.white,
      // fontColor: AppColors.black,
      // hintColor: AppColors.blueDark,
      // // prefixIconColor: AppColors.fontColor,
      // borderColor: AppColors.greyBorder,
      divider: false,
      label: false,
      // prefxicon: AssetPath.searchIcon,

      hint: AppStrings.min,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
      ],
      // controller: firstNameController,
    );
  }

  Widget maxTextField() {
    return CustomTextField(
      borderRadius: 8.r,
      // fillColor: AppColors.white,
      // fontColor: AppColors.black,
      // prefixIconColor: AppColors.fontColor,
      // borderColor: AppColors.greyBorder,
      divider: false,
      label: false,
      // prefxicon: AssetPath.searchIcon,

      hint: AppStrings.max,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
      ],
      // controller: firstNameController,
    );
  }

  Widget btnWidget() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            // /boxShadow: AppShadows.shadow2,
            onclick: () {
              // setState(() {
              //   requestSent = !requestSent;
              // });
              // validateGender(genderValue);
              // validateCountry(countryValue);
              // // validateCity(cityValue);
              // // validateState(stateValue);
              // if (FormKey.currentState!.validate()) {
              AppNavigation.navigatorPop(context);
              // HomeController.i.selectedTab.value = 1;
              // }
            },
            text: "Reset",
            color: AppColors.black,
          ),
        ),
     10.horizontalSpace,
        Expanded(
          child: CustomButton(
            // /boxShadow: AppShadows.shadow2,
            onclick: () {
              // setState(() {
              //   requestSent = !requestSent;
              // });
              // validateGender(genderValue);
              // validateCountry(countryValue);
              // // validateCity(cityValue);
              // // validateState(stateValue);
              // if (FormKey.currentState!.validate()) {
              AppNavigation.navigatorPop(context);
              // HomeController.i.selectedTab.value = 1;
              // }
            },
            text: AppStrings.apply,
          ),
        ),
     
      ],
    );
  }
}
