class NetworkStrings {
  static const String API_BASE_URL =
      //live
      "http://168.231.74.154:6252/api/";
      // "http://77.37.74.16:4004/api/";
  // "https://cjb8lkts-4400.euw.devtunnels.ms/api/";
  //local
  // "https://cjb8lkts-4400.euw.devtunnels.ms/api/";

  // static const String api = "api/";
  // static const String IMAGE_BASE_URL =
  //     "https://server1.appsstaging.com/3559/parallel_universe/public/storage/";

   static const String IMAGE_BASE_URL =
      //live
      "http://168.231.74.154:6252";

  static const String ACCEPT = 'application/json';
  static const int SUCCESS_CODE = 200;
  static const int NOT_FOUND_CODE = 400;
  static const int BAD_REQUEST_CODE = 404;
  static const int SERVER_NOT_FOUND_CODE = 500;
  static const int FAILURE_STAUS_SUCCESS_CODE = 400;
  static const int UNAUTHORIZED_USER_CODE = 401;
  static const bool API_SUCCESS_STATUS = true;
  static const bool API_FAILURE_STATUS = false;

  ///-------------------- Shared Preference Keys -------------------- ///
  static const String BEARER_TOKEN = "Bearer Token";
  static const String USER = "User";

//----------------------------Auth-----------------------------------
  static const String signupEndpoint = "user";
  static const String verificationEmailEndpoint = "verify-otp";
  static const String verificationResetPasswordEndpoint = "verify-reset-otp";
  static const String resendCodeEndpoint = "resend-verification";
  static const String resetPassEndpoint = "reset-password";
  static const String signinEndpoint = "login";
  static const String changePasswordEndpoint = "change-password";
  static const String editProfileEndpoint = "user/provider";
  static const String logoutEndpoint = "logout";
  static const String deleteAccountEndpoint = "user";
  static const String serviceTypesEndpoint = "service-type/types";

  /// GET [user/freelancers/{serviceTypeId}?isQuick=] — freelancers for a service type id.
  static String freelancersByServiceId(int serviceId) =>
      'user/freelancers/$serviceId';

  /// GET [user/details/{id}] — provider profile by user id (UUID).
  static String userDetailsById(String userId) => 'user/details/$userId';

  /// POST [favourites/providers/{id}] — add provider to favourites (auth).
  /// DELETE [favourites/providers/{id}] — remove from favourites (auth).
  static String favouriteProvider(String providerId) =>
      'favourites/providers/$providerId';

  /// GET [favourites/providers/{id}/status] — whether provider is favourited (auth).
  static String favouriteProviderStatus(String providerId) =>
      'favourites/providers/$providerId/status';

  /// POST [favourites/services/{id}] — add provider-service row to favourites (auth).
  /// DELETE [favourites/services/{id}] — remove from favourites (auth).
  static String favouriteService(String serviceId) =>
      'favourites/services/$serviceId';

  /// GET [favourites/services/{id}/status] — whether that service row is favourited (auth).
  static String favouriteServiceStatus(String serviceId) =>
      'favourites/services/$serviceId/status';

  /// GET [provider/{id}] — provider service detail by provider-service row id (auth).
  static String providerServiceDetail(String id) => 'provider/$id';

  /// GET [favourites/services] — list of favourite service rows (auth).
  static const String favouriteServicesListEndpoint = 'favourites/services';

  /// GET [payment/user] — current user payment transactions (auth).
  static const String userPaymentsEndpoint = 'payment/user';

  /// GET [bookings/user] — current user's bookings (auth).
  static const String userBookingsEndpoint = 'bookings/user';

  /// POST [bookings] — create booking(s) (auth).
  static const String createBookingsEndpoint = 'bookings';

  /// POST [payment/create-booking-draft-checkout] — Stripe checkout for booking draft (auth).
  static const String createBookingDraftCheckoutEndpoint =
      'payment/create-booking-draft-checkout';

  /// POST [payment/bookings/create-and-pay] — create booking(s) and pay (auth).
  static const String createBookingAndPayEndpoint =
      'payment/bookings/create-and-pay';

  static const String bookingPaymentReturnUrl =
      'https://yourapp.com/payment/success';

