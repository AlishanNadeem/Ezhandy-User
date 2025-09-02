// import 'package:calendar_view/calendar_view.dart';
import 'package:get/get.dart';
class HomeController extends GetxController {
  static HomeController get i => Get.find();

  RxInt selectedTab = 0.obs;
//   RxString selectedHorse = "".obs;
//   var selectedDate = DateTime.now().obs;
//   var selectedWeek = 1.obs;
//   var selectedDay = Rx<DateTime?>(null);
//   RxList<AddsModelData?> addsList = RxList<AddsModelData?>();
//   Rx<MetaDataModelMetadata?> metaData = MetaDataModelMetadata().obs;
//   Rx<MetaDataModelMetadata?> metaDataStarting = MetaDataModelMetadata().obs;
//   RxList<NotesModelDataNotes?> notesList = RxList<NotesModelDataNotes?>();
//   Rx<NotesModelDataNotes?> notesDetail = NotesModelDataNotes().obs;
//   RxList<OtherServicesModelDataOtherServices?> otherServicesList = RxList<OtherServicesModelDataOtherServices?>();
//   RxList<VetLocationModelDataVetLocations?> vetLocationsList = RxList<VetLocationModelDataVetLocations?>();
//   RxList<HorseHotelModelDataHotels?> horseHotelList = RxList<HorseHotelModelDataHotels?>();
//   RxList<PlannedEventsModelData?> plannedEventsList = RxList<PlannedEventsModelData?>();
//   RxList<CalendarEventsModelData?> CalendarEventsList = RxList<CalendarEventsModelData?>();
//   RxList<CalendarEventsSpecificDateModelData?> CalendarEventsSpecificDateList = RxList<CalendarEventsSpecificDateModelData?>();
//   RxList<CalendarEventData<Object?>> eventList = <CalendarEventData<Object?>>[].obs;
//   Rx<CalendarEventsSpecificDateModelData?> CalendarEventsSpecificDateDetail = CalendarEventsSpecificDateModelData().obs;
//   RxList<VehiclesMaintenanceModelDataAllVechicleMaintainces?> vehicleMaintenanceList = RxList<VehiclesMaintenanceModelDataAllVechicleMaintainces?>();
//   RxList<TrailerMaintenanceModelDataTrailersMaintenance?> trailerMaintenanceList = RxList<TrailerMaintenanceModelDataTrailersMaintenance?>();
//   RxString totalAmount = "0".obs;
//   RxString totalEarningAmount = "0".obs;
//   RxString totalAmountTrailer = "0".obs;
//   RxString rodeoGraphAmount = "50".obs;
//   RxString horseGraphAmount = "50".obs;
//   RxString totalAmountTruck = "0".obs;
//   RxString totalUserExpenseAmount = "0".obs;
//   RxString totalHorseExpenseAmount = "0".obs;
//   RxString totalRodeosExpenseAmount = "0".obs;
//   RxList<TireReplacementModelDataTireReplacements?> tireReplacementList = RxList<TireReplacementModelDataTireReplacements?>();
//   RxList<TackModelDataTrackExpenses?> tackList = RxList<TackModelDataTrackExpenses?>();
//   RxList<PerformanceClothingModelDataPerformanceClothingExpenses?> performanceClothingList =
//       RxList<PerformanceClothingModelDataPerformanceClothingExpenses?>();
//   RxList<TrailerInsuranceModelDataTrailerInsuranceExpenses?> trailerInsuranceList = RxList<TrailerInsuranceModelDataTrailerInsuranceExpenses?>();
//   RxList<GasModelDataGasExpenses?> gasList = RxList<GasModelDataGasExpenses?>();
//   RxList<TravelPartnerInfoModelDataTravelInfoList?> travelPartnerInfoList = RxList<TravelPartnerInfoModelDataTravelInfoList?>();
//   RxList<AssociationMembershipModelDataUserMemberAssociationExpenses?> associationMembershipList =
//       RxList<AssociationMembershipModelDataUserMemberAssociationExpenses?>();
//   RxList<TruckInsuranceModelDataTruckInsuranceExpenses?> truckInsuranceList = RxList<TruckInsuranceModelDataTruckInsuranceExpenses?>();
//   RxList<SupplementsModelDataSupplementExpenses?> supplementsList = RxList<SupplementsModelDataSupplementExpenses?>();
//   RxList<MedicationsDeliverySystemModelDataMedicationDeliveryExpenses?> medicationsDeliverySystemList =
//       RxList<MedicationsDeliverySystemModelDataMedicationDeliveryExpenses?>();
//   RxList<HorseInsuranceModelDataHorseInsuranceExpenses?> horseInsuranceList = RxList<HorseInsuranceModelDataHorseInsuranceExpenses?>();
//   RxList<FeedsModelDataFeedExpenses?> feedsList = RxList<FeedsModelDataFeedExpenses?>();
//   RxList<BeddingModelDataBeddingExpenses?> beddingList = RxList<BeddingModelDataBeddingExpenses?>();
//   RxList<VeterinaryTreatmentsModelDataVeterinaryTreatmentExpenses?> veterinaryTreatmentsList =
//       RxList<VeterinaryTreatmentsModelDataVeterinaryTreatmentExpenses?>();
//   RxList<EarningAssociationModelDataEarningAssociations?> earningAssociationList = RxList<EarningAssociationModelDataEarningAssociations?>();
//   RxList<EarningModelDataEarnings?> earningList = RxList<EarningModelDataEarnings?>();
//   RxList<FarrierInfoModelDataFarriersInfo?> farrierInfoList = RxList<FarrierInfoModelDataFarriersInfo?>();
//   var plannedEventSelectedDate = DateTime.now().obs;
//   RxList<ShoeingRecordsModelDataFarrierExpenses?> shoeingRecordsList = RxList<ShoeingRecordsModelDataFarrierExpenses?>();
//   RxList<GeneralMaintenanceModelDataGeneralMaintenanceDetails?> generalMaintenanceList =
//       RxList<GeneralMaintenanceModelDataGeneralMaintenanceDetails?>();
//   RxList<GeneralMaintenanceExpenseModelDataGeneralMaintenanceExpenses?> generalMaintenanceExpenseList =
//       RxList<GeneralMaintenanceExpenseModelDataGeneralMaintenanceExpenses?>();
//   Rx<RodeoAddModel?> rodeoAddData = RodeoAddModel().obs;
//   Rx<DrawModel?> drawData = DrawModel().obs;
//   Rx<ArenaModel?> arenaData = ArenaModel().obs;
//   Rx<WiningModel?> winingData = WiningModel().obs;
//   Rx<RodeoDetailsModel?> rodeoDetailsData = RodeoDetailsModel().obs;

//   RxList<RodeosModelData?> rodeosList = RxList<RodeosModelData?>();
//   RxList<StallBoardingModelDataStallsBoardingExpenses?> stallBoardingList = RxList<StallBoardingModelDataStallsBoardingExpenses?>();
//   RxList<MealsModelDataMealExpenses?> mealList = RxList<MealsModelDataMealExpenses?>();
//   RxList<LodgingModelDataLodgingExpenses?> lodgingList = RxList<LodgingModelDataLodgingExpenses?>();
//   RxList<EntryFeesModelDataEntryFeesExpenses?> entryFeesList = RxList<EntryFeesModelDataEntryFeesExpenses?>();
//   RxList<BeddingRodeosModelDataBeddingExpenses?> beddingRodeosList = RxList<BeddingRodeosModelDataBeddingExpenses?>();
//   RxList<EarningRodeoAssociationModelDataRodeoAssociations?> earningRodeosAssociationList =
//       RxList<EarningRodeoAssociationModelDataRodeoAssociations?>();
//   RxList<EarningRodeoModelDataRodeoEarnings?> earningRodeosList = RxList<EarningRodeoModelDataRodeoEarnings?>();
//   RxList<NotificationModelDataNotifications?> notificationList = RxList<NotificationModelDataNotifications?>();
//   RxInt unReadNotificationCount = 0.obs;
//   RxInt? throughNotificationId = 0.obs;
//   RxString? throughNotificationDate = "".obs;
//   RxBool? isThroughNotificationDate = false.obs;
//   RxInt jumptoIndex = 0.obs;
//   RxList<WinningHorseModelData?> winningHorseList = RxList<WinningHorseModelData?>();

//   RxList<ChartData> horseEarningchartData = [
//     ChartData('Jan', 0),
//     ChartData('Feb', 0),
//     ChartData('Mar', 0),
//     ChartData('Apr', 0),
//     ChartData('May', 0),
//     ChartData('Jun', 0),
//     ChartData('Jul', 1),
//     ChartData('Aug', 0),
//     ChartData('Sep', 0),
//     ChartData('Oct', 0),
//     ChartData('Nov', 0),
//     ChartData('Dec', 0)
//   ].obs;
//   RxList<ChartData> rodeosEarningchartData = [
//     ChartData('Jan', 0),
//     ChartData('Feb', 0),
//     ChartData('Mar', 0),
//     ChartData('Apr', 0),
//     ChartData('May', 0),
//     ChartData('Jun', 1),
//     ChartData('Jul', 0),
//     ChartData('Aug', 0),
//     ChartData('Sep', 0),
//     ChartData('Oct', 0),
//     ChartData('Nov', 0),
//     ChartData('Dec', 0)
//   ].obs;

//   List<ChartData> parseChartData(GraphModelData graphData) {
//     return [
//       ChartData('Jan', graphData.January?.toDouble() ?? 0),
//       ChartData('Feb', graphData.February?.toDouble() ?? 0),
//       ChartData('Mar', graphData.March?.toDouble() ?? 0),
//       ChartData('Apr', graphData.April?.toDouble() ?? 0),
//       ChartData('May', graphData.May?.toDouble() ?? 0),
//       ChartData('Jun', graphData.June?.toDouble() ?? 0),
//       ChartData('Jul', graphData.July?.toDouble() ?? 0),
//       ChartData('Aug', graphData.August ?? 0),
//       ChartData('Sep', graphData.September?.toDouble() ?? 0),
//       ChartData('Oct', graphData.October?.toDouble() ?? 0),
//       ChartData('Nov', graphData.November?.toDouble() ?? 0),
//       ChartData('Dec', graphData.December?.toDouble() ?? 0),
//     ];
//   }

//   RxList<Map<String, dynamic>> sections = <Map<String, dynamic>>[].obs;

//   /////-------------------Get API Loader-----------------/////
//   // RxBool totalUserExpenseAmount = false.obs;
//   // RxBool totalHorseExpenseAmount = false.obs;
//   // RxBool totalRodeosExpenseAmount = false.obs;
//   RxBool loaderApi = false.obs;
//   RxBool myNotesApi = false.obs;
//   RxBool otherServicesApi = false.obs;
//   RxBool vetLocationsApi = false.obs;
//   RxBool horseHotelApi = false.obs;
//   RxBool plannedEventsApi = false.obs;
//   RxBool calendarEventsApi = false.obs;
//   RxBool calendarEventsSpecificDateApi = false.obs;
//   EventController<Object?> controller = EventController();
//   RxBool vehicleTrailerMaintenanceApi = false.obs;
//   RxBool totalApi = false.obs;
//   RxBool tireReplacementApi = false.obs;
//   RxBool tackApi = false.obs;
//   RxBool performanceClothingApi = false.obs;
//   RxBool trailerInsuranceApi = false.obs;
//   RxBool gasApi = false.obs;
//   RxBool travelPartnerInfoApi = false.obs;
//   RxBool associationMembershipApi = false.obs;
//   RxBool truckInsuranceApi = false.obs;
//   RxBool supplementsApi = false.obs;
//   RxBool medicationsDeliverySystemApi = false.obs;
//   RxBool horseInsuranceApi = false.obs;
//   RxBool feedsApi = false.obs;
//   RxBool beddingApi = false.obs;
//   RxBool veterinaryTreatmentsApi = false.obs;
//   RxBool earningAssociationApi = false.obs;
//   RxBool earningApi = false.obs;
//   RxBool farrierInfoApi = false.obs;
//   RxBool shoeingRecordsApi = false.obs;
//   RxBool generalMaintenanceApi = false.obs;
//   RxBool generalMaintenanceExpenseApi = false.obs;
//   RxBool rodeosApi = false.obs;
//   RxBool detailApi = false.obs;
//   RxBool stallBoardingApi = false.obs;
//   RxBool mealApi = false.obs;
//   RxBool lodgingApi = false.obs;
//   RxBool entryFeesApi = false.obs;
//   RxBool beddingRodeosApi = false.obs;
//   RxBool earningRodeosApi = false.obs;
//   RxBool earningRodeosAssociationApi = false.obs;
//   RxBool allExpensesApi = false.obs;
//   RxBool filter = false.obs;
//   RxBool notificationApi = false.obs;

//   /////-------------------Get API Loader-----------------/////

//   ///---------------------------pagination-------------------////
//   RxInt page = 1.obs;

//   ///---------------------------pagination-------------------////

// //-------------------------------Home--------------------------------
//   void adds() async {
//     GetAddsRepository().addsRepo();
//   }

//   void addsView({required int adsId}) async {
//     AddsViewRepository().addsViewRepo(adsId: adsId);
//   }

//   Future<void> horseGraph({String? id, String? name, bool? loader}) async {
//     await GetHorseGraphRepository().horseGraphRepo(id: id, name: name, loader: loader);
//   }

//   void rodeosGraph() async {
//     GetRodeosGraphRepository().rodeosGraphRepo();
//   }

//   void totalExpense() async {
//     GetTotalExpenseRepository().totalExpenseRepo();
//   }

//   void totalEarningHome() async {
//     GetTotalEarningHomeRepository().totalEarningRepo();
//   }

//   void allExpenses(context, {required bool isFilter, int? horseId, String? startDate, String? endDate}) async {
//     GetAllExpensesRepository().allExpensesRepo(context, isFilter: isFilter, endDate: endDate, horseId: horseId, startDate: startDate);
//   }

// //-------------------------------My Notes--------------------------------
//   void addEditMyNotes(
//     dynamic context, {
//     int? notesId,
//     int? index,
//     String? title,
//     String? description,
//   }) {
//     AddEditMyNotesRepository().addEditMyNotesRepo(context, title: title, description: description, index: index, notesId: notesId);
//   }

//   Future<void> myNotes({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetMyNotesRepository().myNotesRepo(loader: loader, offset: offset, searchText: searchText, isAfterSearch: isAfterSearch, isSearch: isSearch);
//   }

//   void deleteMyNotes(
//     dynamic context, {
//     int? notesId,
//     bool? single,
//   }) {
//     DeleteMyNotesRepository().deleteMyNotesRepo(context, single: single, notesId: notesId);
//   }

// //-------------------------------Other Services--------------------------------
//   void addEditOtherServices(
//     dynamic context, {
//     int? otherServicesId,
//     int? index,
//     String? name,
//     String? email,
//     String? phone,
//     String? countryCode,
//     String? dialCode,
//     String? address,
//     String? country,
//     String? state,
//     String? city,
//     String? cost,
//   }) {
//     AddEditOtherServicesRepository().addEditOtherServicesRepo(context,
//         index: index,
//         otherServicesId: otherServicesId,
//         address: address,
//         city: city,
//         country: country,
//         countryCode: countryCode,
//         dialCode: dialCode,
//         email: email,
//         name: name,
//         phone: phone,
//         state: state,
//         cost: cost);
//   }

//   Future<void> otherServices({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     String? state,
//     String? city,
//     required bool? isFilter,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetOtherServicesRepository().otherServicesRepo(
//         loader: loader,
//         offset: offset,
//         isAfterSearch: isAfterSearch,
//         searchText: searchText,
//         state: state,
//         city: city,
//         isFilter: isFilter,
//         isSearch: isSearch);
//   }

//   void deleteOtherServices(
//     dynamic context, {
//     int? otherServicesId,
//     // bool? single,
//   }) {
//     DeleteOtherServicesRepository().deleteOtherServicesRepo(context, otherServicesId: otherServicesId);
//   }

// //-------------------------------Vet Locations--------------------------------
//   void addEditVetLocations(
//     dynamic context, {
//     int? vetLocationsId,
//     int? index,
//     String? clinic,
//     String? veterinarian,
//     String? phone,
//     String? countryCode,
//     String? dialCode,
//     String? country,
//     String? address,
//     String? state,
//     String? city,
//   }) {
//     AddEditVetLocationsRepository().addEditVetLocationsRepo(
//       context,
//       index: index,
//       vetLocationsId: vetLocationsId,
//       clinic: clinic,
//       veterinarian: veterinarian,
//       city: city,
//       country: country,
//       address: address,
//       countryCode: countryCode,
//       dialCode: dialCode,
//       phone: phone,
//       state: state,
//     );
//   }

//   Future<void> vetLocations({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//     String? state,
//     String? city,
//     required bool? isFilter,
//   }) async {
//     GetVetLocationsRepository().vetLocationsRepo(
//         loader: loader,
//         offset: offset,
//         searchText: searchText,
//         isAfterSearch: isAfterSearch,
//         state: state,
//         city: city,
//         isFilter: isFilter,
//         isSearch: isSearch);
//   }

//   void deleteVetLocations(
//     dynamic context, {
//     int? vetLocationsId,
//     // bool? single,
//   }) {
//     DeleteVetLocationsRepository().deleteVetLocationsRepo(context, vetLocationsId: vetLocationsId);
//   }

// //-------------------------------Horse Hotel--------------------------------
//   void addEditHoreseHotel(
//     dynamic context, {
//     int? horseHotelId,
//     int? index,
//     String? name,
//     String? email,
//     String? address,
//     String? state,
//     String? city,
//     String? phone,
//     String? countryCode,
//     String? dialCode,
//     String? rvCost,
//     String? rvHookUp,
//     String? stallCost,
//   }) {
//     AddEditHoreseHotelRepository().addEditHoreseHotelRepo(
//       context,
//       index: index,
//       horseHotelId: horseHotelId,
//       name: name,
//       email: email,
//       address: address,
//       city: city,
//       state: state,
//       rvCost: rvCost,
//       rvHookUp: rvHookUp,
//       countryCode: countryCode,
//       dialCode: dialCode,
//       phone: phone,
//       stallCost: stallCost,
//     );
//   }

//   Future<void> horseHotel({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//     String? state,
//     String? city,
//     required bool? isFilter,
//   }) async {
//     GetHoreseHotelRepository().horeseHotelRepo(
//         loader: loader,
//         offset: offset,
//         isAfterSearch: isAfterSearch,
//         searchText: searchText,
//         state: state,
//         city: city,
//         isFilter: isFilter,
//         isSearch: isSearch);
//   }

//   void deleteHoreseHotel(
//     dynamic context, {
//     int? HorseHotelId,
//     // bool? single,
//   }) {
//     DeleteHoreseHotelRepository().deleteHoreseHotelRepo(context, horseHotelId: HorseHotelId);
//   }

// //-------------------------------Help and Feedback--------------------------------
//   void helpFeedback(
//     dynamic context, {
//     String? subject,
//     String? message,
//     List<File>? media,
//   }) {
//     HelpFeedbackRepository().helpFeedbackRepo(context, media: media, message: message, subject: subject);
//   }

// //-------------------------------Planned Events--------------------------------
//   void addEditPlannedEvents(
//     dynamic context, {
//     int? plannedEventsId,
//     int? index,
//     String? date,
//     String? calendarDate,
//     String? title,
//     String? description,
//   }) {
//     AddEditPlannedEventsRepository().addEditPlannedEventsRepo(context,
//         index: index, plannedEventsId: plannedEventsId, date: date, calendarDate: calendarDate, description: description, title: title);
//   }

//   void plannedEvents({String? date}) async {
//     GetPlannedEventsRepository().plannedEventsRepo(date: date);
//   }

//   void deletePlannedEvents(
//     dynamic context, {
//     int? plannedEventsId,
//     // bool? single,
//   }) {
//     DeletePlannedEventsRepository().deletePlannedEventsRepo(context, plannedEventsId: plannedEventsId);
//   }

// //-------------------------------Calendar event--------------------------------
//   void addEditCalendarEvents(
//     dynamic context, {
//     int? calendarEventsId,
//     int? index,
//     String? date,
//     String? localDate,
//     String? oldDate,
//     String? title,
//     String? description,
//     String? startTime,
//     String? endTime,
//     String? address,
//   }) {
//     AddEditCalendarEventsRepository().addEditCalendarEventsRepo(context,
//         index: index,
//         calendarEventsId: calendarEventsId,
//         date: date,
//         localDate: localDate,
//         oldDate: oldDate,
//         description: description,
//         title: title,
//         address: address,
//         endTime: endTime,
//         startTime: startTime);
//   }

//   void calendarEvents({String? month, String? year}) async {
//     GetCalendarEventsRepository().calendarEventsRepo(month: month, year: year);
//   }

//   Future<void> SpecificCalendarEventsByDate({String? date}) async {
//     await GetSpecificCalendarEventsByDateRepository().SpecificCalendarEventsByDateRepo(date: date);
//   }

//   // void deletePlannedEvents(
//   //   dynamic context, {
//   //   int? plannedEventsId,
//   //   // bool? single,
//   // }) {
//   //   DeletePlannedEventsRepository()
//   //       .deletePlannedEventsRepo(context, plannedEventsId: plannedEventsId);
//   // }

// //-------------------------------Vehicle and Trailer Maintenance--------------------------------
//   void addEditVehicleTrailerMaintenance(
//     dynamic context, {
//     required String maintenanceType,
//     int? vehicleMaintenanceId,
//     int? index,
//     String? date,
//     String? cost,
//     String? mileage,
//     String? repair,
//   }) {
//     AddEditVehicleTrailerMaintenanceRepository().addEditVehicleTrailerMaintenanceRepo(
//       context,
//       index: index,
//       vehicleTrailerMaintenanceId: vehicleMaintenanceId,
//       cost: cost,
//       date: date,
//       mileage: mileage,
//       repair: repair,
//       maintenanceType: maintenanceType,
//     );
//   }

//   Future<void> totalVehicleTrailerMaintenance({
//     required String maintenanceType,
//   }) async {
//     GetTotalVehicleTrailerMaintenanceRepository().totalVehicleTrailerMaintenanceRepo(maintenanceType: maintenanceType);
//   }

//   Future<void> vehicleTrailerMaintenance({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//     required String maintenanceType,
//   }) async {
//     GetVehicleTrailerMaintenanceRepository().vehicleTrailerMaintenanceRepo(
//       loader: loader,
//       offset: offset,
//       searchText: searchText,
//       isSearch: isSearch,
//       isAfterSearch: isAfterSearch,
//       maintenanceType: maintenanceType,
//     );
//   }

//   void deleteVehicleTrailerMaintenance(
//     dynamic context, {
//     int? vehicleMaintenanceId,
//     required String maintenanceType,
//   }) {
//     DeleteVehicleTrailerMaintenanceRepository().deleteVehicleTrailerMaintenanceRepo(
//       context,
//       vehicleTrailerMaintenanceId: vehicleMaintenanceId,
//       maintenanceType: maintenanceType,
//     );
//   }

// //-------------------------------Tire Replacement-------------------------------
//   void addEditTireReplacement(
//     dynamic context, {
//     required String tireReplacementType,
//     int? tireReplacementId,
//     int? index,
//     String? date,
//     String? cost,
//     String? mileage,
//     String? brand,
//   }) {
//     AddEditTireReplacementRepository().addEditTireReplacementRepo(
//       context,
//       index: index,
//       tireReplacementId: tireReplacementId,
//       cost: cost,
//       date: date,
//       mileage: mileage,
//       brand: brand,
//       tireReplacementType: tireReplacementType,
//     );
//   }

//   void totalTireReplacement() async {
//     GetTotalTireReplacementRepository().totalTireReplacementRepo();
//   }

//   Future<void> tireReplacement({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required String tireReplacementType,
//     required bool? isAfterSearch,
//   }) async {
//     GetTireReplacementRepository().tireReplacementRepo(
//       loader: loader,
//       offset: offset,
//       searchText: searchText,
//       isAfterSearch: isAfterSearch,
//       isSearch: isSearch,
//       tireReplacementType: tireReplacementType,
//     );
//   }

//   void deleteTireReplacement(
//     dynamic context, {
//     int? tireReplacementId,
//     required String tireReplacementType,
//   }) {
//     DeleteTireReplacementRepository().deleteTireReplacementRepo(
//       context,
//       tireReplacementId: tireReplacementId,
//       tireReplacementType: tireReplacementType,
//     );
//   }

// //-------------------------------Tack-------------------------------
//   void addEditTack(
//     dynamic context, {
//     int? tackId,
//     int? index,
//     String? date,
//     String? cost,
//     String? item,
//   }) {
//     AddEditTackRepository().addEditTackRepo(
//       context,
//       index: index,
//       tackId: tackId,
//       cost: cost,
//       date: date,
//       item: item,
//     );
//   }

//   void totalTack() async {
//     GetTotalTackRepository().totalTackRepo();
//   }

//   Future<void> tack({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetTackRepository().tackRepo(
//       loader: loader,
//       offset: offset,
//       searchText: searchText,
//       isAfterSearch: isAfterSearch,
//       isSearch: isSearch,
//     );
//   }

//   void deleteTack(
//     dynamic context, {
//     int? tackId,
//   }) {
//     DeleteTackRepository().deleteTackRepo(
//       context,
//       tackId: tackId,
//     );
//   }

// //-------------------------------Performance Clothing-------------------------------
//   void addEditPerformanceClothing(
//     dynamic context, {
//     int? performanceClothingId,
//     int? index,
//     String? date,
//     String? cost,
//     String? item,
//     String? purchasedAt,
//   }) {
//     AddEditPerformanceClothingRepository().addEditPerformanceClothingRepo(
//       context,
//       index: index,
//       performanceClothingId: performanceClothingId,
//       cost: cost,
//       date: date,
//       item: item,
//       purchasedAt: purchasedAt,
//     );
//   }

//   void totalPerformanceClothing() async {
//     GetTotalPerformanceClothingRepository().totalPerformanceClothingRepo();
//   }

//   Future<void> performanceClothing({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetPerformanceClothingRepository().performanceClothingRepo(
//       loader: loader,
//       offset: offset,
//       searchText: searchText,
//       isAfterSearch: isAfterSearch,
//       isSearch: isSearch,
//     );
//   }

//   void deletePerformanceClothing(
//     dynamic context, {
//     int? performanceClothingId,
//   }) {
//     DeletePerformanceClothingRepository().deletePerformanceClothingRepo(
//       context,
//       performanceClothingId: performanceClothingId,
//     );
//   }

// //-------------------------------Trailer Insurance-------------------------------
//   void addEditTrailerInsurance(
//     dynamic context, {
//     int? trailerInsuranceId,
//     int? index,
//     String? date,
//     String? cost,
//     String? trailer,
//     String? companyName,
//     String? policyStartDate,
//     String? policyEndDate,
//   }) {
//     AddEditTrailerInsuranceRepository().addEditTrailerInsuranceRepo(
//       context,
//       index: index,
//       trailerInsuranceId: trailerInsuranceId,
//       cost: cost,
//       date: date,
//       trailer: trailer,
//       companyName: companyName,
//       policyStartDate: policyStartDate,
//       policyEndDate: policyEndDate,
//     );
//   }

//   void totalTrailerInsurance() async {
//     GetTotalTrailerInsuranceRepository().totalTrailerInsuranceRepo();
//   }

//   Future<void> trailerInsurance({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetTrailerInsuranceRepository().trailerInsuranceRepo(
//       loader: loader,
//       offset: offset,
//       searchText: searchText,
//       isAfterSearch: isAfterSearch,
//       isSearch: isSearch,
//     );
//   }

//   void deleteTrailerInsurance(
//     dynamic context, {
//     int? trailerInsuranceId,
//   }) {
//     DeleteTrailerInsuranceRepository().deleteTrailerInsuranceRepo(
//       context,
//       trailerInsuranceId: trailerInsuranceId,
//     );
//   }

// //-------------------------------Gas-------------------------------
//   void addEditGas(
//     dynamic context, {
//     int? gasId,
//     int? index,
//     String? date,
//     String? cost,
//     String? miles,
//     String? location,
//   }) {
//     AddEditGasRepository().addEditGasRepo(
//       context,
//       index: index,
//       gasId: gasId,
//       cost: cost,
//       date: date,
//       location: location,
//       miles: miles,
//     );
//   }

//   void totalGas() async {
//     GetTotalGasRepository().totalGasRepo();
//   }

//   Future<void> gas({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetGasRepository().gasRepo(
//       loader: loader,
//       offset: offset,
//       searchText: searchText,
//       isAfterSearch: isAfterSearch,
//       isSearch: isSearch,
//     );
//   }

//   void deleteGas(
//     dynamic context, {
//     int? gasId,
//   }) {
//     DeleteGasRepository().deleteGasRepo(
//       context,
//       gasId: gasId,
//     );
//   }

//   //----------------------------Travel Partner Info--------------------------------
//   void addEditTravelPartnerInfo(
//     dynamic context, {
//     int? travelPartnerInfoId,
//     int? index,
//     String? name,
//     String? emergencyContactName,
//     String? email,
//     String? phone,
//     String? countryCode,
//     String? dialCode,
//     String? emergencyContact,
//     String? emergencyCountryCode,
//     String? emergencyDialCode,
//     String? membershipNumber,
//   }) {
//     AddEditTravelPartnerInfoRepository().addEditTravelPartnerInfoRepo(context,
//         index: index,
//         travelPartnerInfoId: travelPartnerInfoId,
//         name: name,
//         emergencyContactName: emergencyContactName,
//         email: email,
//         emergencyDialCode: emergencyDialCode,
//         emergencyContact: emergencyContact,
//         countryCode: countryCode,
//         dialCode: dialCode,
//         phone: phone,
//         emergencyCountryCode: emergencyCountryCode,
//         membershipNumber: membershipNumber);
//   }

//   Future<void> travelPartnerInfo({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetTravelPartnerInfoRepository()
//         .travelPartnerInfoRepo(loader: loader, offset: offset, searchText: searchText, isAfterSearch: isAfterSearch, isSearch: isSearch);
//   }

//   void deleteTravelPartnerInfo(
//     dynamic context, {
//     int? travelPartnerInfoId,
//     // bool? single,
//   }) {
//     DeleteTravelPartnerInfoRepository().deleteTravelPartnerInfoRepo(context, travelPartnerInfoId: travelPartnerInfoId);
//   }

// //-------------------------------Gas-------------------------------
//   void addEditAssociationMembership(
//     dynamic context, {
//     int? associationMembershipId,
//     int? index,
//     String? association,
//     String? cost,
//     String? phoneNumber,
//     String? dialCode,
//     String? countryCode,
//     String? membershipNumber,
//   }) {
//     AddEditAssociationMembershipRepository().addEditAssociationMembershipRepo(context,
//         index: index,
//         associationMembershipId: associationMembershipId,
//         cost: cost,
//         membershipNumber: membershipNumber,
//         association: association,
//         countryCode: countryCode,
//         dialCode: dialCode,
//         phoneNumber: phoneNumber);
//   }

//   void totalAssociationMembership() async {
//     GetTotalAssociationMembershipRepository().totalAssociationMembershipRepo();
//   }

//   Future<void> associationMembership({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetAssociationMembershipRepository().associationMembershipRepo(
//       loader: loader,
//       offset: offset,
//       searchText: searchText,
//       isSearch: isSearch,
//       isAfterSearch: isAfterSearch,
//     );
//   }

//   void deleteAssociationMembership(
//     dynamic context, {
//     int? associationMembershipId,
//   }) {
//     DeleteAssociationMembershipRepository().deleteAssociationMembershipRepo(
//       context,
//       associationMembershipId: associationMembershipId,
//     );
//   }

//   //-------------------------------Truck Insurance-------------------------------
//   void addEditTruckInsurance(
//     dynamic context, {
//     int? truckInsuranceId,
//     int? index,
//     String? date,
//     String? cost,
//     String? truck,
//     String? companyName,
//     String? policyStartDate,
//     String? policyEndDate,
//   }) {
//     AddEditTruckInsuranceRepository().addEditTruckInsuranceRepo(
//       context,
//       index: index,
//       truckInsuranceId: truckInsuranceId,
//       cost: cost,
//       date: date,
//       truck: truck,
//       companyName: companyName,
//       policyStartDate: policyStartDate,
//       policyEndDate: policyEndDate,
//     );
//   }

//   void totalTruckInsurance() async {
//     GetTotalTruckInsuranceRepository().totalTruckInsuranceRepo();
//   }

//   Future<void> truckInsurance({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetTruckInsuranceRepository().truckInsuranceRepo(
//       loader: loader,
//       offset: offset,
//       searchText: searchText,
//       isAfterSearch: isAfterSearch,
//       isSearch: isSearch,
//     );
//   }

//   void deleteTruckInsurance(
//     dynamic context, {
//     int? truckInsuranceId,
//   }) {
//     DeleteTruckInsuranceRepository().deleteTruckInsuranceRepo(
//       context,
//       truckInsuranceId: truckInsuranceId,
//     );
//   }

// //-------------------------------Supplemants-------------------------------
//   void addEditSupplemants(
//     dynamic context, {
//     int? supplemantsId,
//     required int horseId,
//     int? index,
//     String? date,
//     String? cost,
//     String? item,
//     String? purchasedAt,
//   }) {
//     AddEditSupplemantsRepository().addEditSupplemantsRepo(
//       context,
//       index: index,
//       supplemantsId: supplemantsId,
//       horseId: horseId,
//       cost: cost,
//       date: date,
//       item: item,
//       purchasedAt: purchasedAt,
//     );
//   }

//   void totalSupplements({required int horseId}) async {
//     GetTotalSupplemantsRepository().totalSupplemantsRepo(horseId: horseId);
//   }

//   Future<void> supplements({
//     int? offset,
//     bool? loader,
//     required int horseId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetSupplemantsRepository()
//         .supplemantsRepo(loader: loader, offset: offset, searchText: searchText, isAfterSearch: isAfterSearch, isSearch: isSearch, horseId: horseId);
//   }

//   void deleteSupplements(
//     dynamic context, {
//     int? supplemantsId,
//     required int horseId,
//   }) {
//     DeleteSupplemantsRepository().deleteSupplemantsRepo(context, supplemantsId: supplemantsId, horseId: horseId);
//   }

// //-------------------------------Medications Delivery System-------------------------------
//   void addEditMedicationsDeliverySystem(
//     dynamic context, {
//     int? medicationsDeliverySystemId,
//     required int horseId,
//     int? index,
//     String? date,
//     String? cost,
//     String? item,
//     String? purchasedAt,
//   }) {
//     AddEditMedicationsDeliverySystemRepository().addEditMedicationsDeliverySystemRepo(
//       context,
//       index: index,
//       medicationsDeliverySystemId: medicationsDeliverySystemId,
//       horseId: horseId,
//       cost: cost,
//       date: date,
//       item: item,
//       purchasedAt: purchasedAt,
//     );
//   }

//   void totalMedicationsDeliverySystem({required int horseId}) async {
//     GetTotalMedicationsDeliverySystemRepository().totalMedicationsDeliverySystemRepo(horseId: horseId);
//   }

//   Future<void> medicationsDeliverySystem({
//     int? offset,
//     bool? loader,
//     required int horseId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetMedicationsDeliverySystemRepository().medicationsDeliverySystemRepo(
//         loader: loader, offset: offset, searchText: searchText, isAfterSearch: isAfterSearch, isSearch: isSearch, horseId: horseId);
//   }

//   void deleteMedicationsDeliverySystem(
//     dynamic context, {
//     int? medicationsDeliverySystemId,
//     required int horseId,
//   }) {
//     DeleteMedicationsDeliverySystemRepository()
//         .deleteMedicationsDeliverySystemRepo(context, medicationsDeliverySystemId: medicationsDeliverySystemId, horseId: horseId);
//   }

// //-------------------------------Horse Insurance-------------------------------
//   void addEditHorseInsurance(
//     dynamic context, {
//     int? horseInsuranceId,
//     required int horseId,
//     int? index,
//     String? date,
//     String? cost,
//     String? policyStartDate,
//     String? policyEndDate,
//     String? companyName,
//   }) {
//     AddEditHorseInsuranceRepository().addEditHorseInsuranceRepo(
//       context,
//       index: index,
//       horseInsuranceId: horseInsuranceId,
//       horseId: horseId,
//       cost: cost,
//       date: date,
//       companyName: companyName,
//       policyStartDate: policyStartDate,
//       policyEndDate: policyEndDate,
//     );
//   }

//   void totalHorseInsurance({required int horseId}) async {
//     GetTotalHorseInsuranceRepository().totalHorseInsuranceRepo(horseId: horseId);
//   }

//   Future<void> horseInsurance({
//     int? offset,
//     bool? loader,
//     required int horseId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetHorseInsuranceRepository().horseInsuranceRepo(
//         loader: loader, offset: offset, searchText: searchText, isAfterSearch: isAfterSearch, isSearch: isSearch, horseId: horseId);
//   }

//   void deleteHorseInsurance(
//     dynamic context, {
//     int? horseInsuranceId,
//     required int horseId,
//   }) {
//     DeleteHorseInsuranceRepository().deleteHorseInsuranceRepo(context, horseInsuranceId: horseInsuranceId, horseId: horseId);
//   }

// //-------------------------------Feeds-------------------------------
//   void addEditFeeds(
//     dynamic context, {
//     int? feedsId,
//     required int horseId,
//     int? index,
//     String? date,
//     String? cost,
//     String? item,
//     // String? companyName,
//   }) {
//     AddEditFeedsRepository().addEditFeedsRepo(
//       context,
//       index: index,
//       feedsId: feedsId,
//       horseId: horseId,
//       cost: cost,
//       date: date,
//       item: item,
//     );
//   }

//   void totalFeeds({required int horseId}) async {
//     GetTotalFeedsRepository().totalFeedsRepo(horseId: horseId);
//   }

//   Future<void> feeds({
//     int? offset,
//     bool? loader,
//     required int horseId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetFeedsRepository()
//         .feedsRepo(loader: loader, offset: offset, searchText: searchText, isAfterSearch: isAfterSearch, isSearch: isSearch, horseId: horseId);
//   }

//   void deleteFeeds(
//     dynamic context, {
//     int? feedsId,
//     required int horseId,
//   }) {
//     DeleteFeedsRepository().deleteFeedsRepo(context, feedsId: feedsId, horseId: horseId);
//   }

// //-------------------------------Bedding-------------------------------
//   void addEditBedding(
//     dynamic context, {
//     int? beddingId,
//     required int horseId,
//     int? index,
//     String? date,
//     String? cost,
//     String? location,
//     // String? companyName,
//   }) {
//     AddEditBeddingRepository().addEditBeddingRepo(
//       context,
//       index: index,
//       beddingId: beddingId,
//       horseId: horseId,
//       cost: cost,
//       date: date,
//       location: location,
//     );
//   }

//   void totalBedding({required int horseId}) async {
//     GetTotalBeddingRepository().totalBeddingRepo(horseId: horseId);
//   }

//   Future<void> bedding({
//     int? offset,
//     bool? loader,
//     required int horseId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetBeddingRepository()
//         .beddingRepo(loader: loader, offset: offset, searchText: searchText, isSearch: isSearch, isAfterSearch: isAfterSearch, horseId: horseId);
//   }

//   void deleteBedding(
//     dynamic context, {
//     int? beddingId,
//     required int horseId,
//   }) {
//     DeleteBeddingRepository().deleteBeddingRepo(context, beddingId: beddingId, horseId: horseId);
//   }

// //-------------------------------Veterinary Treatments-------------------------------
//   void addEditVeterinaryTreatments(
//     dynamic context, {
//     int? veterinaryTreatmentsId,
//     required int horseId,
//     int? index,
//     String? date,
//     String? cost,
//     String? illness,
//     String? treatmentDetail,
//     bool? treatment,
//     // String? companyName,
//   }) {
//     AddEditVeterinaryTreatmentsRepository().addEditVeterinaryTreatmentsRepo(context,
//         index: index,
//         veterinaryTreatmentsId: veterinaryTreatmentsId,
//         horseId: horseId,
//         cost: cost,
//         date: date,
//         illness: illness,
//         treatment: treatment,
//         treatmentDetail: treatmentDetail);
//   }

//   void totalVeterinaryTreatments({required int horseId}) async {
//     GetTotalVeterinaryTreatmentsRepository().totalVeterinaryTreatmentsRepo(horseId: horseId);
//   }

//   Future<void> veterinaryTreatments({
//     int? offset,
//     bool? loader,
//     required int horseId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetVeterinaryTreatmentsRepository().veterinaryTreatmentsRepo(
//         loader: loader, offset: offset, searchText: searchText, isSearch: isSearch, isAfterSearch: isAfterSearch, horseId: horseId);
//   }

//   void deleteVeterinaryTreatments(
//     dynamic context, {
//     int? veterinaryTreatmentsId,
//     required int horseId,
//   }) {
//     DeleteVeterinaryTreatmentsRepository().deleteVeterinaryTreatmentsRepo(context, veterinaryTreatmentsId: veterinaryTreatmentsId, horseId: horseId);
//   }

// //-------------------------------Earning Association-------------------------------
//   void addEditEarningAssociation(
//     dynamic context, {
//     int? earningAssociationId,
//     required int horseId,
//     int? index,
//     String? name,
//   }) {
//     AddEditEarningAssociationRepository().addEditEarningAssociationRepo(
//       context,
//       index: index,
//       earningAssociationId: earningAssociationId,
//       horseId: horseId,
//       associationName: name,
//     );
//   }

//   void totalEarningAssociation({required int horseId}) async {
//     GetTotalEarningAssociationRepository().totalEarningAssociationRepo(horseId: horseId);
//   }

//   Future<void> earningAssociation({
//     required int horseId,
//   }) async {
//     GetEarningAssociationRepository().earningAssociationRepo(horseId: horseId);
//   }

//   void deleteEarningAssociation(
//     dynamic context, {
//     int? earningAssociationId,
//     required int horseId,
//   }) {
//     DeleteEarningAssociationRepository().deleteEarningAssociationRepo(context, earningAssociationId: earningAssociationId, horseId: horseId);
//   }

//   // void addEditEarning(
//   //   dynamic context, {
//   //   int? earningId,
//   //   required int associationId,
//   //   int? index,
//   //   String? date,
//   //   String? cost,
//   //   String? location,
//   // }) {
//   //   AddEditEarningRepository().addEditEarningRepo(
//   //     context,
//   //     index: index,
//   //     earningId: earningId,
//   //     cost: cost,
//   //     date: date,
//   //     location: location,
//   //     associationId: associationId,
//   //   );
//   // }

//   void totalEarning({required int associationId}) async {
//     GetTotalEarningRepository().totalEarningRepo(associationId: associationId);
//   }

//   Future<void> earning({
//     int? offset,
//     bool? loader,
//     required int associationId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetEarningRepository().earningRepo(
//         loader: loader, offset: offset, searchText: searchText, isSearch: isSearch, isAfterSearch: isAfterSearch, associationId: associationId);
//   }

//   // void deleteEarning(
//   //   dynamic context, {
//   //   int? earningId,
//   //   required int associationId,
//   // }) {
//   //   DeleteEarningRepository().deleteEarningRepo(context,
//   //       earningId: earningId, associationId: associationId);
//   // }

//   //-------------------------------Farrier Info-------------------------------
//   void addEditFarrierInfo(
//     dynamic context, {
//     int? farrierInfoId,
//     required int horseId,
//     int? index,
//     String? farrierName,
//     String? phoneNumber,
//     String? dialCode,
//     String? countryCode,
//     String? shoeSize,
//     String? nailSize,
//     String? nailType,
//     String? shoeingNotes,
//   }) {
//     AddEditFarrierInfoRepository().addEditFarrierInfoRepo(
//       context,
//       index: index,
//       farrierInfoId: farrierInfoId,
//       horseId: horseId,
//       countryCode: countryCode,
//       dialCode: dialCode,
//       farrierName: farrierName,
//       nailSize: nailSize,
//       nailType: nailType,
//       phoneNumber: phoneNumber,
//       shoeSize: shoeSize,
//       shoeingNotes: shoeingNotes,
//     );
//   }

//   void totalFarrierInfo({required int horseId}) async {
//     GetTotalFarrierInfoRepository().totalFarrierInfoRepo(horseId: horseId);
//   }

//   Future<void> farrierInfo({
//     int? offset,
//     bool? loader,
//     required int horseId,
//   }) async {
//     GetFarrierInfoRepository().farrierInfoRepo(loader: loader, offset: offset, horseId: horseId);
//   }

//   void deleteFarrierInfo(
//     dynamic context, {
//     int? farrierInfoId,
//     required int horseId,
//     required bool deleteFromDetail,
//   }) {
//     DeleteFarrierInfoRepository().deleteFarrierInfoRepo(context, farrierInfoId: farrierInfoId, horseId: horseId, deleteFromDetail: deleteFromDetail);
//   }

//   //-------------------------------Shoeing Records-------------------------------
//   void addEditShoeingRecords(
//     dynamic context, {
//     int? shoeingRecordsId,
//     required int farrierInfoId,
//     int? index,
//     String? date,
//     String? cost,
//     String? note,
//   }) {
//     AddEditShoeingRecordsRepository().addEditShoeingRecordsRepo(
//       context,
//       index: index,
//       shoeingRecordsId: shoeingRecordsId,
//       farrierId: farrierInfoId,
//       cost: cost,
//       date: date,
//       note: note,
//     );
//   }

//   void totalShoeingRecords({required int farrierInfoId}) async {
//     GetTotalShoeingRecordsRepository().totalShoeingRecordsRepo(farrierId: farrierInfoId);
//   }

//   Future<void> shoeingRecords({
//     int? offset,
//     bool? loader,
//     String? searchText,
//     int? farrierInfoId,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetShoeingRecordsRepository().shoeingRecordsRepo(
//         loader: loader, offset: offset, farrierId: farrierInfoId, isSearch: isSearch, isAfterSearch: isAfterSearch, searchText: searchText);
//   }

//   void deleteShoeingRecords(
//     dynamic context, {
//     int? shoeingRecordsId,
//     required int farrierInfoId,
//   }) {
//     DeleteShoeingRecordsRepository().deleteShoeingRecordsRepo(
//       context,
//       shoeingRecordsId: shoeingRecordsId,
//       farrierId: farrierInfoId,
//     );
//   }

//   //-------------------------------General Maintenance-------------------------------
//   void addEditGeneralMaintenance(
//     dynamic context, {
//     int? generalMaintenanceId,
//     required int horseId,
//     int? index,
//     String? vetName,
//     String? phoneNumber,
//     String? dialCode,
//     String? countryCode,
//   }) {
//     AddEditGeneralMaintenanceRepository().addEditGeneralMaintenanceRepo(
//       context,
//       index: index,
//       generalMaintenanceId: generalMaintenanceId,
//       horseId: horseId,
//       countryCode: countryCode,
//       dialCode: dialCode,
//       vetName: vetName,
//       phoneNumber: phoneNumber,
//     );
//   }

//   void totalGeneralMaintenance({required int horseId}) async {
//     GetTotalGeneralMaintenanceRepository().totalGeneralMaintenanceRepo(horseId: horseId);
//   }

//   Future<void> generalMaintenance({
//     int? offset,
//     bool? loader,
//     required int horseId,
//   }) async {
//     GetGeneralMaintenanceRepository().generalMaintenanceRepo(loader: loader, offset: offset, horseId: horseId);
//   }

//   void deleteGeneralMaintenance(
//     dynamic context, {
//     int? generalMaintenanceId,
//     required int horseId,
//     required bool deleteFromDetail,
//   }) {
//     DeleteGeneralMaintenanceRepository()
//         .deleteGeneralMaintenanceRepo(context, generalMaintenanceId: generalMaintenanceId, horseId: horseId, deleteFromDetail: deleteFromDetail);
//   }

//   void addEditGeneralMaintenanceExpense(
//     dynamic context, {
//     int? generalMaintenanceExpenseId,
//     required int generalMaintenanceId,
//     int? index,
//     String? date,
//     String? cost,
//     String? name,
//     required String type,
//   }) {
//     AddEditGeneralMaintenanceExpenseRepository().addEditGeneralMaintenanceExpenseRepo(context,
//         index: index,
//         generalMaintenanceId: generalMaintenanceId,
//         generalMaintenanceExpenseId: generalMaintenanceExpenseId,
//         cost: cost,
//         date: date,
//         name: name,
//         type: type);
//   }

//   void totalGeneralMaintenanceExpense({required int generalMaintenanceId, required String type}) async {
//     GetTotalGeneralMaintenanceExpenseRepository().totalGeneralMaintenanceExpenseRepo(generalMaintenanceId: generalMaintenanceId, type: type);
//   }

//   Future<void> generalMaintenanceExpense({
//     int? offset,
//     bool? loader,
//     required String type,
//     required int generalMaintenanceId,
//   }) async {
//     GetGeneralMaintenanceExpenseRepository()
//         .generalMaintenanceExpenseRepo(loader: loader, offset: offset, generalMaintenanceId: generalMaintenanceId, type: type);
//   }

//   void deleteGeneralMaintenanceExpense(
//     dynamic context, {
//     required int generalMaintenanceId,
//     int? generalMaintenanceExpenseId,
//     required String type,
//   }) {
//     DeleteGeneralMaintenanceExpenseRepository().deleteGeneralMaintenanceExpenseRepo(context,
//         generalMaintenanceId: generalMaintenanceId, generalMaintenanceExpenseId: generalMaintenanceExpenseId, type: type);
//   }

//   //-------------------------------------Rodeo-------------------------------
//   void addRodeo(
//     dynamic context, {
//     required RodeoAddModel data,
//   }) {
//     AddRodeoRepository().addRodeoRepo(
//       context,
//       data: data,
//     );
//   }

//   void rodeos() async {
//     GetRodeosRepository().rodeosRepo();
//   }

//   void deleteRodeo(dynamic context, {required int? rodeoId}) {
//     DeleteRodeoRepository().deleteRodeoRepo(
//       context,
//       rodeoId: rodeoId,
//     );
//   }

//   void draw({required int rodeoId}) async {
//     GetDrawRepository().drawRepo(rodeoId: rodeoId);
//   }

//   void editDraw(
//     dynamic context, {
//     required int? rodeoId,
//     required int? drawId,
//     required String? firstGo,
//     required String? secondGo,
//     required String? shortGo,
//     required String? entries,
//   }) {
//     EditDrawRepository().editDrawRepo(
//       context,
//       drawId: drawId,
//       rodeoId: rodeoId,
//       entries: entries,
//       firstGo: firstGo,
//       secondGo: secondGo,
//       shortGo: shortGo,
//     );
//   }

//   void arena({required int rodeoId}) async {
//     GetArenaRepository().arenaRepo(rodeoId: rodeoId);
//   }

//   void editArena(
//     dynamic context, {
//     required int? rodeoId,
//     required int? arenaId,
//     required String? arenaLocation,
//     required String? travelTime,
//     required String? miles,
//     required String? direction,
//     required String? arenaSize,
//     required String? patternSize,
//     required String? location,
//     required String? stallsAvailable,
//     required String? rvAvailable,
//     required String? groundConditions,
//     required String? notes,
//     required String? gateLocations,
//   }) {
//     EditArenaRepository().editArenaRepo(
//       context,
//       arenaId: arenaId,
//       rodeoId: rodeoId,
//       arenaLocation: arenaLocation,
//       arenaSize: arenaSize,
//       direction: direction,
//       groundConditions: groundConditions,
//       location: location,
//       miles: miles,
//       notes: notes,
//       patternSize: patternSize,
//       rvAvailable: rvAvailable,
//       stallsAvailable: stallsAvailable,
//       travelTime: travelTime,
//       gateLocations: gateLocations,
//     );
//   }

//   void wining({required int rodeoId}) async {
//     GetWiningRepository().winingRepo(rodeoId: rodeoId);
//   }

//   void editWining(
//     dynamic context, {
//     required int? rodeoId,
//     required updateWinningModel? data,
//   }) {
//     EditWiningRepository().editWiningRepo(
//       context,
//       rodeoId: rodeoId,
//       data: data,
//       // averageWinningMyTime: averageWinningMyTime,
//       // averageWinningTime: averageWinningTime,
//       // firstGoMyTime: firstGoMyTime,
//       // firstGoWinningTime: firstGoWinningTime,
//       // horseName: horseName,
//       // secondGoMyTime: secondGoMyTime,
//       // secondGoWinningTime: secondGoWinningTime,
//       // shortGoMyTime: shortGoMyTime,
//       // shortGoWinningTime: shortGoWinningTime,
//     );
//   }

//   void rodeosDetails({required int rodeoId}) async {
//     GetRodeoDetailsRepository().rodeoDetailsRepo(rodeoId: rodeoId);
//   }

//   void editRodeosDetails(
//     dynamic context, {
//     required int? rodeoId,
//     required int? rodeoDetailsId,
//     required String? eventName,
//     String? location,
//     String? circuitAssociation,
//     String? moneyAdded,
//     String? edo,
//     String? ec,
//     String? confirmation,
//     String? firstRunPreference,
//     String? secondRunPreference,
//     String? callBackDate,
//     String? buddy,
//     String? cardNumber,
//     String? tradeDeadline,
//     String? trade,
//   }) {
//     EditRodeoDetailsRepository().editRodeoDetailsRepo(
//       context,
//       rodeoDetailsId: rodeoDetailsId,
//       rodeoId: rodeoId,
//       buddy: buddy,
//       callBackDate: callBackDate,
//       cardNumber: cardNumber,
//       circuitAssociation: circuitAssociation,
//       confirmation: confirmation,
//       ec: ec,
//       edo: edo,
//       eventName: eventName,
//       firstRunPreference: firstRunPreference,
//       location: location,
//       moneyAdded: moneyAdded,
//       secondRunPreference: secondRunPreference,
//       trade: trade,
//       tradeDeadline: tradeDeadline,
//     );
//   }

//   Future<void> editRodeoName(
//     dynamic context, {
//     required int? rodeoId,
//     required String? eventName,
//   }) async {
//     EditRodeoNameRepository().editRodeoNameRepo(
//       context,
//       rodeoId: rodeoId,
//       eventName: eventName,
//     );
//   }

//   //-------------------------------Stall Boarding-------------------------------
//   void addEditStallBoarding(
//     dynamic context, {
//     int? stallBoardingId,
//     required int rodeoId,
//     int? index,
//     String? date,
//     String? cost,
//     String? location,
//     // String? companyName,
//   }) {
//     AddEditStallBoardingRepository().addEditStallBoardingRepo(
//       context,
//       index: index,
//       stallBoardingId: stallBoardingId,
//       rodeoId: rodeoId,
//       cost: cost,
//       date: date,
//       location: location,
//     );
//   }

//   void totalStallBoarding({required int rodeoId}) async {
//     GetTotalStallBoardingRepository().totalStallBoardingRepo(rodeoId: rodeoId);
//   }

//   Future<void> stallBoarding({
//     int? offset,
//     bool? loader,
//     required int rodeoId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetStallBoardingRepository().stallBoardingRepo(
//         loader: loader, offset: offset, searchText: searchText, isSearch: isSearch, isAfterSearch: isAfterSearch, rodeoId: rodeoId);
//   }

//   void deleteStallBoarding(
//     dynamic context, {
//     int? stallBoardingId,
//     required int rodeoId,
//   }) {
//     DeleteStallBoardingRepository().deleteStallBoardingRepo(context, stallBoardingId: stallBoardingId, rodeoId: rodeoId);
//   }

//   //-------------------------------Meal-------------------------------
//   void addEditMeal(
//     dynamic context, {
//     int? mealId,
//     required int rodeoId,
//     int? index,
//     String? date,
//     String? cost,
//     String? restaurant,
//     String? event,
//   }) {
//     AddEditMealRepository().addEditMealRepo(
//       context,
//       index: index,
//       mealId: mealId,
//       rodeoId: rodeoId,
//       cost: cost,
//       date: date,
//       restaurant: restaurant,
//       event: event,
//     );
//   }

//   void totalMeal({required int rodeoId}) async {
//     GetTotalMealRepository().totalMealRepo(rodeoId: rodeoId);
//   }

//   Future<void> meal({
//     int? offset,
//     bool? loader,
//     required int rodeoId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetMealRepository()
//         .mealRepo(loader: loader, offset: offset, searchText: searchText, isAfterSearch: isAfterSearch, isSearch: isSearch, rodeoId: rodeoId);
//   }

//   void deleteMeal(
//     dynamic context, {
//     int? mealId,
//     required int rodeoId,
//   }) {
//     DeleteMealRepository().deleteMealRepo(context, mealId: mealId, rodeoId: rodeoId);
//   }

//   //-------------------------------Lodging-------------------------------
//   void addEditLodging(
//     dynamic context, {
//     int? lodgingId,
//     required int rodeoId,
//     int? index,
//     String? date,
//     String? cost,
//     String? location,
//   }) {
//     AddEditLodgingRepository().addEditLodgingRepo(
//       context,
//       index: index,
//       lodgingId: lodgingId,
//       rodeoId: rodeoId,
//       cost: cost,
//       date: date,
//       location: location,
//     );
//   }

//   void totalLodging({required int rodeoId}) async {
//     GetTotalLodgingRepository().totalLodgingRepo(rodeoId: rodeoId);
//   }

//   Future<void> lodging({
//     int? offset,
//     bool? loader,
//     required int rodeoId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetLodgingRepository()
//         .lodgingRepo(loader: loader, offset: offset, searchText: searchText, isSearch: isSearch, isAfterSearch: isAfterSearch, rodeoId: rodeoId);
//   }

//   void deleteLodging(
//     dynamic context, {
//     int? lodgingId,
//     required int rodeoId,
//   }) {
//     DeleteLodgingRepository().deleteLodgingRepo(context, lodgingId: lodgingId, rodeoId: rodeoId);
//   }

//   //-------------------------------Entry Fees-------------------------------
//   void addEditEntryFees(
//     dynamic context, {
//     int? entryFeesId,
//     required int rodeoId,
//     int? index,
//     String? date,
//     String? fees,
//     String? circuitFees,
//     String? location,
//   }) {
//     AddEditEntryFeesRepository().addEditEntryFeesRepo(
//       context,
//       index: index,
//       entryFeesId: entryFeesId,
//       rodeoId: rodeoId,
//       fees: fees,
//       circuitFees: circuitFees,
//       date: date,
//       location: location,
//     );
//   }

//   void totalEntryFees({required int rodeoId}) async {
//     GetTotalEntryFeesRepository().totalEntryFeesRepo(rodeoId: rodeoId);
//   }

//   Future<void> entryFees({
//     int? offset,
//     bool? loader,
//     required int rodeoId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetEntryFeesRepository()
//         .entryFeesRepo(loader: loader, offset: offset, searchText: searchText, isSearch: isSearch, isAfterSearch: isAfterSearch, rodeoId: rodeoId);
//   }

//   void deleteEntryFees(
//     dynamic context, {
//     int? entryFeesId,
//     required int rodeoId,
//   }) {
//     DeleteEntryFeesRepository().deleteEntryFeesRepo(context, entryFeesId: entryFeesId, rodeoId: rodeoId);
//   }

//   //-------------------------------Bedding Rodeos-------------------------------
//   void addEditBeddingRodeos(
//     dynamic context, {
//     int? beddingRodeosId,
//     required int rodeoId,
//     int? index,
//     String? date,
//     String? cost,
//     String? location,
//   }) {
//     AddEditBeddingRodeosRepository().addEditBeddingRodeosRepo(
//       context,
//       index: index,
//       beddingRodeosId: beddingRodeosId,
//       rodeoId: rodeoId,
//       cost: cost,
//       date: date,
//       location: location,
//     );
//   }

//   void totalBeddingRodeos({required int rodeoId}) async {
//     GetTotalBeddingRodeosRepository().totalBeddingRodeosRepo(rodeoId: rodeoId);
//   }

//   Future<void> beddingRodeos({
//     int? offset,
//     bool? loader,
//     required int rodeoId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetBeddingRodeosRepository().beddingRodeosRepo(
//         loader: loader, offset: offset, searchText: searchText, isSearch: isSearch, isAfterSearch: isAfterSearch, rodeoId: rodeoId);
//   }

//   void deleteBeddingRodeos(
//     dynamic context, {
//     int? beddingRodeosId,
//     required int rodeoId,
//   }) {
//     DeleteBeddingRodeosRepository().deleteBeddingRodeosRepo(context, beddingRodeosId: beddingRodeosId, rodeoId: rodeoId);
//   }

//   //-------------------------------Earning Rodeos Association-------------------------------
//   void addEditEarningRodeosAssociation(
//     dynamic context, {
//     int? earningRodeosAssociationId,
//     required int rodeoId,
//     int? index,
//     String? name,
//   }) {
//     AddEditEarningRodeosAssociationRepository().addEditEarningRodeosAssociationRepo(
//       context,
//       index: index,
//       earningRodeosAssociationId: earningRodeosAssociationId,
//       rodeoId: rodeoId,
//       associationName: name,
//     );
//   }

//   void totalEarningRodeosAssociation({required int rodeoId}) async {
//     GetTotalEarningRodeosAssociationRepository().totalEarningRodeosAssociationRepo(rodeoId: rodeoId);
//   }

//   void winningHorseRepository({required int rodeoId}) async {
//     GetWinningHorseRepository().winningHorseRepo(rodeoId: rodeoId);
//   }

//   Future<void> earningRodeosAssociation({
//     required int rodeoId,
//   }) async {
//     GetEarningRodeosAssociationRepository().earningRodeosAssociationRepo(rodeoId: rodeoId);
//   }

//   void deleteEarningRodeosAssociation(
//     dynamic context, {
//     int? earningRodeosAssociationId,
//     required int rodeoId,
//   }) {
//     DeleteEarningRodeosAssociationRepository()
//         .deleteEarningRodeosAssociationRepo(context, earningRodeosAssociationId: earningRodeosAssociationId, rodeoId: rodeoId);
//   }

//   void addEditEarningRodeos(
//     dynamic context, {
//     int? earningRodeosId,
//     required int? associationId,
//     int? index,
//     String? date,
//     String? cost,
//     int? horseId,
//   }) {
//     AddEditEarningRodeosRepository().addEditEarningRodeosRepo(
//       context,
//       index: index,
//       earningRodeosId: earningRodeosId,
//       cost: cost,
//       date: date,
//       horseId: horseId,
//       associationId: associationId,
//     );
//   }

//   void totalEarningRodeos({required int associationId}) async {
//     GetTotalEarningRodeosRepository().totalEarningRodeosRepo(associationId: associationId);
//   }

//   Future<void> earningRodeos({
//     int? offset,
//     bool? loader,
//     required int associationId,
//     String? searchText,
//     bool? isSearch,
//     required bool? isAfterSearch,
//   }) async {
//     GetEarningRodeosRepository().earningRodeosRepo(
//         loader: loader, offset: offset, searchText: searchText, isSearch: isSearch, isAfterSearch: isAfterSearch, associationId: associationId);
//   }

//   void deleteEarningRodeos(
//     dynamic context, {
//     int? earningRodeosId,
//     required int associationId,
//   }) {
//     DeleteEarningRodeosRepository().deleteEarningRodeosRepo(context, earningRodeosId: earningRodeosId, associationId: associationId);
//   }

//   //------------------------------------Notification--------------------------//
//   Future<void> notification({
//     int? offset,
//     bool? loader,
//   }) async {
//     GetNotificationRepository().GetNotificationsRepo(
//       loader: loader,
//       offset: offset,
//     );
//   }

//   void notificationCount() async {
//     GetNotificationCountRepository().GetNotificationCountRepo();
//   }

//   void MarkAsRead({required int notificationId, required int index}) async {
//     MarkAsReadRepository().MarkAsReadRepo(notificationId: notificationId, index: index);
//   }

//   void clearAllData() {
//     // Resetting basic types
//     selectedTab.value = 0;
//     selectedHorse.value = "";
//     selectedDate.value = DateTime.now();
//     selectedWeek.value = 1;
//     selectedDay.value = null;
//     totalAmount.value = "0";
//     totalEarningAmount.value = "0";
//     totalAmountTrailer.value = "0";
//     rodeoGraphAmount.value = "50";
//     horseGraphAmount.value = "50";
//     totalAmountTruck.value = "0";
//     totalUserExpenseAmount.value = "0";
//     totalHorseExpenseAmount.value = "0";
//     totalRodeosExpenseAmount.value = "0";
//     unReadNotificationCount.value = 0;
//     throughNotificationId?.value = 0;
//     throughNotificationDate?.value = "";
//     isThroughNotificationDate?.value = false;
//     jumptoIndex.value = 0;

//     // Resetting lists
//     notesList.clear();
//     notesDetail.value = NotesModelDataNotes(); // Resetting to default
//     otherServicesList.clear();
//     vetLocationsList.clear();
//     horseHotelList.clear();
//     plannedEventsList.clear();
//     CalendarEventsList.clear();
//     CalendarEventsSpecificDateList.clear();
//     eventList.clear();
//     CalendarEventsSpecificDateDetail.value = CalendarEventsSpecificDateModelData(); // Resetting to default
//     vehicleMaintenanceList.clear();
//     trailerMaintenanceList.clear();
//     tireReplacementList.clear();
//     tackList.clear();
//     performanceClothingList.clear();
//     trailerInsuranceList.clear();
//     gasList.clear();
//     travelPartnerInfoList.clear();
//     associationMembershipList.clear();
//     truckInsuranceList.clear();
//     supplementsList.clear();
//     medicationsDeliverySystemList.clear();
//     horseInsuranceList.clear();
//     feedsList.clear();
//     beddingList.clear();
//     veterinaryTreatmentsList.clear();
//     earningAssociationList.clear();
//     earningList.clear();
//     farrierInfoList.clear();
//     shoeingRecordsList.clear();
//     generalMaintenanceList.clear();
//     generalMaintenanceExpenseList.clear();
//     rodeosList.clear();
//     stallBoardingList.clear();
//     mealList.clear();
//     lodgingList.clear();
//     entryFeesList.clear();
//     beddingRodeosList.clear();
//     earningRodeosAssociationList.clear();
//     earningRodeosList.clear();
//     notificationList.clear();

//     // Resetting chart data
//     horseEarningchartData.clear();
//     horseEarningchartData.addAll([
//       ChartData('Jan', 0),
//       ChartData('Feb', 0),
//       ChartData('Mar', 0),
//       ChartData('Apr', 0),
//       ChartData('May', 0),
//       ChartData('Jun', 0),
//       ChartData('Jul', 1),
//       ChartData('Aug', 0),
//       ChartData('Sep', 0),
//       ChartData('Oct', 0),
//       ChartData('Nov', 0),
//       ChartData('Dec', 0),
//     ]);

//     rodeosEarningchartData.clear();
//     rodeosEarningchartData.addAll([
//       ChartData('Jan', 0),
//       ChartData('Feb', 0),
//       ChartData('Mar', 0),
//       ChartData('Apr', 0),
//       ChartData('May', 0),
//       ChartData('Jun', 1),
//       ChartData('Jul', 0),
//       ChartData('Aug', 0),
//       ChartData('Sep', 0),
//       ChartData('Oct', 0),
//       ChartData('Nov', 0),
//       ChartData('Dec', 0),
//     ]);

//     // Resetting API loaders
//     loaderApi.value = false;
//     myNotesApi.value = false;
//     otherServicesApi.value = false;
//     vetLocationsApi.value = false;
//     horseHotelApi.value = false;
//     plannedEventsApi.value = false;
//     calendarEventsApi.value = false;
//     calendarEventsSpecificDateApi.value = false;
//     vehicleTrailerMaintenanceApi.value = false;
//     totalApi.value = false;
//     tireReplacementApi.value = false;
//     tackApi.value = false;
//     performanceClothingApi.value = false;
//     trailerInsuranceApi.value = false;
//     gasApi.value = false;
//     travelPartnerInfoApi.value = false;
//     associationMembershipApi.value = false;
//     truckInsuranceApi.value = false;
//     supplementsApi.value = false;
//     medicationsDeliverySystemApi.value = false;
//     horseInsuranceApi.value = false;
//     feedsApi.value = false;
//     beddingApi.value = false;
//     veterinaryTreatmentsApi.value = false;
//     earningAssociationApi.value = false;
//     earningApi.value = false;
//     farrierInfoApi.value = false;
//     shoeingRecordsApi.value = false;
//     generalMaintenanceApi.value = false;
//     generalMaintenanceExpenseApi.value = false;
//     rodeosApi.value = false;
//     detailApi.value = false;
//     stallBoardingApi.value = false;
//     mealApi.value = false;
//     lodgingApi.value = false;
//     entryFeesApi.value = false;
//     beddingRodeosApi.value = false;
//     earningRodeosApi.value = false;
//     earningRodeosAssociationApi.value = false;
//     allExpensesApi.value = false;
//     filter.value = false;
//     notificationApi.value = false;

//     // Resetting pagination
//     page.value = 1;

//     // Resetting section maps
//     sections.clear();
//   }
}
