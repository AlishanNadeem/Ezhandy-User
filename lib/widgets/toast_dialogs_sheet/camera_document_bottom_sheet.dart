// import 'dart:io';

// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/utils.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';

// class CameraDocumentBottomSheet extends StatefulWidget {
//   // void Function()? ontapPic, ontapRec;
//   final Function(File)? setFile;
//   CameraDocumentBottomSheet({super.key, this.setFile});

//   @override
//   State<CameraDocumentBottomSheet> createState() =>
//       _CameraDocumentBottomSheetState();
// }

// class _CameraDocumentBottomSheetState extends State<CameraDocumentBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomBottomSheet(
//       height: 0.29.sh,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Icon(
//               Icons.photo_camera,
//               color: AppColors.gradient_3,
//             ),
//             title: CustomText(
//               text: AppStrings.camera,
//               color: AppColors.gradient_3,
//               // textAlign: TextAlign.start,
//               fontWeight: FontWeight.w500,
//             ),
//             onTap:
//                 // widget.ontapPic

//                 //  isVideo ?    Utils.openVideoPicker(
//                 //   source: ImageSource.camera,
//                 //   context: context,

//                 //   setFile: setFile,
//                 // ):
//                 () => Utils.openImagePicker(
//               source: ImageSource.camera,
//               context: context,
//               setFile: widget.setFile,
//             ),
//           ),
//           Divider(color: AppColors.black),
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Icon(
//               Icons.photo_library,
//               color: AppColors.gradient_3,
//             ),
//             title: CustomText(
//               text: AppStrings.gallery,
//               color: AppColors.gradient_3,
//               // textAlign: TextAlign.start,
//               fontWeight: FontWeight.w500,
//             ),
//             onTap:
//                 // widget.ontapRec
//                 // isVideo ?   Utils.openVideoPicker(
//                 //   source: ImageSource.gallery,
//                 //   context: context,
//                 //   setFile: setFile,
//                 // )  :
//                 () => Utils.openImagePicker(
//               source: ImageSource.gallery,
//               context: context,
//               setFile: widget.setFile,
//             ),
//           ),
//           Divider(color: AppColors.black),
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Icon(
//               Icons.file_copy_sharp,
//               color: AppColors.gradient_3,
//             ),
//             title: CustomText(
//               text: AppStrings.file,
//               color: AppColors.gradient_3,
//               // textAlign: TextAlign.start,
//               fontWeight: FontWeight.w500,
//             ),
//             onTap:
//                 //  widget.ontapRec
//                 // isVideo ?   Utils.openVideoPicker(
//                 //   source: ImageSource.gallery,
//                 //   context: context,
//                 //   setFile: setFile,
//                 // )  :
//                 () => Utils.openFilePicker(
//               // source: ImageSource.gallery,
//               context: context,
//               setFile: widget.setFile,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