  static const String bookingCheckoutSuccessPath =
      '/booking/checkout/success';
  static const String bookingCheckoutCancelPath = '/booking/checkout/cancel';

  static String get bookingCheckoutSuccessUrl =>
      '$IMAGE_BASE_URL$bookingCheckoutSuccessPath';

  static String get bookingCheckoutCancelUrl =>
      '$IMAGE_BASE_URL$bookingCheckoutCancelPath';

  /// GET [bookings/check-active?serviceId=&providerId=] — active booking for provider-service row (auth).
  /// [serviceId] query param is the provider-service row id (`providerServices[].id`).
  static String checkActiveBooking({
    required String providerServiceId,
    required String providerId,
  }) =>
      'bookings/check-active?serviceId=$providerServiceId&providerId=$providerId';

  /// GET [bookings/detail/{id}] — booking detail by id (auth).
  static String bookingDetail(int id) => 'bookings/detail/$id';

  /// PATCH [bookings/booking/status] — update booking status (auth).
  static const String bookingStatusEndpoint = 'bookings/booking/status';

  /// POST [ratings] — submit provider rating and review (auth).
  static const String ratingsEndpoint = 'ratings';

  /// GET [ratings/provider/{id}] — provider ratings and reviews (auth).
  static String providerRatings(String providerId) =>
      'ratings/provider/$providerId';

  /// POST [reports] — submit booking report (auth).
  static const String reportsEndpoint = 'reports';

  /// GET [referrals/my-referrals] — referral summary + referral rows (auth).
  static const String myReferralsEndpoint = 'referrals/my-referrals';

  /// POST [community/posts] — create community post (multipart: description, image) (auth).
  static const String communityPostsEndpoint = 'community/posts';

  /// GET [community/posts/mine] — current user's posts (auth).
  static const String communityPostsMineEndpoint = 'community/posts/mine';

  /// DELETE [community/posts/{id}] — delete post by id (auth).
  static String communityPostById(String id) => 'community/posts/$id';

  /// POST [ask-pro/user/checkout] — Stripe checkout session for Ask a Pro (auth).
  static const String askProCheckoutEndpoint = 'ask-pro/user/checkout';

  static const String askProCheckoutSuccessPath = '/ask-pro/checkout/success';
  static const String askProCheckoutCancelPath = '/ask-pro/checkout/cancel';

  static String get askProCheckoutSuccessUrl =>
      '$IMAGE_BASE_URL$askProCheckoutSuccessPath';

  static String get askProCheckoutCancelUrl =>
      '$IMAGE_BASE_URL$askProCheckoutCancelPath';

  /// POST [ask-pro/query] — submit Ask a Pro question (multipart) (auth).
  static const String askProQueryEndpoint = 'ask-pro/query';

  /// GET [live-chat/my-chats] — current user's chat list (auth).
  static const String myChatsEndpoint = 'live-chat/my-chats';

  /// GET [live-chat/{chatId}/history/chat] — chat message history (auth).
  static String chatHistory(String chatId) =>
      'live-chat/$chatId/history/chat';

  /// GET [categories] — category list with UUID ids (auth).
  static const String categoriesEndpoint = 'categories';

  /// GET/POST [community/posts/{id}/comments] — list / add comments (auth).
  static String communityPostComments(String postId) =>
      'community/posts/$postId/comments';

  /// GET [community/posts/{id}/reactions] — reaction counts + users (auth).
  static String communityPostReactions(String postId) =>
      'community/posts/$postId/reactions';

  static const String contactUsEndpoint = "contact-us";
  static const String queriesEndpoint = "queries";
  static const String contentEndpoint = "cms/public";

  /// GET [pages/{slug}] — CMS page by slug (about, privacy, terms, refund).
  static String pageBySlug(String slug) => 'pages/$slug';
  static const String settingsEndpoint = "user/toggle";
  static const String emergencyEndpoint = "emergency";
  static const String singleVoiceEndpoint = "tasks/voice-note";
  static const String addTaskEndpoint = "tasks/bulk";
  static const String taskEndpoint = "tasks";
  static const String allTaskRemoveEndpoint = "tasks/all/tasks";






