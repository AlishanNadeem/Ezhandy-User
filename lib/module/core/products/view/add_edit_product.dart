import 'dart:developer';
import 'dart:io';

import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/widgets/Container/add_more.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/utils/media_url_helper.dart';
import 'package:ezhandy_user/module/core/products/controller/market_place_controller.dart';
import 'package:ezhandy_user/module/core/products/controller/product_controller.dart';

class AddEditProduct extends StatefulWidget {
  final String type;
  final Map<String, dynamic>? product;

  AddEditProduct({required this.type, this.product, super.key});

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {

  late ProductController _productController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool keyboardVisible = false;
  List<File> documentList = [];
  String? existingImageUrl;
  String? editingProductId;
  String? categoryValue;

  @override
  void initState() {
    super.initState();
    _productController = Get.put(ProductController());

    if (AddEditType.edit.name == widget.type && widget.product != null) {
      _populateFromProduct(widget.product!);
    }

    ever<List<dynamic>>(_productController.categoryList, (_) {
      _syncCategorySelection();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncCategorySelection();
    });
  }

  void _syncCategorySelection() {
    if (_productController.categoryList.isEmpty || !mounted) return;

    final resolvedName = _resolveCategoryDropdownValue(
      _productController.categoryList
          .map((e) => e['name']?.toString() ?? '')
          .where((name) => name.isNotEmpty)
          .toList(),
    );

    if (resolvedName == null) return;

    String? resolvedId = _productController.selectedCategoryId;
    for (final category in _productController.categoryList) {
      if (category['name']?.toString() == resolvedName) {
        resolvedId = category['id']?.toString();
        break;
      }
    }

    if (categoryValue == resolvedName &&
        _productController.selectedCategoryId == resolvedId) {
      return;
    }

    setState(() {
      categoryValue = resolvedName;
      _productController.selectedCategoryId = resolvedId;
    });
  }

  String? _resolveCategoryDropdownValue(List<String> categoryNames) {
    if (categoryNames.isEmpty) return null;

    if (categoryValue != null &&
        categoryNames.contains(categoryValue)) {
      return categoryValue;
    }

    final selectedId = _productController.selectedCategoryId;
    if (selectedId != null && selectedId.isNotEmpty) {
      for (final category in _productController.categoryList) {
        if (category['id']?.toString() == selectedId) {
          final name = category['name']?.toString();
          if (name != null && categoryNames.contains(name)) {
            return name;
          }
        }
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    log(keyboardVisible.toString());
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        // appBarheight: 50.h,
        title: AddEditType.add.name == widget.type
            ? AppStrings.addProduct
            : AppStrings.editProduct,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      //----------------Email Address Field----------------
                      20.verticalSpace,
                      CustomText(text: "Product Name" + "*"),
                      10.verticalSpace,
                      _productNameTextField(),
                      20.verticalSpace,

                      CustomText(text: AppStrings.category + "*"),
                      10.verticalSpace,
                      categoryDropDown(),
                      20.verticalSpace,
                      CustomText(text: AppStrings.price + "*"),
                      10.verticalSpace,
                      _priceTextField(),
                      20.verticalSpace,
                      CustomText(text: AppStrings.description + "*"),
                      10.verticalSpace,
                      _descriptionField(),
                      20.verticalSpace,
                      CustomText(text: AppStrings.uploadImage + "*"),
                      10.verticalSpace,
                      documentWidget(),
                      20.verticalSpace,
                      CustomText(
                          text: "Seller Info:",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                      10.verticalSpace,
                      CustomText(text: "Seller Name" + "*"),
                      10.verticalSpace,
                      _nameTextField(),
                      20.verticalSpace,
                      CustomText(text: AppStrings.phoneNumber + "*"),
                      10.verticalSpace,
                      _phoneNumberTextField(),
                      20.verticalSpace,
                      CustomText(text: AppStrings.email + "*"),
                      10.verticalSpace,
                      _emailTextField(),
                      20.verticalSpace,
                      CustomText(text: AppStrings.address + "*"),
                      10.verticalSpace,
                      _addressField(),
                      20.verticalSpace,

                      //----------------Get Code Button----------------
                    ]),
                  ),
                ),
              ),
              Visibility(
                  visible: !keyboardVisible, child: buttonWidget(context)),
              Visibility(visible: !keyboardVisible, child: 25.verticalSpace)
            ],
          ),
        ));
  }

  _setCameraDocumentFile(File? file) {
    if (file == null) return;
    setState(() {
      documentList.add(file);
    });
  }

  void _populateFromProduct(Map<String, dynamic> product) {
    editingProductId = product['id']?.toString();
    productNameController.text = product['title']?.toString() ?? '';
    descriptionController.text = product['description']?.toString() ?? '';
    priceController.text = product['price']?.toString() ?? '';

    final category = product['category'];
    if (category is Map) {
      categoryValue = category['name']?.toString();
      _productController.selectedCategoryId = category['id']?.toString();
    } else if (category is String && category.trim().isNotEmpty) {
      categoryValue = category.trim();
    } else if (product['categoryId'] != null) {
      _productController.selectedCategoryId = product['categoryId']?.toString();
    } else if (product['categoryName'] != null) {
      categoryValue = product['categoryName']?.toString();
    }

    final owner = product['owner'];
    if (owner is Map) {
      nameController.text = owner['fullName']?.toString() ?? '';
      emailController.text = owner['email']?.toString() ?? '';

      final phone = owner['phone']?.toString() ?? '';
      if (phone.isNotEmpty) {
        final digits = phone.replaceAll(RegExp(r'\D'), '');
        phoneController.text = digits.isNotEmpty
            ? Constants.maskTextInputFormatterPhoneUSWithCode.maskText(digits)
            : phone;
      }

      addressController.text = owner['address']?.toString() ?? '';
    }

    if (addressController.text.isEmpty) {
      addressController.text = product['address']?.toString() ?? '';
    }

    final imagePath = product['mainImagePath']?.toString();
    if (imagePath != null && imagePath.isNotEmpty) {
      existingImageUrl = resolveMediaUrl(imagePath);
    }
  }

  Widget _emailTextField() {
    return CustomTextField(
      hint: AppStrings.enterEmailAddress,
      divider: false,
      label: false,

      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.emailMaxLength)
      ],
      controller: emailController,
      validator: (value) => value?.validateEmail,
      // error_text: error_email,
    );
  }

  Widget uploadWidget(length) {
    return AddMore(
      text: length == 0 ? AppStrings.add : AppStrings.addMore,
      // image: AssetPath.plusCircleIcon,
      // size: size,
      height: 60.h, width: 105.w,
      ontap: () {
        AppDialogs.showImageSourceDialog(context,
            setFile: _setCameraDocumentFile);
      },
    );
    //  DottedBorder(
    //   borderType: BorderType.RRect,
    //   padding: EdgeInsets.all(15.sp),
    //   color: AppColors.borderColor,
    //   radius: Radius.circular(15.sp),
    //   strokeWidth: 1,
    //   child: Container(
    //     height: size?.h,
    //     width: size?.w,
    //     child: Column(
    //       children: [
    //         Image.asset(
    //           AssetPath.galleryIcon,
    //           scale: 3.sp,
    //           color: AppColors.borderColor,
    //         ),
    //         CustomText(
    //           is_alignLeft: false,
    //           text: AppStrings.addMore,
    //           color: AppColors.borderColor,
    //           fontsize: 10.sp,
    //         )
    //       ],
    //     ),
    //   ),
    // ),

    // );
  }

  Widget documentWidget() {
    final imageCount =
        documentList.length + (existingImageUrl != null ? 1 : 0);

    return SizedBox(
      height: 117.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == imageCount) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: uploadWidget(imageCount),
            );
          }

          if (existingImageUrl != null && index == 0) {
            return _imageCard(
              image: existingImageUrl!,
              isNetwork: true,
              onRemoveTapped: () {
                setState(() {
                  existingImageUrl = null;
                });
              },
            );
          }

          final fileIndex = existingImageUrl != null ? index - 1 : index;
          return _imageCard(
            image: documentList[fileIndex].path,
            onRemoveTapped: () {
              setState(() {
                documentList.removeAt(fileIndex);
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 5);
        },
        itemCount: imageCount + 1,
      ),
    );
  }

  Widget _imageCard({
    required String image,
    bool isNetwork = false,
    Function()? onRemoveTapped,
  }) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Utils.onTapViewImage(
              context: context,
              image: image,
              mediaType: isNetwork
                  ? MediaPathType.network.name
                  : MediaPathType.file.name,
            );
          },
          child: Container(
            height: 110.h,
            width: 110.w,
            margin: EdgeInsets.only(top: 5, right: 5),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.orange),
                borderRadius: BorderRadius.circular(10.sp),
                image: DecorationImage(
                    image: isNetwork
                        ? NetworkImage(image)
                        : FileImage(File(image)),
                    fit: BoxFit.cover)),
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: onRemoveTapped,
              child: Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5.sp)
                    // shape: BoxShape.circle,
                    // border: Border.all(color: AppColors.white)
                    ),
                child: Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 15.sp,
                ),
              ),
            ))
      ],
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

    final dropdownValue = _resolveCategoryDropdownValue(categoryNames);

    return CustomDropDown2(
      dropDownWidth: .93.sw,
      dropDownData: categoryNames,
      dropDownHeight: 500.h,
      borderRadius: 10.r,
      hintText: AppStrings.selectCategory,
      dropdownValue: dropdownValue,
      dropdownListColor: AppColors.white,
      borderColor: AppColors.greyBorder,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        setState(() {
          categoryValue = value.toString();
          final selected = _productController.categoryList.firstWhere(
            (e) => e['name']?.toString() == value,
            orElse: () => null,
          );
          if (selected != null) {
            _productController.selectedCategoryId =
                selected['id']?.toString();
          }
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

  Widget _phoneNumberTextField() {
    return CustomTextField(
      hint: AppStrings.enterPhoneNumber,
      divider: false,
      // prefxicon: AssetPath.callIcon,
      label: false,
      keyboardType: TextInputType.number,
      inputFormatters: [Constants.maskTextInputFormatterPhoneUSWithCode],
      controller: phoneController,
      // validator: (value) => value?.validateEmpty(AppStrings.phon),
      // error_text: error_email,
    );
  }

  Widget _productNameTextField() {
    return CustomTextField(
      hint: "Enter Product Name",
      divider: false,
      // prefxicon: AssetPath.profileCircleIcon,
      label: false,
      // readOnly: true,
      // onTap: () {},
      // keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.nameMaxLength)
      ],
      controller: productNameController,
      validator: (value) => value?.validateEmpty("Product Name"),
      // error_text: error_email,
    );
  }

  Widget _nameTextField() {
    return CustomTextField(
      hint: "Enter Seller Name",
      divider: false,
      // prefxicon: AssetPath.profileCircleIcon,
      label: false,
      // readOnly: true,
      // onTap: () {},
      // keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.nameMaxLength)
      ],
      controller: nameController,
      validator: (value) => value?.validateEmpty("Seller Name"),
      // error_text: error_email,
    );
  }

  Widget _addressField() {
    return CustomTextField(
      hint: AppStrings.enterAddress,
      divider: false,
      // prefxicon: AssetPath.convertIcon,
      label: false,
      borderRadius: 10.r,
      lines: 5,
      // keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: addressController,
      validator: (value) => value?.validateEmpty(AppStrings.address),
      // error_text: error_email,
    );
  }

  Widget _descriptionField() {
    return CustomTextField(
      hint: AppStrings.enterDescription,
      divider: false,
      // prefxicon: AssetPath.convertIcon,
      label: false,
      borderRadius: 10.r,
      lines: 5,
      // keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: descriptionController,
      validator: (value) => value?.validateEmpty(AppStrings.description),
      // error_text: error_email,
    );
  }

  Widget _priceTextField() {
    return CustomTextField(
        hint: AppStrings.enterPrice,
        divider: false,
        label: false,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        sufixImage: Padding(
          padding: const EdgeInsets.only(
              top: AppPadding.padding12, right: AppPadding.padding12),
          child: Text(
            "\$",
            textAlign: TextAlign.right,
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
        ],
        controller: priceController,
        validator: (value) => value?.validateEmpty(AppStrings.price)
        // error_text: error_email,
        );
  }

Widget buttonWidget(context) {
  print("🔨 buttonWidget built"); // ← is widget even building?
  return Obx(() {
    print("🔄 Obx rebuilt, isLoading: ${_productController.isLoading.value}");
    return CustomButton(
      text: AddEditType.add.name == widget.type
          ? AppStrings.add
          : AppStrings.update,
      onclick: () {
        print("👆 Button tapped!"); // ← is button tapped?

        // if (_productController.isLoading.value) {
        //   print("⏳ Still loading...");
        //   return;
        // }

        final isValid = formKey.currentState!.validate();
        print("✅ Form valid: $isValid");
        if (!isValid) return;

        if (_productController.selectedCategoryId == null) {
          print("❌ No category selected");
          return;
        }

        formKey.currentState!.save();
        FocusScope.of(context).unfocus();

        final image =
            documentList.isNotEmpty ? documentList.first : null;

        if (AddEditType.edit.name == widget.type) {
          if (editingProductId == null || editingProductId!.isEmpty) {
            print("❌ No product id for update");
            return;
          }

          _productController.updateProduct(
            productId: editingProductId!,
            title: productNameController.text,
            description: descriptionController.text,
            price: priceController.text,
            image: image,
            onSuccess: _showProductUpdatedSuccessDialog,
          );
          return;
        }

        _productController.createProduct(
          title: productNameController.text,
          description: descriptionController.text,
          price: priceController.text,
          image: image,
          onSuccess: _showProductAddedSuccessDialog,
        );
      },
    );
  });
}

  void _showProductAddedSuccessDialog() {
    if (!mounted) return;
    AppDialogs.showSuccessDialog(
      context,
      description: AppStrings.productHasBeenAddedSuccessfully,
      title: AppStrings.congratulation,
      isDoneShow: true,
      btnTxt1: AppStrings.ok,
      onTap1: () {
        AppNavigation.navigatorPop(context);
        _refreshMarketplaceAndPop();
      },
    );
  }

  void _showProductUpdatedSuccessDialog() {
    if (!mounted) return;
    AppDialogs.showSuccessDialog(
      context,
      description: AppStrings.productHasBeenUpdatedSuccessfully,
      title: AppStrings.congratulation,
      isDoneShow: true,
      btnTxt1: AppStrings.ok,
      onTap1: () {
        AppNavigation.navigatorPop(context);
        _refreshMarketplaceAndPop();
      },
    );
  }

  void _refreshMarketplaceAndPop() {
    if (Get.isRegistered<MarketPlaceController>()) {
      final c = Get.find<MarketPlaceController>();
      c.getMyProducts();
      c.getProducts();
    }
    AppNavigation.navigatorPop(context);
  }
}
