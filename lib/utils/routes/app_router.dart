import 'package:ezhandy_user/module/auth/content/routing_arguments/content_routing_arguments.dart';
import 'package:ezhandy_user/module/auth/content/view/content_screen.dart';
import 'package:ezhandy_user/module/auth/create_new_password/view/change_password.dart';
import 'package:ezhandy_user/module/auth/create_new_password/view/reset_password.dart';
import 'package:ezhandy_user/module/auth/login/views/login.dart';
import 'package:ezhandy_user/module/auth/signup/views/signup.dart';
import 'package:ezhandy_user/module/auth/splash/screen/splash_screen.dart';
import 'package:ezhandy_user/module/auth/splash/screen/splash_slider_screen.dart';
import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
import 'package:ezhandy_user/module/auth/verification/view/otp_verification_screen.dart';
import 'package:ezhandy_user/module/core/affiliate_earning/view/affiliate_earning.dart';
import 'package:ezhandy_user/module/core/booking/view/booking_details.dart';
import 'package:ezhandy_user/module/core/booking/view/booking_history.dart';
import 'package:ezhandy_user/module/core/booking/view/invoice_screen.dart';
import 'package:ezhandy_user/module/core/booking/view/work_document.dart';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/module/core/chat/view/chat.dart';
import 'package:ezhandy_user/module/core/contact_us/view/contact_us.dart';
import 'package:ezhandy_user/module/core/main_menu/main_menu_user.dart';
import 'package:ezhandy_user/module/core/notification/notification.dart';
import 'package:ezhandy_user/module/core/profile/view/edit_user_profile.dart';
import 'package:ezhandy_user/module/core/profile/view/user_profile.dart';
import 'package:ezhandy_user/module/core/rating_review_report/view/rating_screen.dart';
import 'package:ezhandy_user/module/core/rating_review_report/view/report_issue.dart';
import 'package:ezhandy_user/module/core/rating_review_report/view/write_review_screen.dart';
import 'package:ezhandy_user/module/core/transaction_history/transaction_history.dart';
import 'package:ezhandy_user/utils/routes/routing_arguments/booking_routing_arguments.dart';
import 'package:flutter/material.dart';
import 'package:ezhandy_user/module/auth/verification/view/verification_selection_screen.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/pdf/pdf_view.dart';
import 'package:ezhandy_user/widgets/view_image/arguments/view_full_image_arguments.dart';
import 'package:ezhandy_user/widgets/view_image/view/image_view.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case AppRoutes.splashScreenRoute:
            return const SplashScreen();