  static const String projectKeyEndpoint = "user/project_env/Abcd@1234";
  static const String forgotPassEndpoint = "forgot-password";
  static const String deleteProfileImageEndpoint = "user/remove_media";
  // static const String createHorseProfileEndpoint = "user-horse/create";
  // static const String updateHorsePrefileEndpoint = "user-horse/update";
  // static const String horsesEndpoint = "user-horse/list";
  // static const String pushNotificationEndpoint = "/user-settings/toggle-notification";
  // static const String getContentEndpoint = "user-settings";

  // //----------------------------Home-----------------------------------
  // static const String homeTotalExpenseEndpoint = "home/total/all-expenses";
  // static const String homeTotalEarningEndpoint = "home/total-earnings";
  // static const String homeHorseGraphEndpoint = "home/horse/earning-graph";
  // static const String homeRodeoGraphEndpoint = "home/rodeos/earning-graph";
  // static const String allExpensesEndpoint = "home/total-expenses-details";
  // static const String filterExpensesEndpoint = "home/filter-expenses-detail";
  // static const String addsEndpoint = "home/adds";
  // static const String viewAddsEndpoint = "home/adds/view";
  // static const String purchaseSubscriptionEndpoint = "purchase-subscription";

  // //----------------------------My Notes-----------------------------------
  // static const String addNotesEndpoint = "user/create-note";
  // static const String editNotesEndpoint = "user/update-note";
  // static const String notesEndpoint = "user/get-all/notes";
  // static const String searchNotesEndpoint = "user/search-notes";

  // static const String deleteNotesEndpoint = "user/delete-note";

  // //--------------------------Other Services-----------------------------------
  // static const String addOtherServicesEndpoint = "user/other-service/create";
  // static const String editOtherServicesEndpoint = "user/other-service/update";
  // static const String otherServicesEndpoint = "user/other-service/list";
  // static const String filterOtherServicesEndpoint = "user/other-service/filter";
  // static const String searchOtherServicesEndpoint = "user/other-service/search";

  // static const String deleteOtherServicesEndpoint = "user/other-service/delete";

  // //--------------------------Vet Locations-----------------------------------
  // static const String addVetLocationsEndpoint = "user/vet/create";
  // static const String editVetLocationsEndpoint = "user/vet/update";
  // static const String vetLocationsEndpoint = "user/vet/list";
  // static const String searchVetLocationsEndpoint = "user/vet/search";
  // static const String filterVetLocationEndpoint = "user/vet/filter";
  // static const String deleteVetLocationsEndpoint = "user/vet/delete";

  // //--------------------------Horse Hotel-----------------------------------
  // static const String addHoreseHotelEndpoint = "user/horse-hotel/create";
  // static const String editHoreseHotelEndpoint = "user/horse-hotel/update";
  // static const String horeseHotelEndpoint = "user/horse-hotel/list";
  // static const String searchHoreseHotelEndpoint = "user/horse-hotel/search";
  // static const String filterHoreseHotelEndpoint = "user/horse-hotel/filter";
  // static const String deleteHoreseHotelEndpoint = "user/horse-hotel/delete";

  // //--------------------------Horse Hotel-----------------------------------
  // static const String helpAndFeedbackEndpoint = "user-settings/submit-feedback";

  // //--------------------------Planned Events-----------------------------------
  // static const String addPlannedEventsEndpoint = "planned-events/create";
  // static const String editPlannedEventsEndpoint = "planned-events";
  // static const String plannedEventsEndpoint = "planned-events/get-by-date";
  // static const String deletePlannedEventsEndpoint = "planned-events";

  // //--------------------------Calendar Events-----------------------------------
  // static const String addCalendarEventsEndpoint = "calendar-events";
  // static const String editCalendarEventsEndpoint = "calendar-events";
  // static const String calendarEventsEndpoint = "calendar-events/fetch-by-date";
  // static const String calendarEventsDateSpecificEndpoint = "calendar-events";

