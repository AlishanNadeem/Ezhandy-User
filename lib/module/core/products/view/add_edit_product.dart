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

class AddEditProduct extends StatefulWidget {
  String type;
  AddEditProduct({required this.type, super.key});

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
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
  List documentList = [];
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
  void initState() {
    if (AddEditType.edit.name == widget.type) {
      setController();
    }
    // TODO: implement initState
    super.initState();
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
    setState(() {
      // _profileImage = file;
      documentList.add(file);
    });
    print(documentList.toString());
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
    return Container(
      height: 117.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return index == documentList.length
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: uploadWidget(documentList.length),
                )
              : _imageCard(
                  image: documentList[index].path,
                  onRemoveTapped: () {
                    setState(() {
                      documentList.removeAt(index);
                    });
                  },
                );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 5,
          );
        },
        itemCount: documentList.length + 1,
      ),
    );
  }

  Widget _imageCard({required String image, Function()? onRemoveTapped}) {
    print(image);
    print(image.split('.').last.toString() + " Pdf Print");
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Utils.onTapViewImage(
              context: context,
              image: image,
              //mediaType: MediaPathType.network.name,
              mediaType: MediaPathType.file.name,
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
                    image: FileImage(File(image)), fit: BoxFit.cover)),
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
    return CustomDropDown2(
      // width: 95.w, // 👈 Controls button width
      dropDownWidth: .93.sw, // 👈 Controls dropdown menu width
      dropDownData: categoryList,
      dropDownHeight: 500.h,
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
    return CustomButton(
        text: AddEditType.add.name == widget.type
            ? AppStrings.add
            : AppStrings.update,
        onclick: () {
          final isValid = formKey.currentState!.validate();
          if (!isValid) {
            return;
          }
          formKey.currentState!.save();
          AppNavigation.navigatorPop(context);
          AppDialogs.showSuccessDialog(
            context,
            description: AddEditType.add.name == widget.type
                ? AppStrings.productHasBeenAddedSuccessfully
                : AppStrings.productHasBeenUpdatedSuccessfully,
            title: AppStrings.congratulation,
            btnTxt1: AppStrings.ok,
            onTap1: () {
              AppNavigation.navigatorPop(
                  Constants.navigatorKey.currentContext!);
            },
          );
          // AppNavigation.navigateTo(
          //     context, AppRoutes.otpVerificationScreenRoute,
          //     arguments: OtpVerificationRoutingArgument(
          //         type: OtpType.forget.name,
          //         emailAndPhone: emailController.text,
          //         text: emailController.text));
          // AuthController.i
          //     .forgotPass(email: forgotPassRepo.email_controller.text);
          // ToastMessage(toastmsg: AppStrings.otpSendedToYourEmail);
          FocusScope.of(context).unfocus();
        });
  }

  void setController() {
    categoryValue=    "Angle grinders";
    productNameController.text = "Mope Pro";
    nameController.text = "John Doe";
    phoneController.text =
        Constants.maskTextInputFormatterPhoneUSWithCode.maskText('1234567890');

    addressController.text = "123 Main Street, New York, USA";
    emailController.text = "john.doe@gmail.com";
    priceController.text = "1499";
    descriptionController.text = "Brand new Mope Pro with Pro chip.";
    messageController.text = "Please contact me for more details.";
  }
}
