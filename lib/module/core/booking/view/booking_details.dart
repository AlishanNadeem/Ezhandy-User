import 'dart:developer';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/row/two_text_row.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class BookingDetails extends StatefulWidget {
  String status;
  BookingDetails({required this.status, super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  int? currentHourIndex;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        // appBarheight: 50.h,
        title: AppStrings.booking,
        actionWidget: (widget.status == AppStrings.inRoute ||
                widget.status == AppStrings.started ||
                widget.status == AppStrings.completedUnPaid)
            ? Padding(
                padding: const EdgeInsets.only(right: AppPadding.padding12),
                child: GestureDetector(
                    onTap: () {
                      AppNavigation.navigateTo(
                          context, AppRoutes.chatScreenRoute,
                          arguments: ChatRoutingArgument(isBooking: false));
                    },
                    child: (Image.asset(
                      AssetPath.messageIcon,
                      width: 30.w,
                      height: 30.h,
                    ))))
            : null,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding12),
                child: Column(
                  children: [
                    15.verticalSpace,
                    CustomContainer(
                        isPadding: false,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.all(AppPadding.padding12),
                              child: CustomText(
                                  text: AppStrings.serviceName,
                                  // color: AppColors.blueDark,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Divider(color: AppColors.blueDark),
                            serviceDetailsWidget(),
                            // reScheduleWidget(),
                          ],
                        )),
                    10.verticalSpace,
                    CustomContainer(
                        isPadding: false,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.all(AppPadding.padding12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: AppStrings.bookingDetails,
                                      // color: AppColors.blueDark,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                  CustomText(
                                      text:
                                          "${AppStrings.status}: ${widget.status}",
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                            Divider(color: AppColors.blueDark),
                            bookingDetailsWidget(),
                            // reScheduleWidget(),
                          ],
                        )),
                    rejectReasonWidget(),
                    15.verticalSpace,
                    if (widget.status == AppStrings.accepted ||
                        widget.status == AppStrings.inRoute ||
                        widget.status == AppStrings.started ||
                        widget.status == AppStrings.completedPaid ||
                        widget.status == AppStrings.completedUnPaid) ...[
                      CustomContainer(
                          isPadding: false,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(AppPadding.padding12),
                                child: CustomText(
                                    text: AppStrings.providerDetails,
                                    // color: AppColors.blueDark,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(color: AppColors.blueDark),
                              providerDetailsWidget(),
                              // reScheduleWidget(),
                            ],
                          )),
                      15.verticalSpace,
                      if (widget.status == AppStrings.started ||
                          widget.status == AppStrings.completedPaid ||
                          widget.status == AppStrings.completedUnPaid) ...[
                        CustomContainer(
                            isPadding: false,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(
                                      AppPadding.padding12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                          text: AppStrings.workDocuments,
                                          // color: AppColors.blueDark,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                      widget.status == AppStrings.started
                                          ? SizedBox.shrink()
                                          : CustomText(
                                              text: AppStrings.invoice,
                                              // color: AppColors.blueDark,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                ),
                                Divider(color: AppColors.blueDark),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      10.horizontalSpace,
                                      GestureDetector(
                                        onTap: () {
                                          AppNavigation.navigateTo(
                                              context,
                                              AppRoutes
                                                  .workDocumentsScreenRoute);
                                        },
                                        child: Image.asset(
                                            AssetPath.documentTotalIcon,
                                            width: 50.w,
                                            height: 50.h),
                                      ),
                                      Spacer(),
                                      widget.status == AppStrings.started
                                          ? SizedBox.shrink()
                                          : GestureDetector(
                                              onTap: () {
                                                AppNavigation.navigateTo(
                                                    context,
                                                    AppRoutes
                                                        .invoiceScreenRoute);
                                              },
                                              child: Image.asset(
                                                  AssetPath.documentTotalIcon,
                                                  width: 50.w,
                                                  height: 50.h),
                                            ),
                                      10.horizontalSpace,
                                    ],
                                  ),
                                ),
                                // reScheduleWidget(),
                              ],
                            )),
                        15.verticalSpace,
                      ],
                      reportReviewButtonWidget(),
                      endWorkButtonWidget(),
                      refundButtonWidget(),
                    ],
                    widget.status == AppStrings.inRoute
                        ? CustomContainer(
                            height: 200.h,
                            width: 1.sw,
                            isPadding: false,
                            child: SizedBox())
                        : SizedBox.shrink(),
                    25.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget rejectReasonWidget() {
    return Visibility(
      visible: widget.status == AppStrings.rejected ||
          widget.status == AppStrings.cancelled,
      child: Column(
        children: [
          10.verticalSpace,
          CustomText(
              text: AppStrings.reason,
              // color: AppColors.blueDark,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
          10.verticalSpace,
          CustomText(
            text: AppStrings.lorem5,
            color: AppColors.grey,
          ),
        ],
      ),
    );
  }

  Padding serviceDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
      child: Column(
        children: [
          5.verticalSpace,
          TwoTextRow(
              firstText: "${AppStrings.service}:", secondText: "Type Name"),
          TwoTextRow(
              firstText: "${AppStrings.visitCharges}:", secondText: "\$10"),
          TwoTextRow(
              firstText: "${AppStrings.hourlyRate}:", secondText: "\$10"),
          10.verticalSpace,
        ],
      ),
    );
  }

  Padding bookingDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
      child: Column(
        children: [
          5.verticalSpace,
          TwoTextRow(
              firstText: "${AppStrings.bookingId}:",
              secondText: "#${AppStrings.dummyOrderNumber}"),
          TwoTextRow(
              firstText: "${AppStrings.bookingDate}:",
              secondText: AppStrings.dummyDate),
          TwoTextRow(
              firstText: "${AppStrings.userName}:",
              secondText: AppStrings.dummyName),
          TwoTextRow(
              firstText: "${AppStrings.phoneNumber}:",
              secondText: AppStrings.dummyPhoneNUmber),
          TwoTextRow(
              firstText: "${AppStrings.emailAddress}:",
              secondText: AppStrings.dummyEmail),
          TwoTextRow(
              firstText: "${AppStrings.address}:",
              secondText: AppStrings.lorem1),
          TwoTextRow(
              firstText: "${AppStrings.serviceDate}:",
              secondText: AppStrings.dummyDate),
          TwoTextRow(
              firstText: "${AppStrings.serviceTime}:",
              secondText: AppStrings.dummytime),
          10.verticalSpace,
        ],
      ),
    );
  }

  Padding providerDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
      child: Column(
        children: [
          5.verticalSpace,
          TwoTextRow(
              firstText: "${AppStrings.userName}:",
              secondText: AppStrings.dummyName),
          TwoTextRow(
              firstText: "${AppStrings.phoneNumber}:",
              secondText: AppStrings.dummyPhoneNUmber),
          widget.status == AppStrings.started ||
                  widget.status == AppStrings.completedPaid ||
                  widget.status == AppStrings.completedUnPaid
              ? TwoTextRow(
                  firstText: "${AppStrings.starttime}:",
                  secondText: AppStrings.dummytime)
              : SizedBox.shrink(),
          10.verticalSpace,
        ],
      ),
    );
  }

  Widget reScheduleWidget() {
    return Visibility(
      // visible: widget.status == BookingType.Reschedule.name,
      child: Column(
        children: [
          Divider(color: AppColors.blueDark),
          Padding(
            padding: const EdgeInsets.all(AppPadding.padding12),
            child: CustomText(
                text: AppStrings.reScheduleTimeAndDate,
                color: AppColors.blueDark,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          Divider(
            color: AppColors.blueDark,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(
              children: [
                5.verticalSpace,
                TwoTextRow(
                    firstText: "${AppStrings.sessionDate}:",
                    secondText: AppStrings.dummyDate),
                TwoTextRow(
                    firstText: "${AppStrings.sessionTime}:",
                    secondText:
                        "${AppStrings.dummytime} - ${AppStrings.dummytime}"),
                10.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reportReviewButtonWidget() {
    return Visibility(
        visible: (widget.status == AppStrings.completedPaid),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                  color: AppColors.black,
                  text:
                      // (
                      // widget.status == BookingType.Upcoming.name ||
                      //       widget.status == BookingType.InProcess.name)
                      //   ? AppStrings.joinSession
                      //   :
                      AppStrings.reportIssue,
                  onclick:
                      // (widget.status == BookingType.Upcoming.name ||
                      //         widget.status == BookingType.InProcess.name)
                      //     ? () {
                      //         AppNavigation.navigateTo(
                      //             context, AppRoutes.videoCallScreenRoute);
                      //       }
                      //     :
                      () {
                    AppNavigation.navigateTo(
                        context, AppRoutes.reportIssueScreenRoute);
                  }),
            ),
            10.horizontalSpace,
            Expanded(
              child: CustomButton(
                  text:
                      // (
                      // widget.status == BookingType.Upcoming.name ||
                      //       widget.status == BookingType.InProcess.name)
                      //   ? AppStrings.joinSession
                      //   :
                      AppStrings.review,
                  onclick:
                      // (widget.status == BookingType.Upcoming.name ||
                      //         widget.status == BookingType.InProcess.name)
                      //     ? () {
                      //         AppNavigation.navigateTo(
                      //             context, AppRoutes.videoCallScreenRoute);
                      //       }
                      //     :
                      () {
                    AppNavigation.navigateTo(
                        context, AppRoutes.writeReviewScreenRoute);
                  }),
            ),
          ],
        ));
  }

  Widget endWorkButtonWidget() {
    return Visibility(
        visible: (widget.status == AppStrings.completedUnPaid),
        child: CustomButton(
            text:
                // (
                // widget.status == BookingType.Upcoming.name ||
                //       widget.status == BookingType.InProcess.name)
                //   ? AppStrings.joinSession
                //   :
                AppStrings.payFurtherAmount,
            onclick:
                // (widget.status == BookingType.Upcoming.name ||
                //         widget.status == BookingType.InProcess.name)
                //     ? () {
                //         AppNavigation.navigateTo(
                //             context, AppRoutes.videoCallScreenRoute);
                //       }
                //     :
                () {
              AppDialogs.showSuccessDialog(context,
                  description: AppStrings.refundPolicyWork,
                  // title: AppStrings.deleteAccount,
                  image: AssetPath.tumbIcon,
                  isDoneShow: false,
                  btnTxt1: AppStrings.refund,
                  onTap1: () {
                    AppNavigation.navigatorPop(context);
                    AppDialogs.showSuccessDialog(
                      context,
                      description: AppStrings.oneOfOurRepresentative,
                      title: AppStrings.refundRequestSubmitted,
                      btnTxt1: AppStrings.goToHome,
                      onTap1: () {
                        AppNavigation.navigatorPopUntil(
                            context, AppRoutes.mainMenuScreenRoute);
                      },
                    );
                  },
                  btnTxt2: AppStrings.cancel,
                  onTap2: () {
                    AppNavigation.navigatorPop(context);
                  });
            }));
  }

  Widget refundButtonWidget() {
    return Visibility(
        visible: (widget.status == AppStrings.accepted),
        child: CustomButton(
            text:
                // (
                // widget.status == BookingType.Upcoming.name ||
                //       widget.status == BookingType.InProcess.name)
                //   ? AppStrings.joinSession
                //   :
                AppStrings.refund,
            onclick:
                // (widget.status == BookingType.Upcoming.name ||
                //         widget.status == BookingType.InProcess.name)
                //     ? () {
                //         AppNavigation.navigateTo(
                //             context, AppRoutes.videoCallScreenRoute);
                //       }
                //     :
                () {
              AppDialogs.showSuccessDialog(context,
                  description: AppStrings.refundPolicyWork,
                  // title: AppStrings.deleteAccount,
                  image: AssetPath.tumbIcon,
                  isDoneShow: false,
                  btnTxt1: AppStrings.refund,
                  onTap1: () {
                    AppNavigation.navigatorPop(context);
                    AppDialogs.showSuccessDialog(
                      context,
                      description: AppStrings.oneOfOurRepresentative,
                      title: AppStrings.refundRequestSubmitted,
                      btnTxt1: AppStrings.goToHome,
                      onTap1: () {
                        AppNavigation.navigatorPopUntil(
                            context, AppRoutes.mainMenuScreenRoute);
                      },
                    );
                  },
                  btnTxt2: AppStrings.cancel,
                  onTap2: () {
                    AppNavigation.navigatorPop(context);
                  });
            }));
  }

  Widget buttonWidget(BuildContext context) {
    log(widget.status.toString());
    log(widget.status.toString());

    return Visibility(
      // visible: (
      // widget.status == BookingType.Upcoming.name ||
      //   widget.status == BookingType.InProcess.name ||
      // widget.status == BookingType.Past.name
      // ),
      child: CustomButton(
        text:
            // (
            // widget.status == BookingType.Upcoming.name ||
            //       widget.status == BookingType.InProcess.name)
            //   ? AppStrings.joinSession
            //   :
            AppStrings.rateService,
        onclick:
            // (widget.status == BookingType.Upcoming.name ||
            //         widget.status == BookingType.InProcess.name)
            //     ? () {
            //         AppNavigation.navigateTo(
            //             context, AppRoutes.videoCallScreenRoute);
            //       }
            //     :
            () {
          AppNavigation.navigateTo(context, AppRoutes.writeReviewScreenRoute);
        },
      ),
    );
  }
}