  // //--------------------------Vehicle Maintenance-----------------------------------
  // static const String addVehicleMaintenanceEndpoint = "user-expense/add/vehicle-maintenance";
  // static const String editVehicleMaintenanceEndpoint = "user-expense/single/vehicle-maintenance";
  // static const String vehicleMaintenanceEndpoint = "user-expense/list/vehicle-maintenance";
  // static const String searchVehicleMaintenanceEndpoint = "user-expense/search/vehicle-maintenance";
  // static const String deleteVehicleMaintenanceEndpoint = "user-expense/single/vehicle-maintenance";
  // static const String totalVehicleMaintenanceEndpoint = "user-expense/total-cost/vehicle-maintenance";

  // //--------------------------Trailer Maintenance-----------------------------------
  // static const String addTrailerMaintenanceEndpoint = "user-expense/add/trailer-maintenance";
  // static const String editTrailerMaintenanceEndpoint = "user-expense/update/trailer-maintenance";
  // static const String trailerMaintenanceEndpoint = "user-expense/list/trailer-maintenance";
  // static const String searchTrailerMaintenanceEndpoint = "user-expense/search/trailer-maintenance";
  // static const String deleteTrailerMaintenanceEndpoint = "user-expense/single/trailer-maintenance";
  // static const String totalTrailerMaintenanceEndpoint = "user-expense/total-cost/trailer-maintenance";

  // //--------------------------Tire Replacement-----------------------------------
  // static const String addTireReplacementEndpoint = "user-expense/tire-replacement";
  // static const String editTireReplacementEndpoint = "user-expense/tire-replacement";
  // static const String tireReplacementEndpoint = "user-expense/tire-replacement/list";
  // static const String searchTireReplacementEndpoint = "user-expense/tire-replacement/search";
  // static const String deleteTireReplacementEndpoint = "user-expense/tire-replacement/delete";
  // static const String totalTireReplacementEndpoint = "user-expense/tire-replacement/total-cost";

  // //--------------------------Tack-----------------------------------
  // static const String addTackEndpoint = "user-expense/track";
  // static const String editTackEndpoint = "user-expense/track";
  // static const String tackEndpoint = "user-expense/track-list";
  // static const String searchTackEndpoint = "user-expense/track/search";
  // static const String deleteTackEndpoint = "user-expense/track-delete";
  // static const String totalTackEndpoint = "user-expense/track/total-cost";

  // //--------------------------Performance Clothing-----------------------------------
  // static const String addPerformanceClothingEndpoint = "user-expense/performance-clothing";
  // static const String editPerformanceClothingEndpoint = "user-expense/performance-clothing";
  // static const String performanceClothingEndpoint = "user-expense/performance-clothing";
  // static const String searchPerformanceClothingEndpoint = "user-expense/performance-clothing/search";
  // static const String deletePerformanceClothingEndpoint = "user-expense/performance-clothing";
  // static const String totalPerformanceClothingEndpoint = "user-expense/performance-clothing/total-cost";

  // //--------------------------Trailer Insurance-----------------------------------
  // static const String addTrailerInsuranceEndpoint = "user-expense/trailer-insurance";
  // static const String editTrailerInsuranceEndpoint = "user-expense/trailer-insurance";
  // static const String trailerInsuranceEndpoint = "user-expense/trailer-insurance";
  // static const String searchTrailerInsuranceEndpoint = "user-expense/trailer-insurance/search";
  // static const String deleteTrailerInsuranceEndpoint = "user-expense/trailer-insurance";
  // static const String totalTrailerInsuranceEndpoint = "user-expense/trailer-insurance/total-cost";

  // //--------------------------Gas-----------------------------------
  // static const String addGasEndpoint = "user-expense/gas";
  // static const String editGasEndpoint = "user-expense/gas";
  // static const String gasEndpoint = "user-expense/gas-list";
  // static const String searchGasEndpoint = "user-expense/gas-search";
  // static const String deleteGasEndpoint = "user-expense/gas-delete";
  // static const String totalGasEndpoint = "user-expense/gas/total-cost";

  // //--------------------------Travel Partner Info-----------------------------------
  // static const String addTravelPartnerInfoEndpoint = "user-expense/travel-info";
  // static const String editTravelPartnerInfoEndpoint = "user-expense/travel-info";
  // static const String travelPartnerInfoEndpoint = "user-expense/travel-info";
  // static const String searchTravelPartnerInfoEndpoint = "user-expense/travel-info-search";
  // static const String deleteTravelPartnerInfoEndpoint = "user-expense/travel-info";

