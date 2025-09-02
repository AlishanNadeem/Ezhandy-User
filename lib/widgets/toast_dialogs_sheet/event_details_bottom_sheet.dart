// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_bottom_sheet.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_shadows.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_bottom_sheet.dart';

// class EventDetailsBottomSheet extends StatefulWidget {
//   // void Function()? ontapPic, ontapRec;
//   // final Function(File)? setFile;
//   EventDetailsBottomSheet({
//     super.key,
//   });

//   @override
//   State<EventDetailsBottomSheet> createState() =>
//       _EventDetailsBottomSheetState();
// }

// class _EventDetailsBottomSheetState extends State<EventDetailsBottomSheet> {
//   // FocusNode _focusNodeBio = FocusNode();
//   final GlobalKey<FormState> FormKey = GlobalKey<FormState>();

//   // double ratting = 3;
//   // bool _keyboardVisible = false;
//   // bool error = false;

//   @override
//   Widget build(BuildContext context) {
//     // _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

//     return CustomBottomSheet(
//         height:
//             //  _keyboardVisible ? 1.sh :
//             0.65.sh,
//         child: Expanded(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(),
//                   CustomText(
//                       text: AppStrings.eventDetails,
//                       is_alignLeft: false,
//                       fontSize: 16.sp),
//                   GestureDetector(
//                       onTap: () {
//                         AppNavigation.navigatorPop(context);
//                       },
//                       child: Image.asset(AssetPath.crossIcon, scale: 4.sp))
//                 ],
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       30.h.verticalSpace,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               titleWidget(title: AppStrings.title),
//                               CustomText(
//                                 text: "Lorem ipsum dolor",
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               AppBottomSheet.showAddEditEventSheet(
//                                   context: context,
//                                   type: AddEditType.edit.name);
//                             },
//                             child: CustomContainer(
//                                 radius: 50.sp,
//                                 boxShadow: AppShadows.shadow4,
//                                 child: Image.asset(
//                                   AssetPath.editIcon,
//                                   scale: 4.sp,
//                                 )),
//                           )
//                         ],
//                       ),
//                       divider(),
//                       10.h.verticalSpace,
//                       titleWidget(title: AppStrings.date),
//                       CustomText(
//                         text: "May 11, 2024",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       divider(),
//                       10.h.verticalSpace,
//                       titleWidget(title: AppStrings.startTime),
//                       CustomText(
//                         text: "03:30 pm",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       divider(),
//                       10.h.verticalSpace,
//                       titleWidget(title: AppStrings.endTime),
//                       CustomText(
//                         text: "04:30 pm",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       divider(),
//                       10.h.verticalSpace,
//                       titleWidget(title: AppStrings.location),
//                       CustomText(
//                         text: AppStrings.lorem3,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       divider(),
//                       10.h.verticalSpace,
//                       titleWidget(title: AppStrings.description),
//                       CustomText(
//                         text: AppStrings.lorem5,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       10.h.verticalSpace
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   CustomText titleWidget({String? title}) {
//     return CustomText(
//       text: title,
//       fontSize: 16.sp,
//     );
//   }

//   Divider divider() {
//     return Divider(
//       thickness: .5,
//       color: AppColors.borderColor,
//     );
//   }
// }
