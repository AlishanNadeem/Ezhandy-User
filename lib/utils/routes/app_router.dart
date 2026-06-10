import 'package:ezhandy_user/module/auth/content/routing_arguments/content_routing_arguments.dart';
import 'package:ezhandy_user/module/auth/content/view/content_screen.dart';
import 'package:ezhandy_user/module/auth/create_new_password/routing_arguments/reset_password_routing_arguments.dart';
import 'package:ezhandy_user/module/auth/create_new_password/view/change_password.dart';
import 'package:ezhandy_user/module/auth/create_new_password/view/reset_password.dart';
import 'package:ezhandy_user/module/auth/forgot_password/view/forgot_password_screen.dart';
import 'package:ezhandy_user/module/auth/login/views/login.dart';
import 'package:ezhandy_user/module/auth/signup/views/signup.dart';
import 'package:ezhandy_user/module/auth/splash/screen/splash_screen.dart';
import 'package:ezhandy_user/module/auth/splash/screen/splash_slider_screen.dart';
import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
import 'package:ezhandy_user/module/auth/verification/view/otp_verification_screen.dart';
import 'package:ezhandy_user/module/core/affiliate_earning/view/affiliate_earning.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/module/core/all_services/view/choose_payment_method.dart';
import 'package:ezhandy_user/module/core/all_services/view/favourites_services.dart';
import 'package:ezhandy_user/module/core/all_services/view/list_of_services.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/past_work_routing_arguments.dart';
import 'package:ezhandy_user/module/core/all_services/view/past_work.dart';
import 'package:ezhandy_user/module/core/all_services/view/pay_over_time.dart';
import 'package:ezhandy_user/module/core/all_services/view/schedule_booking.dart';
import 'package:ezhandy_user/module/core/all_services/view/select_a_payment_plan.dart';
import 'package:ezhandy_user/module/core/all_services/view/service_details.dart';
import 'package:ezhandy_user/module/core/all_services/view/service_selection.dart';
import 'package:ezhandy_user/module/core/all_services/view/signin_with_affirm.dart';
import 'package:ezhandy_user/module/core/all_services/view/single_service.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/widgets/web/checkout_webview_screen.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/booking_routing_arguments.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/invoice_routing_arguments.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/work_documents_routing_arguments.dart';
import 'package:ezhandy_user/module/core/booking/view/booking_details.dart';
import 'package:ezhandy_user/module/core/booking/view/booking_history.dart';
import 'package:ezhandy_user/module/core/booking/view/invoice_screen.dart';
import 'package:ezhandy_user/module/core/booking/view/work_document.dart';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/module/core/chat/view/chat.dart';
import 'package:ezhandy_user/module/core/chat/view/pro_chat.dart';
import 'package:ezhandy_user/module/core/community/routing_arguments/add_edit_post_routing_arguments.dart';
import 'package:ezhandy_user/module/core/community/routing_arguments/checkout_routing_arguments.dart';
import 'package:ezhandy_user/module/core/community/view/create_a_new_post.dart';
import 'package:ezhandy_user/module/core/community/view/create_a_pro_post.dart';
import 'package:ezhandy_user/module/core/community/view/my_posts.dart';
import 'package:ezhandy_user/module/core/contact_us/view/contact_us.dart';
import 'package:ezhandy_user/module/core/main_menu/main_menu_user.dart';
import 'package:ezhandy_user/module/core/notification/notification.dart';
import 'package:ezhandy_user/module/core/order/view/order_details.dart';
import 'package:ezhandy_user/module/core/order/view/orders.dart';
import 'package:ezhandy_user/module/core/products/routing_arguments/add_edit_product_routing_arguments.dart';
import 'package:ezhandy_user/module/core/products/view/add_edit_product.dart';
import 'package:ezhandy_user/module/core/products/view/add_to_cart.dart';
import 'package:ezhandy_user/module/core/products/view/market_place.dart';
import 'package:ezhandy_user/module/core/products/view/product_details.dart';
import 'package:ezhandy_user/module/core/profile/view/edit_user_profile.dart';
import 'package:ezhandy_user/module/core/profile/view/provider_profile.dart';
import 'package:ezhandy_user/module/core/profile/view/user_profile.dart';
import 'package:ezhandy_user/module/core/rating_review_report/routing_arguments/review_routing_arguments.dart';
import 'package:ezhandy_user/module/core/rating_review_report/view/rating_screen.dart';
import 'package:ezhandy_user/module/core/rating_review_report/routing_arguments/report_issue_routing_arguments.dart';
import 'package:ezhandy_user/module/core/rating_review_report/view/report_issue.dart';
import 'package:ezhandy_user/module/core/rating_review_report/view/write_review_screen.dart';
import 'package:ezhandy_user/module/core/transaction_history/transaction_history.dart';
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
          case AppRoutes.forgotPasswordScreenRoute:
            return ForgotPassword();
          case AppRoutes.otpVerificationScreenRoute:
            OtpVerificationRoutingArgument? otpArguments =
                routeSettings.arguments as OtpVerificationRoutingArgument?;
            return OTPVerification(
              emailAndPhone: otpArguments?.emailAndPhone,
              type: otpArguments?.type,
              text: otpArguments?.text,
            );
          // case AppRoutes.verificationSelectionScreenRoute:
          //   OtpVerificationRoutingArgument? otpArguments =
          //       routeSettings.arguments as OtpVerificationRoutingArgument?;
          //   return VerificationSelection(
          //     type: otpArguments?.type,
          //     email: otpArguments?.email,
          //     phone: otpArguments?.phone,
          //   );
          // case AppRoutes.changePasswordScreenRoute:
          //   return ChangePassword();
          case AppRoutes.resetPasswordScreenRoute:
            ResetPasswordRoutingArgument? resetPasswordArguments =
                routeSettings.arguments as ResetPasswordRoutingArgument?;
            return ResetPassword(
              email: resetPasswordArguments?.email ?? "",
            );

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
            final ratingArgs = routeSettings.arguments is ReviewRoutingArgument
                ? routeSettings.arguments as ReviewRoutingArgument
                : null;
            return RatingScreen.fromArgs(ratingArgs);
          // case AppRoutes.MyAppointmentScreenRoute:
          //   return MyAppointment();
          case AppRoutes.bookingScreenRoute:
            BookingRoutingArgument bookingArgument =
                routeSettings.arguments as BookingRoutingArgument;
            return BookingDetails(
              bookingId: bookingArgument.bookingId ?? 0,
              initialStatus: bookingArgument.Status,
            );
          // case AppRoutes.videoCallScreenRoute:
          //   return VideoCallScreen();
          case AppRoutes.workDocumentsScreenRoute:
            final workDocsArgs =
                routeSettings.arguments as WorkDocumentsRoutingArgument;
            return WorkDocuments.fromArgs(workDocsArgs);
          case AppRoutes.invoiceScreenRoute:
            final invoiceArgs =
                routeSettings.arguments as InvoiceRoutingArgument;
            return InvoiceScreen.fromArgs(invoiceArgs);
          case AppRoutes.writeReviewScreenRoute:
            final reviewArgs = routeSettings.arguments is ReviewRoutingArgument
                ? routeSettings.arguments as ReviewRoutingArgument
                : null;
            return WriteReviewScreen.fromArgs(reviewArgs);
          case AppRoutes.reportIssueScreenRoute:
            return ReportIssue.fromArgs(routeSettings.arguments);
          // case AppRoutes.favouritesScreenRoute:
          //   return ReportIssue();
          case AppRoutes.listOfServicesScreenRoute:
            ServiceRoutingArgument serviceArgument =
                routeSettings.arguments as ServiceRoutingArgument;

            return ListOfServices(
              type: serviceArgument.type,
              isQuick: serviceArgument.isQuick ??
                  (serviceArgument.type == ServiceType.instant.name),
            );
          case AppRoutes.providerProfileScreenRoute:
            ServiceRoutingArgument serviceArgument =
                routeSettings.arguments as ServiceRoutingArgument;
            return ProviderProfile(
              type: serviceArgument.type,
              serviceId: serviceArgument.serviceId,
              providerId: serviceArgument.providerId,
            );
          case AppRoutes.servicesScreenRoute:
            ServiceRoutingArgument serviceArgument =
                routeSettings.arguments as ServiceRoutingArgument;
            return SingleService(
              serviceName: serviceArgument.serviceName,
              type: serviceArgument.type,
              serviceId: serviceArgument.serviceId,
            );
          case AppRoutes.chatScreenRoute:
            final chatArgument = routeSettings.arguments is ChatRoutingArgument
                ? routeSettings.arguments as ChatRoutingArgument
                : null;
            return ChatScreen.fromArgs(chatArgument);
          case AppRoutes.serviceDetailsScreenRoute:
            ServiceRoutingArgument serviceArgument =
                routeSettings.arguments as ServiceRoutingArgument;

            return ServiceDetails(
              type: serviceArgument.type,
              serviceId: serviceArgument.serviceId,
              providerId: serviceArgument.providerId,
              providerServiceId: serviceArgument.providerServiceId,
            );
          case AppRoutes.serviceSelectionScreenRoute:
            final selectionArgs =
                routeSettings.arguments is ServiceRoutingArgument
                    ? routeSettings.arguments as ServiceRoutingArgument
                    : null;
            return ServiceSelection.fromArgs(selectionArgs);
          case AppRoutes.chooseYourPaymentMethodScreenRoute:
            return ChoosePaymentMethod();
          case AppRoutes.signInWithAffirmScreenRoute:
            return SignInWithAffirm();
          case AppRoutes.selectAPaymentPlanScreenRoute:
            return SelectAPaymentPlan();
          case AppRoutes.payOverTimeScreenRoute:
            return PayOverTime();
          case AppRoutes.favouritesScreenRoute:
            return FavouritesServices();
          case AppRoutes.scheduleBookingScreenRoute:
            final scheduleArgs =
                routeSettings.arguments is ServiceRoutingArgument
                    ? routeSettings.arguments as ServiceRoutingArgument
                    : null;
            return ScheduleBooking.fromArgs(scheduleArgs);
          case AppRoutes.marketPlaceScreenRoute:
            return MarketPlace();
          case AppRoutes.proChatScreenRoute:
            return ProChat();
          case AppRoutes.createAProPostScreenRoute:
            return CreateAProPost();
          case AppRoutes.checkoutWebViewScreenRoute:
            CheckoutRoutingArguments checkoutArgs =
                routeSettings.arguments as CheckoutRoutingArguments;
            return CheckoutWebViewScreen(args: checkoutArgs);
          case AppRoutes.createANewPostScreenRoute:
            AddEditPostRoutingArgument postArgument =
                routeSettings.arguments as AddEditPostRoutingArgument;
            return CreateANewPost(type: postArgument.type);
          case AppRoutes.myPostsScreenRoute:
            return MyPosts();
          case AppRoutes.addEditProductScreenRoute:
            AddEditProductRoutingArgument productArgument =
                routeSettings.arguments as AddEditProductRoutingArgument;
            return AddEditProduct(type: productArgument.type ?? "");
          case AppRoutes.productDetailScreenRoute:
            return ProductDetail();
          case AppRoutes.addToCartScreenRoute:
            return AddToCart();
          case AppRoutes.ordersScreenRoute:
            return OrdersScreen();
          case AppRoutes.orderDetailScreenRoute:
            return OrderDetail();
          case AppRoutes.pastworkScreenRoute:
            final pastWorkArgs =
                routeSettings.arguments is PastWorkRoutingArgument
                    ? routeSettings.arguments as PastWorkRoutingArgument
                    : null;
            return PastWork.fromArgs(pastWorkArgs);
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