  // //--------------------------Association Membership-----------------------------------
  // static const String addAssociationMembershipEndpoint = "user-expense/association-membership";
  // static const String editAssociationMembershipEndpoint = "user-expense/association-membership";
  // static const String associationMembershipEndpoint = "user-expense/association-membership/list";
  // static const String searchAssociationMembershipEndpoint = "user-expense/association-membership/search";
  // static const String deleteAssociationMembershipEndpoint = "user-expense/association-membership";
  // static const String totalAssociationMembershipEndpoint = "user-expense/association-membership/total-cost";

  // //--------------------------Truck Insurance-----------------------------------
  // static const String addTruckInsuranceEndpoint = "user-expense/truck-insurance";
  // static const String editTruckInsuranceEndpoint = "user-expense/truck-insurance";
  // static const String truckInsuranceEndpoint = "user-expense/truck-insurance/list";
  // static const String searchTruckInsuranceEndpoint = "user-expense/truck-insurance/search";
  // static const String deleteTruckInsuranceEndpoint = "user-expense/truck-insurance";
  // static const String totalTruckInsuranceEndpoint = "user-expense/truck-insurance/total-cost";

  // //--------------------------Performance Clothing-----------------------------------
  // static const String addSupplemantsEndpoint = "horse-expense/supplements";
  // static const String editSupplemantsEndpoint = "horse-expense/supplements";
  // static const String supplemantsEndpoint = "horse-expense/supplements/list";
  // static const String searchSupplemantsEndpoint = "horse-expense/supplements/search";
  // static const String deleteSupplemantsEndpoint = "horse-expense/supplements";
  // static const String totalSupplemantsEndpoint = "horse-expense/supplements/total-cost";

  // //--------------------------Performance Clothing-----------------------------------
  // static const String addMedicationsDeliverySystemEndpoint = "horse-expense/medication-delivery";
  // static const String editMedicationsDeliverySystemEndpoint = "horse-expense/medication-delivery";
  // static const String medicationsDeliverySystemEndpoint = "horse-expense/medication-delivery/list";
  // static const String searchMedicationsDeliverySystemEndpoint = "horse-expense/medication-delivery/search";
  // static const String deleteMedicationsDeliverySystemEndpoint = "horse-expense/medication-delivery";
  // static const String totalMedicationsDeliverySystemEndpoint = "horse-expense/medication-delivery/total-cost";

  // // //--------------------------Horse Insurance-----------------------------------
  // static const String addHorseInsuranceEndpoint = "horse-expense/insurance";
  // static const String editHorseInsuranceEndpoint = "horse-expense/insurance";
  // static const String horseInsuranceEndpoint = "horse-expense/insurance/list";
  // static const String searchHorseInsuranceEndpoint = "horse-expense/insurance/search";
  // static const String deleteHorseInsuranceEndpoint = "horse-expense/insurance";
  // static const String totalHorseInsuranceEndpoint = "horse-expense/insurance/total-cost";

  // // //--------------------------Feeds-----------------------------------
  // static const String addFeedsEndpoint = "horse-expense/feed-purchase";
  // static const String editFeedsEndpoint = "horse-expense/feed-purchase";
  // static const String feedsEndpoint = "horse-expense/feed-purchase/list";
  // static const String searchFeedsEndpoint = "horse-expense/feed-purchase/search";
  // static const String deleteFeedsEndpoint = "horse-expense/feed-purchase";
  // static const String totalFeedsEndpoint = "horse-expense/feed-purchase/total-cost";

  // // //--------------------------Bedding-----------------------------------
  // static const String addBeddingEndpoint = "horse-expense/bedding";
  // static const String editBeddingEndpoint = "horse-expense/bedding";
  // static const String beddingEndpoint = "horse-expense/bedding/list";
  // static const String searchBeddingEndpoint = "horse-expense/bedding/search";
  // static const String deleteBeddingEndpoint = "horse-expense/bedding";
  // static const String totalBeddingEndpoint = "horse-expense/bedding/total-cost";

