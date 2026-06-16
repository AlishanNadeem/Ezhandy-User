import 'package:ezhandy_user/module/core/products/controller/market_place_controller.dart';
import 'package:ezhandy_user/module/core/products/controller/product_controller.dart';
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
import 'package:get/get.dart';
// ignore: must_be_immutable
class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late ProductController _productController;
  late MarketPlaceController _marketPlaceController;
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  String? categoryValue;
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _marketPlaceController = Get.find<MarketPlaceController>();
    if (Get.isRegistered<ProductController>()) {
      _productController = Get.find<ProductController>();
      if (_productController.categoryList.isEmpty) {
        _productController.getCategories();
      }
    } else {
      _productController = Get.put(ProductController());
    }

    categoryValue = _marketPlaceController.filterCategoryName.value.isEmpty
        ? null
        : _marketPlaceController.filterCategoryName.value;
    selectedCategoryId = _marketPlaceController.filterCategoryId.value.isEmpty
        ? null
        : _marketPlaceController.filterCategoryId.value;
    minPriceController.text = _marketPlaceController.filterMinPrice.value;
    maxPriceController.text = _marketPlaceController.filterMaxPrice.value;
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      categoryValue = null;
      selectedCategoryId = null;
      minPriceController.clear();
      maxPriceController.clear();
    });
    _marketPlaceController.clearFilters();
  }

  void _applyFilters() {
    _marketPlaceController.applyFilters(
      categoryId: selectedCategoryId,
      categoryName: categoryValue,
      minPrice: minPriceController.text,
      maxPrice: maxPriceController.text,
    );
    AppNavigation.navigatorPop(context);
  }

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
    return Obx(() {
      if (_productController.categoriesLoading.value) {
        return SizedBox(
          height: 50.h,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final categoryNames = _productController.categoryList
          .map((e) => e['name'].toString())
          .toList();

      return CustomDropDown2(
        dropDownHeight: 500.h,
        dropDownWidth: .93.sw,
        dropDownData: categoryNames,
        borderRadius: 10.r,
        hintText: AppStrings.selectCategory,
        dropdownValue: categoryValue,
        dropdownListColor: AppColors.white,
        borderColor: AppColors.greyBorder,
        hintTextColor: AppColors.black,
        onChanged: (value) {
          setState(() {
            categoryValue = value.toString();
            final selected = _productController.categoryList.firstWhere(
              (e) => e['name'] == value,
              orElse: () => null,
            );
            selectedCategoryId =
                selected != null ? selected['id']?.toString() : null;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.selectCategory;
          }
          return null;
        },
      );
    });
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
      controller: minPriceController,
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
      controller: maxPriceController,
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
            onclick: () {
              _resetFilters();
              AppNavigation.navigatorPop(context);
            },
            text: "Reset",
            color: AppColors.black,
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: CustomButton(
            onclick: _applyFilters,
            text: AppStrings.apply,
          ),
        ),
      ],
    );
  }
}