case AppRoutes.splash1ScreenRoute:
            return const SplashSliderScreen();
          case AppRoutes.loginScreenRoute:
            return LogIn();
          case AppRoutes.signupScreenRoute:
            return SignUp();
          // case AppRoutes.forgotPasswordScreenRoute:
          //   return ForgotPassword();
          case AppRoutes.otpVerificationScreenRoute:
            OtpVerificationRoutingArgument? otpArguments =
                routeSettings.arguments as OtpVerificationRoutingArgument?;
            return OTPVerification(
              emailAndPhone: otpArguments?.emailAndPhone,
              type: otpArguments?.type,
              text: otpArguments?.text,
            );
          case AppRoutes.verificationSelectionScreenRoute:
            OtpVerificationRoutingArgument? otpArguments =
                routeSettings.arguments as OtpVerificationRoutingArgument?;
            return VerificationSelection(
              type: otpArguments?.type,
            );
          // case AppRoutes.changePasswordScreenRoute:
          //   return ChangePassword();
          case AppRoutes.resetPasswordScreenRoute:
            return ResetPassword();
          case AppRoutes.mainMenuScreenRoute:
            // MainMenuRoutingArguments? mainMenuRoutingArguments = routeSettings.arguments as MainMenuRoutingArguments?;
            return MainMenu(
                // selectedTab: mainMenuRoutingArguments?.selectedTab ?? 0,
                );
          // case AppRoutes.subscriptionScreenRoute:
          //   // SubscriptionRoutingArgument? subscriptionArguments =
          //   // routeSettings.arguments as SubscriptionRoutingArgument?;
          //   return SubscriptionScreen(
          //       // isFromAuth: subscriptionArguments?.isFromAuth ?? false,
          //       );
          case AppRoutes.userProfileScreenRoute:
            return UserProfile();
          case AppRoutes.editProfileScreenRoute:
            return EditUserProfile();
          case AppRoutes.changePasswordScreenRoute:
            return ChangePassword();
          case AppRoutes.contentScreenRoute:
            ContentRoutingArgument? contentArgument =
                routeSettings.arguments as ContentRoutingArgument?;
            return ContentScreen(
              type: contentArgument?.type,
              title: contentArgument?.title,
            );
          case AppRoutes.contactUsScreenRoute:
            return ContactUs();
          case AppRoutes.transactionHistoryScreenRoute:
            return TransactionHistory();
          // case AppRoutes.subscriptionLogScreenRoute:
          //   return SubscriptionLog();
          // case AppRoutes.faqsScreenRoute:
          //   return FaqsScreen();
          // case AppRoutes.customerSupportScreenRoute:
          //   return CustomerSupport();
          // case AppRoutes.educationsScreenScreenRoute:
          //   return EducationsScreen();
          // case AppRoutes.videoDetailScreenRoute:
          //   return VideoDetail();
          // case AppRoutes.appointmentSchedulingScreenRoute:
          //   return AppointmentScheduling();
          case AppRoutes.ratingScreenRoute:
            return RatingScreen();
          // case AppRoutes.MyAppointmentScreenRoute:
          //   return MyAppointment();
          case AppRoutes.bookingScreenRoute:
            BookingRoutingArgument bookingArgument =
                routeSettings.arguments as BookingRoutingArgument;
            return BookingDetails(
              status: bookingArgument.Status,
            );
          // case AppRoutes.videoCallScreenRoute:
          //   return VideoCallScreen();
          case AppRoutes.workDocumentsScreenRoute:
            return WorkDocuments();
          case AppRoutes.invoiceScreenRoute:
            return InvoiceScreen();
          case AppRoutes.writeReviewScreenRoute:
            return WriteReviewScreen();
          case AppRoutes.reportIssueScreenRoute:
            return ReportIssue();
          case AppRoutes.favouritesScreenRoute:
            return ReportIssue();
             case AppRoutes.chatScreenRoute:
            ChatRoutingArgument chatArgument =
                routeSettings.arguments as ChatRoutingArgument;
            return ChatScreen(isBooking: chatArgument.isBooking??false,);
          // case AppRoutes.legalIntelligenceSupportScreenRoute:
          //   return LegalIntelligenceSupport();
          // case AppRoutes.corporateGrowthPackageScreenRoute:
          //   return CorporateGrowthPackage();
          // case AppRoutes.brandStrategySponsorshipScreenRoute:
          //   return BrandStrategySponsorship();
          // case AppRoutes.aiPoweredLegalAssistantScreenRoute:
          //   return AiPoweredLegalAssistantChat();
          // case AppRoutes.interactiveQAInterfaceScreenRoute:
          //   return InteractiveQAInterfaceChat();
          // case AppRoutes.aiDocumentFeedbackScreenRoute:
          //   return AiDocumentFeedbackChat();
          // case AppRoutes.einRegistrationFormScreenRoute:
          //   return EINRegistrationForm();
          // case AppRoutes.complianceManagementScreenRoute:
          //   return ComplianceManagement();
          // case AppRoutes.trademarkSupportScreenRoute:
          //   return TrademarkSupportForm();
          // case AppRoutes.influencerToolkitBrandResourcesScreenRoute:
          //   return InfluencerToolkitBrandResources();
          // case AppRoutes.brandingGuidesScreenRoute:
          //   return BrandingGuides();
          // case AppRoutes.pitchTemplateScreenRoute:
          //   return PitchTemplate();
          // case AppRoutes.successStoriesCaseStudyScreenRoute:
          //   return SuccessStoriesCaseStudy();
          // case AppRoutes.brandCollaborationScreenRoute:
          //   return BrandCollaboration();

          // case AppRoutes.campaogmDetailsScreenRoute:
          //   CampaignDetailRoutingArgument? campaignDetailArgument =
          //       routeSettings.arguments as CampaignDetailRoutingArgument?;
          //   return CampaignDetails(
          //     status: campaignDetailArgument?.status,
          //   );

          // case AppRoutes.applyCampaignScreenRoute:
          //   return ApplyCampaign();
          // case AppRoutes.cooLedComplianceDashboardScreenRoute:
          //   return CooLedComplianceDashboard();
          // case AppRoutes.chatWithAdminScreenRoute:
          //   return ChatWithAdmin();
          // case AppRoutes.allDocumentsScreenRoute:
          //   return AllDocuments();
          // case AppRoutes.notAvailableScreenRoute:
          //   return NotAvailable();

          // case AppRoutes.pdfViewScreenRoute:
          //   PdfViewRoutingArgument? pdfViewArgument =
          //       routeSettings.arguments as PdfViewRoutingArgument?;
          //   return PdfViewerScreen(
          //     file: pdfViewArgument?.file,
          //     url: pdfViewArgument?.url,
          //     title: pdfViewArgument?.title,
          //   );
          // case AppRoutes.viewDocumentScreenRoute:
          //   PdfViewRoutingArgument? pdfViewArgument =
          //       routeSettings.arguments as PdfViewRoutingArgument?;
          //   return ViewDocument(
          //     file: pdfViewArgument?.file,
          //     url: pdfViewArgument?.url,
          //   );
          // case AppRoutes.selectUserSellerScreenRoute:
          //   SelectUserRoutingArgument? selectUserArgument =
          //       routeSettings.arguments as SelectUserRoutingArgument?;
          //   return SelectUserSeller(
          //     userType: selectUserArgument?.userType ?? "",
          //   );
          // case AppRoutes.loginScreenRoute:
          //   return LogIn();
          // case AppRoutes.forgotPasswordScreenRoute:
          //   return ForgotPassword();
          // case AppRoutes.deleteAccountScreenRoute:
          //   return DeleteAccount();
          // case AppRoutes.contentAuthScreenRoute:
          //   ContentRoutingArgument? contentAuthRoutingArgument =
          //       routeSettings.arguments as ContentRoutingArgument?;
          //   return ContentAuthScreen(
          //     currentIndex: contentAuthRoutingArgument?.currentIndex,
          //   );

          // case AppRoutes.signupScreenRoute:
          //   // LoginRoutingArgument? loginRoutingArgument =
          //   //     routeSettings.arguments as LoginRoutingArgument?;
          //   return SignUp(
          //       // type: loginRoutingArgument?.type ?? "",
          //       );

          // case AppRoutes.resetPasswordScreenRoute:
          //   return CreateNewPassword();
          // //profile
          // case AppRoutes.createCommittedProfileScreenRoute:
          //   CommittedProfileRoutingArgument? profileArguments =
          //       routeSettings.arguments as CommittedProfileRoutingArgument?;
          //   return CreateCommittedProfile(
          //     title: profileArguments?.title,
          //     type: profileArguments?.type,
          //     emailAndPhone: profileArguments?.emailAndPhone,
          //     initialCountry: profileArguments?.initialCountry,
          //   );
          // case AppRoutes.editCommittedProfileScreenRoute:
          //   CommittedProfileRoutingArgument? profileArguments =
          //       routeSettings.arguments as CommittedProfileRoutingArgument?;
          //   return EditCommittedProfile(
          //     title: profileArguments?.title,
          //     type: profileArguments?.type,
          //     emailAndPhone: profileArguments?.emailAndPhone,
          //     initialCountry: profileArguments?.initialCountry,
          //   );
          // case AppRoutes.createSingleProfileScreenRoute:
          //   SingleProfileRoutingArgument? profileArguments =
          //       routeSettings.arguments as SingleProfileRoutingArgument?;
          //   return CreateSingleProfile(
          //     title: profileArguments?.title,
          //     type: profileArguments?.type,
          //     emailAndPhone: profileArguments?.emailAndPhone,
          //     initialCountry: profileArguments?.initialCountry,
          //   );
          // case AppRoutes.editSingleProfileScreenRoute:
          //   SingleProfileRoutingArgument? profileArguments =
          //       routeSettings.arguments as SingleProfileRoutingArgument?;
          //   return EditSingleProfile(
          //     title: profileArguments?.title,
          //     type: profileArguments?.type,
          //     emailAndPhone: profileArguments?.emailAndPhone,
          //     initialCountry: profileArguments?.initialCountry,
          //   );
          // case AppRoutes.createDropShipperProfileScreenRoute:
          //   DropShipperProfileRoutingArgument? profileArguments =
          //       routeSettings.arguments as DropShipperProfileRoutingArgument?;
          //   return CreateDropShipperProfile(
          //     title: profileArguments?.title,
          //     type: profileArguments?.type,
          //     emailAndPhone: profileArguments?.emailAndPhone,
          //     initialCountry: profileArguments?.initialCountry,
          //   );
          // case AppRoutes.editDropShipperProfileScreenRoute:
          //   DropShipperProfileRoutingArgument? profileArguments =
          //       routeSettings.arguments as DropShipperProfileRoutingArgument?;
          //   return EditDropShipperProfile(
          //     title: profileArguments?.title,
          //     type: profileArguments?.type,
          //     emailAndPhone: profileArguments?.emailAndPhone,
          //     initialCountry: profileArguments?.initialCountry,
          //   );
          // case AppRoutes.createVendorProfileScreenRoute:
          //   VendorProfileRoutingArgument? profileArguments =
          //       routeSettings.arguments as VendorProfileRoutingArgument?;
          //   return CreateVendorProfile(
          //     title: profileArguments?.title,
          //     type: profileArguments?.type,
          //     emailAndPhone: profileArguments?.emailAndPhone,
          //     initialCountry: profileArguments?.initialCountry,
          //   );
          // case AppRoutes.editVendorProfileScreenRoute:
          //   VendorProfileRoutingArgument? profileArguments =
          //       routeSettings.arguments as VendorProfileRoutingArgument?;
          //   return EditVendorProfile(
          //     title: profileArguments?.title,
          //     type: profileArguments?.type,
          //     emailAndPhone: profileArguments?.emailAndPhone,
          //     initialCountry: profileArguments?.initialCountry,
          //   );

          // case AppRoutes.selectInterestsScreenRoute:
          //   InterestRoutingArgument? interestArguments =
          //       routeSettings.arguments as InterestRoutingArgument?;

          //   return SelectInterests(isEdit: interestArguments?.isEdit);
          // case AppRoutes.uploadPhotoScreenRoute:
          //   UploadPhotoRoutingArgument? uploadPhotoArguments =
          //       routeSettings.arguments as UploadPhotoRoutingArgument?;
          //   return UploadPhoto(isEdit: uploadPhotoArguments?.isEdit);
          // case AppRoutes.locationScreenRoute:
          //   return LocationScreen();
          // case AppRoutes.verificationScreenRoute:
          //   return VerificationScreen();
          // case AppRoutes.userMainMenuScreenRoute:
          //   // MainMenuRoutingArguments? mainMenuRoutingArguments = routeSettings.arguments as MainMenuRoutingArguments?;
          //   return MainMenuUser(
          //       // selectedTab: mainMenuRoutingArguments?.selectedTab ?? 0,
          //       );
          // case AppRoutes.sellerMainMenuScreenRoute:
          //   // MainMenuRoutingArguments? mainMenuRoutingArguments = routeSettings.arguments as MainMenuRoutingArguments?;
          //   return MainMenuSeller(
          //       // selectedTab: mainMenuRoutingArguments?.selectedTab ?? 0,
          //       );

          // case AppRoutes.settingsScreenRoute:
          //   return SettingScreen();
          // case AppRoutes.verificationStep1ScreenRoute:
          //   return VerificationStep1();
          // case AppRoutes.verificationStep2ScreenRoute:
          //   VerificationStepRoutingArguments? verificationStepRoutingArguments =
          //       routeSettings.arguments as VerificationStepRoutingArguments?;
          //   return VerificationStep2(
          //     phoneNumber: verificationStepRoutingArguments?.description ?? "",
          //     dialCode: verificationStepRoutingArguments?.dialCode ?? "",
          //     initialCountry:
          //         verificationStepRoutingArguments?.initialCountry ?? "",
          //   );
          // case AppRoutes.verificationStep3ScreenRoute:
          //   VerificationStepRoutingArguments? verificationStepRoutingArguments =
          //       routeSettings.arguments as VerificationStepRoutingArguments?;
          //   return VerificationStep3(
          //     dialCode: verificationStepRoutingArguments?.dialCode ?? "",
          //     initialCountry:
          //         verificationStepRoutingArguments?.initialCountry ?? "",
          //     description: verificationStepRoutingArguments?.description ?? "",
          //   );
          // case AppRoutes.verificationStep4ScreenRoute:
          //   return VerificationStep4();
          // case AppRoutes.otherUserProfileScreenRoute:
          //   OtherUserProfileRoutingArguments? otherUserProfileRoutingArguments =
          //       routeSettings.arguments as OtherUserProfileRoutingArguments?;
          //   return OtherUserProfile(
          //       isPartner:
          //           otherUserProfileRoutingArguments?.isPartner ?? false);
          // case AppRoutes.eventDetailsScreenRoute:
          //   EventDetailRoutingArgument? eventDetailArguments =
          //       routeSettings.arguments as EventDetailRoutingArgument?;
          //   return EventDetails(
          //     isInvitePartner: eventDetailArguments?.isInvitePartner ?? false,
          //     isPayment: eventDetailArguments?.isPayment ?? false,
          //   );
          // case AppRoutes.inviteFriendsScreenRoute:
          //   InvitePartnerRoutingArgument? invitePartnerArguments =
          //       routeSettings.arguments as InvitePartnerRoutingArgument?;
          //   return InviteFriends(
          //     isInvitePartner: invitePartnerArguments?.isInvitePartner ?? true,
          //     isAddPartner: invitePartnerArguments?.isInvitePartner ?? false,
          //   );
          // case AppRoutes.createEventScreenRoute:
          //   return CreateEvent();
          // case AppRoutes.commonSuccessScreenRoute:
          //   CommonSuccessScreenRoutingArgument? commonSuccessScreenArguments =
          //       routeSettings.arguments as CommonSuccessScreenRoutingArgument?;
          //   return CommonSuccessScreen(
          //     buttonText: commonSuccessScreenArguments?.buttonText ?? "",
          //     mainText: commonSuccessScreenArguments?.mainText ?? "",
          //     onclick: commonSuccessScreenArguments?.onclick,
          //     isBack: commonSuccessScreenArguments?.isBack??false,
          //   );
          // case AppRoutes.userProfileScreenRoute:
          //   return UserProfile();
          // case AppRoutes.myBookingUserScreenRoute:
          //   return MyBookingUserScreen();
          // case AppRoutes.bookingDetailsScreenRoute:
          //   BookingDetailsRoutingArgument? bookingDetailsArguments =
          //       routeSettings.arguments as BookingDetailsRoutingArgument?;
          //   return BookingDetailsScreen(
          //     status: bookingDetailsArguments?.status,
          //   );
          // case AppRoutes.myOrdersUserScreenRoute:
          //   return MyOrderUserScreen();

          // case AppRoutes.orderDetailsUserScreenRoute:
          //   OrderDetailsRoutingArgument? bookingDetailsArguments =
          //       routeSettings.arguments as OrderDetailsRoutingArgument?;
          //   return OrderDetailsUserScreen(
          //     status: bookingDetailsArguments?.status,
          //   );
          // case AppRoutes.myOrdersSellerScreenRoute:
          //   return MyOrderSellerScreen();
          // case AppRoutes.ordersHistorySellerScreenRoute:
          //   return OrderHistorySellerScreen();

          // case AppRoutes.orderDetailsSellerScreenRoute:
          //   OrderDetailsRoutingArgument? bookingDetailsArguments =
          //       routeSettings.arguments as OrderDetailsRoutingArgument?;
          //   return OrderDetailsSellerScreen(
          //     status: bookingDetailsArguments?.status,
          //   );

          // case AppRoutes.myEventsUserScreenRoute:
          //   return MyEventsUser();
          // case AppRoutes.eventsSellerScreenRoute:
          //   return EventsSeller();
          // case AppRoutes.bookingHistorySellerScreenRoute:
          //   return BookingHistorySellerScreen();
          // case AppRoutes.bookingRequestSellerScreenRoute:
          //   return BookingRequestSellerScreen();
          // case AppRoutes.itsAMatchSingleUserScreenRoute:
          //   return ItsAMatchSingleUser();
          // case AppRoutes.wouldYouRatherUserScreenRoute:
          //   return WouldYouRather();
          // case AppRoutes.loveHackUserScreenRoute:
          //   return LoveHackScreen();
          // case AppRoutes.productCartScreenRoute:

          //   return ProductCartScreen();
          // case AppRoutes.confirmPaymentScreenRoute:
          //   return ConfirmPaymentAddress();
          // case AppRoutes.productWithReceiverDetailsScreenRoute:
          //   return ProductWithReceiverDetails();
          // case AppRoutes.addReceiverAddressScreenRoute:
          //   return AddReceiverAddress();
          // case AppRoutes.cartScreenRoute:
          //   return CartScreen();
          // case AppRoutes.dropShipperUserProfileScreenRoute:
          //   DropShipperUserProfileRoutingArgument?
          //       dropShipperUserProfileArguments = routeSettings.arguments
          //           as DropShipperUserProfileRoutingArgument?;
          //   return DropShipperUserProfile(
          //     isVerified: dropShipperUserProfileArguments?.isVerified ?? true,
          //   );
          // case AppRoutes.exploreRecommendationScreenRoute:
          //   return ExploreRecommendation();
          // case AppRoutes.restaurantDetailProfileScreenRoute:
          //   return RestaurantDetailProfile();
          // case AppRoutes.bookReservationScreenRoute:
          //   return BookReservationScreen();
          // case AppRoutes.reservationSummaryScreenRoute:
          //   return ReservationSummaryScreen();
          // case AppRoutes.allRestaurantScreenRoute:
          //   return AllRestaurantScreen();
          // case AppRoutes.groupActivityScreenRoute:
          //   return GroupActivity();
          // case AppRoutes.createGroupScreenRoute:
          //   return CreateGroup();
          // case AppRoutes.groupChatScreenRoute:
          //   return GroupChatScreen();
          // case AppRoutes.chatWithDropShipperScreenRoute:
          //   return ChatWithDropShipper();
          // case AppRoutes.messageDropShipperScreenRoute:
          //   return MessageDropShipper();
          // case AppRoutes.productDetailScreenRoute:
          //   return ProductDetailsScreen();
          // case AppRoutes.addEditProductScreenRoute:
          //   AddEditProductRoutingArgument? productArguments =
          //       routeSettings.arguments as AddEditProductRoutingArgument?;
          //   return AddEditProduct(
          //     type: productArguments?.type,
          //     businessName: productArguments?.businessName,
          //     deliveryCharges: productArguments?.deliveryCharges,
          //     discountOffer: productArguments?.discountOffer,
          //     estimatedDeliverTime: productArguments?.estimatedDeliverTime,
          //     itemDetails: productArguments?.itemDetails,
          //     itemName: productArguments?.itemName,
          //   );
          case AppRoutes.notificationScreenRoute:
            return NotificationScreen();
          case AppRoutes.bookingHistoryScreenRoute:
            return BookingHistory();
          case AppRoutes.affiliateEarningScreenRoute:
            return AffiliateEarning();
          case AppRoutes.viewFullImageScreenRoute:
            ViewFullImageRoutingArgumentss? viewFullImageRoutingArguments =
                routeSettings.arguments as ViewFullImageRoutingArgumentss?;
            return FullScreenImageViewer(
              type: viewFullImageRoutingArguments?.mediaType ?? "asset",
              path: viewFullImageRoutingArguments?.image ?? "",
            );
          default:
            return Container();
        }
      },
    );
  }
}