  // // //--------------------------Veterinary Treatments-----------------------------------
  // static const String addVeterinaryTreatmentsEndpoint = "horse-expense/veterinary-treatments";
  // static const String editVeterinaryTreatmentsEndpoint = "horse-expense/veterinary-treatments";
  // static const String veterinaryTreatmentsEndpoint = "horse-expense/veterinary-treatments/list";
  // static const String searchVeterinaryTreatmentsEndpoint = "horse-expense/veterinary-treatments/search";
  // static const String deleteVeterinaryTreatmentsEndpoint = "horse-expense/veterinary-treatments";
  // static const String totalVeterinaryTreatmentsEndpoint = "horse-expense/veterinary-treatments/total-cost";

  // // //--------------------------Earning Association-----------------------------------
  // static const String addEarningAssociationEndpoint = "horse-expense/earnings/association";
  // static const String editEarningAssociationEndpoint = "horse-expense/earnings/association";
  // static const String earningAssociationEndpoint = "horse-expense/earnings/association/list";
  // // static const String searchVeterinaryTreatmentsEndpoint =
  // //     "horse-expense/veterinary-treatments/search";
  // static const String deleteEarningAssociationEndpoint = "horse-expense/earnings/association";
  // static const String totalEarningAssociationEndpoint = "horse-expense/earnings/total-cost";

  // static const String addEarningEndpoint = "horse-expense/earnings/association-earning";
  // static const String editEarningEndpoint = "horse-expense/earnings/association-earning";
  // // static const String earningEndpoint = "horse-expense/earnings/association-earning/list";
  // static const String earningEndpoint = "horse-expense/earnings/rodeo-horse-earning";
  // static const String searchEarningEndpoint = "horse-expense/earnings/association-earning/search";
  // static const String deleteEarningEndpoint = "horse-expense/earnings/association-earning";
  // static const String totalEarningEndpoint = "horse-expense/earnings/association-earning/total";

  // // //--------------------------Farrier Info-----------------------------------
  // static const String addFarrierInfoEndpoint = "horse-expense/farrier/info";
  // static const String editFarrierInfoEndpoint = "horse-expense/farrier/info";
  // static const String farrierInfoEndpoint = "horse-expense/farrier/info/list";
  // // static const String searchVeterinaryTreatmentsEndpoint =
  // //     "horse-expense/veterinary-treatments/search";
  // static const String deleteFarrierInfoEndpoint = "horse-expense/farrier/info";
  // static const String totalFarrierInfoEndpoint = "horse-expense/farrier/total-cost";
  // static const String addShoeingRecordsEndpoint = "horse-expense/farrier/expense";
  // static const String editShoeingRecordsEndpoint = "horse-expense/farrier/expense";
  // static const String shoeingRecordsEndpoint = "horse-expense/farrier/expense/list";
  // static const String searchShoeingRecordsEndpoint = "horse-expense/farrier/expense/search";
  // static const String deleteShoeingRecordsEndpoint = "horse-expense/farrier/expense";
  // static const String totalShoeingRecordsEndpoint = "horse-expense/farrier/expense/total-cost";
  // // //--------------------------General Maintenance-----------------------------------
  // static const String addGeneralMaintenanceEndpoint = "horse-expense/general-maintenance/detail";
  // static const String editGeneralMaintenanceEndpoint = "horse-expense/general-maintenance/detail";
  // static const String generalMaintenanceEndpoint = "horse-expense/general-maintenance/detail/list";
  // // static const String searchVeterinaryTreatmentsEndpoint =
  // //     "horse-expense/veterinary-treatments/search";
  // static const String deleteGeneralMaintenanceEndpoint = "horse-expense/general-maintenance/detail";
  // static const String totalGeneralMaintenanceEndpoint = "horse-expense/general-maintenance/total-cost";

  // static const String addVaccineExpenseEndpoint = "horse-expense/general-maintenance/vaccine-expense";
  // static const String addWomingExpenseEndpoint = "horse-expense/general-maintenance/woming-expense";
  // static const String addDentalExpenseEndpoint = "horse-expense/general-maintenance/dental-expense";
  // static const String editVaccineExpenseEndpoint = "horse-expense/general-maintenance/vaccine-expense";
  // static const String editWomingExpenseEndpoint = "horse-expense/general-maintenance/woming-expense";
  // static const String editDentalExpenseEndpoint = "horse-expense/general-maintenance/dental-expense";
  // static const String generalMaintenanceExpenseEndpoint = "horse-expense/general-maintenance/expense/list";
  // // static const String searchGeneralMaintenanceExpenseEndpoint =
  // //     "horse-expense/general-maintenance/expense/search";
  // static const String deleteGeneralMaintenanceExpenseEndpoint = "horse-expense/general-maintenance/expense";
  // static const String totalGeneralMaintenanceExpenseEndpoint = "horse-expense/general-maintenance/expense/total-cost";

  // // ----------------------------Rodeo-----------------------------------
  // static const String addRodeoEndpoint = "rodeo";
  // static const String rodeoWinningHorseEndpoint = "rodeo/association/winning-horses";
  // static const String rodeosEndpoint = "rodeo/list";
  // static const String deleteRodeoEndpoint = "rodeo";
  // static const String drawEndpoint = "rodeo/draw";
  // static const String editDrawEndpoint = "rodeo/draw";
  // static const String arenaEndpoint = "rodeo/arena";
  // static const String editArenaEndpoint = "rodeo/arena";
  // static const String winingEndpoint = "rodeo/winning";
  // static const String editWiningEndpoint = "rodeo/winning";
  // static const String rodeoDetailsEndpoint = "rodeo/detail";
  // static const String editRodeoDetailsEndpoint = "rodeo/detail";
  // static const String editRodeoNameEndpoint = "rodeo/event-name";

  // // //--------------------------StallBoarding-----------------------------------
  // static const String addStallBoardingEndpoint = "rodeo/stalls-boarding";
  // static const String editStallBoardingEndpoint = "rodeo/stalls-boarding";
  // static const String stallBoardingEndpoint = "rodeo/stalls-boarding/list";
  // static const String searchStallBoardingEndpoint = "rodeo/stalls-boarding/search";
  // static const String deleteStallBoardingEndpoint = "rodeo/stalls-boarding";
  // static const String totalStallBoardingEndpoint = "rodeo/stalls-boarding/total-cost";

  // // //--------------------------Meal-----------------------------------
  // static const String addMealEndpoint = "rodeo/meals";
  // static const String editMealEndpoint = "rodeo/meals";
  // static const String mealEndpoint = "rodeo/meals/list";
  // static const String searchMealEndpoint = "rodeo/meals/search";
  // static const String deleteMealEndpoint = "rodeo/meals";
  // static const String totalMealEndpoint = "rodeo/meals/total-cost";

  // // //--------------------------Lodging-----------------------------------
  // static const String addLodgingEndpoint = "rodeo/lodging";
  // static const String editLodgingEndpoint = "rodeo/lodging";
  // static const String lodgingEndpoint = "rodeo/lodging/list";
  // static const String searchLodgingEndpoint = "rodeo/lodging/search";
  // static const String deleteLodgingEndpoint = "rodeo/lodging";
  // static const String totalLodgingEndpoint = "rodeo/lodging/total-cost";

  // // //--------------------------Entry Fees-----------------------------------
  // static const String addEntryFeesEndpoint = "rodeo/entry-fees";
  // static const String editEntryFeesEndpoint = "rodeo/entry-fees";
  // static const String entryFeesEndpoint = "rodeo/entry-fees/list";
  // static const String searchEntryFeesEndpoint = "rodeo/entry-fees/search";
  // static const String deleteEntryFeesEndpoint = "rodeo/entry-fees";
  // static const String totalEntryFeesEndpoint = "rodeo/entry-fees/total-cost";

  // // //--------------------------Bedding Rodeos-----------------------------------
  // static const String addBeddingRodeosEndpoint = "rodeo/bedding";
  // static const String editBeddingRodeosEndpoint = "rodeo/bedding";
  // static const String beddingRodeosEndpoint = "rodeo/bedding/list";
  // static const String searchBeddingRodeosEndpoint = "rodeo/bedding/search";
  // static const String deleteBeddingRodeosEndpoint = "rodeo/bedding";
  // static const String totalBeddingRodeosEndpoint = "rodeo/bedding/total-cost";

  // // //--------------------------Earning Rodeos Association-----------------------------------
  // static const String addEarningRodeosAssociationEndpoint = "rodeo/association";
  // static const String editEarningRodeosAssociationEndpoint = "rodeo/association";
  // static const String earningRodeosAssociationEndpoint = "rodeo/association/list";
  // // static const String searchVeterinaryTreatmentsEndpoint =
  // //     "horse-expense/veterinary-treatments/search";
  // static const String deleteEarningRodeosAssociationEndpoint = "rodeo/association";
  // static const String totalEarningRodeosAssociationEndpoint = "rodeo/association/all/earnings";

  // static const String addEarningRodeosEndpoint = "rodeo/association/earning";
  // static const String editEarningRodeosEndpoint = "rodeo/association/earning";
  // static const String earningRodeosEndpoint = "rodeo/association/earning/list";
  // static const String searchEarningRodeosEndpoint = "rodeo/association/earning/search";
  // static const String deleteEarningRodeosEndpoint = "rodeo/association/earning";
  // static const String totalEarningRodeosEndpoint = "rodeo/association/earning/total";

  // //----------------------------Notification-----------------------------------
  // static const String notificationsEndpoint = "notification";
  // static const String readNotificationEndpoint = "notification/mark-as-read";
  // static const String notificationsCountEndpoint = "notification/unRead-count";
  // static const String markAsAllReadEndpoint = "notification/mark-as-read";
  // static const String reportUserEndpoint = "report-user";
  // static const String muteUnmuteUserEndpoint = "mute-unmute-user";
  // static const String favUnfavUserEndpoint = "fav-unfav-profile";
  // static const String favUserEndpoint = "favorites";

  // //----------------------------Card-----------------------------------
  // static const String AddCardEndpoint = "add-stripe-card";
  // static const String GetCardsEndpoint = "list-stripe-cards";
  // static const String SetDefaultCardsEndpoint = "active-card";
  // static const String DeleteCardEndpoint = "delete-stripe-card";

  // //----------------------------Post-----------------------------------
  // static const String postEndpoint = "posts";
  // static const String pinUnPinEndpoint = "pin-unpin-post";
  // static const String createPostEndpoint = "add_update_post";
  // static const String userPostEndpoint = "user-posts";
  // static const String commentOnPostEndpoint = "add_update_comment";
  // static const String deleteCommentEndpoint = "delete-comment";
  // static const String deletePostEndpoint = "delete-post";
  // static const String postDetailEndpoint = "post";
  // static const String likeUnlikeEndpoint = "like-unlike-post";
  // static const String reportCommentEndpoint = "report-comment";
  // static const String likeUnlikeCommentEndpoint = "like-unlike-comment";
  // static const String reportPostEndpoint = "report-post";

  // //----------------------------Collection-----------------------------------
  // static const String addUpdateCardToCollectionEndpoint = "add_update_card";
  // static const String collectionEndpoint = "collection";
  // static const String cardDetailEndpoint = "card-details";
  // static const String deleteCardEndpoint = "delete-card";
  // static const String pinUnPinCardEndpoint = "pin-unpin-card";

  // //----------------------------Store-----------------------------------
  // static const String createMyStoreEndpoint = "add_update_store";
  // static const String myStoreEndpoint = "store";
  // static const String myWishlistEndpoint = "wishlist";
  static const String productsEndpoint = 'products';

  /// GET [products/owner/{ownerId}] — products for the logged-in user.
  static String productsByOwner(String ownerId) => 'products/owner/$ownerId';
  // static const String addProductEndpoint = "add_update_product";
  // static const String productDetailEndpoint = "product-details";
  // static const String deleteProductEndpoint = "delete-product";
  // static const String favUnfavProductEndpoint = "fav-unfav-product";
  // static const String viewCartEndpoint = "view-cart";
  // static const String addCartEndpoint = "add-to-cart";
  // static const String deleteCartProductEndpoint = "remove-from-cart";
  // static const String addAddressEndpoint = "add-update-address";
  // static const String addressEndpoint = "address";
  // static const String placeOrderEndpoint = "place-order";
}
