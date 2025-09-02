// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:place_picker/place_picker.dart';

class Constants {
  static const emailMaxLength = 35;
  static const zipCodeLength = 7;
  static const nameMaxLength = 30;
  static const addressMaxLength = 50;
  static const descriptionMaxLength = 275;
  static const cvcLength = 3;
  static const accountNumberLength = 16;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static String formatDateTime(
      {required String parseFormat, required DateTime inputDateTime}) {
    return DateFormat(parseFormat).format(inputDateTime);
  }

  static Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  static Future<void> showSelectDatePicker(
      {BuildContext? context,
      final ValueChanged<DateTime?>? getSelectedDate,
      bool? isPreDateEnable}) async {
    final DateTime? picked = await showDatePicker(
        context: context!,
        initialDate: DateTime.now(),
        //  firstDate:isPreDateEnable==true? DateTime(1800): DateTime.now().subtract(Duration(days: 1)),
        //  lastDate: DateTime.now(),
        firstDate: isPreDateEnable == false
            ? DateTime.now().subtract(const Duration(days: 0))
            : DateTime(1800),
        lastDate: isPreDateEnable == false ? DateTime(2100) : DateTime.now(),
        helpText: "Select Date",
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    // foregroundColor: AppColors.transparentColor, // button text color
                    ),
              ),
            ),
            child: Hero(tag: "selectDate", child: child!),
          );
        });
    if (picked != null) {
      getSelectedDate!(picked);
    }
  }

  static Future<void> showSelectTimePicker(
      {BuildContext? context,
      final ValueChanged<TimeOfDay?>? getSelectedTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context!,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme:  ColorScheme.light(
                primary: AppColors.black, // header background color
                //onPrimary: Colors.black, // header text color
                //onSurface: Colors.green, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.black, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
    if (pickedTime != null) {
      getSelectedTime!(pickedTime);
    }
  }

  static MaskTextInputFormatter MaskTextFormatterExpiry =
      MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static MaskTextInputFormatter maskTextInputFormatterCardNumber =
      MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static final MaskTextInputFormatter maskTextInputFormatterPhoneUSWithCode =
      MaskTextInputFormatter(
    mask: '+1 (###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  // Future<Map<String, String>?> pickPlace(BuildContext context) async {
  //   LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => PlacePicker(
  //       "AIzaSyBmaS0B0qwokES4a_CiFNVkVJGkimXkNsk", // Replace with your Google Maps API Key
  //     ),
  //   ));

  //   if (result != null) {
  //     String lat = (result.latLng?.latitude ?? 0).toString();
  //     String lng = (result.latLng?.longitude ?? 0).toString();
  //     String country = result.country?.name ?? "";
  //     String state = result.administrativeAreaLevel1?.name ?? "";
  //     String city = result.city?.name ?? "";
  //     String fullAddress = result.formattedAddress ?? '';

  //     // for (var component in result.addressComponents) {
  //     //   if (component.types.contains('country')) {
  //     // country = result.country?.name ?? "";
  //     // city = result.city?.name ?? "";
  //     // state = result.administrativeAreaLevel1?.name ?? "";
  //     //   }
  //     //   if (component.types.contains('administrative_area_level_1')) {
  //     //     state = component.longName;
  //     //   }
  //     //   if (component.types.contains('locality')) {
  //     //     city = component.longName;
  //     //   }
  //     // }
  //     log(fullAddress);
  //     log(lat);
  //     log(lng);
  //     log(country);
  //     log(city);
  //     log(state);
  //     return {
  //       'latitude': lat,
  //       'longitude': lng,
  //       'country': country,
  //       'state': state,
  //       'city': city,
  //       'fullAddress': fullAddress,
  //     };
  //   }

  //   return null;
  // }

  // static const googleApiKey = "AIzaSyBmaS0B0qwokES4a_CiFNVkVJGkimXkNsk";
  // static Future<Map<String, dynamic>> findStreetAreaMethod(
  //     {required BuildContext context,
  //     String? prediction,
  //     String? placeId}) async {
  //   Map<String, dynamic>? addressDetail = {
  //     "address": null,
  //     "city": null,
  //     "state": null,
  //     "country": null,
  //     "latitude": null,
  //     "longitude": null
  //   };
  //   try {
  //     GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);

  //     PlacesDetailsResponse detail =
  //         await _places.getDetailsByPlaceId(placeId!);
  //     List? addressInArray = prediction?.split(",");
  //     print("Address in array:${addressInArray}");
  //     String address = "";
  //     if (addressInArray != null) {
  //       if (addressInArray.length == 1) {
  //         addressDetail["address"] = addressInArray[0];
  //       } else {
  //         log(prediction.toString());
  //         for (int i = 0; i < addressInArray.length - 2; i++) {
  //           address = address + addressInArray[i];
  //         }
  //         addressDetail["latitude"] = detail.result.geometry!.location.lat;
  //         addressDetail["longitude"] = detail.result.geometry!.location.lng;

  //         addressDetail["address"] = prediction;
  //         addressDetail["state"] =
  //             (addressInArray[addressInArray.length - 2] ?? "");
  //         addressDetail["city"] =
  //             (addressInArray[addressInArray.length - 3] ?? "");
  //         addressDetail["country"] =
  //             (addressInArray[addressInArray.length - 1] ?? "");
  //       }
  //     }
  //   } catch (e) {
  //     print("error:${e}");
  //   }
  //   return addressDetail;
  // }

  // static Future<Prediction?> addressPicker(BuildContext context) {
  //   return PlacesAutocomplete.show(
  //     offset: 0,
  //     logo: Text(""),
  //     types: [],
  //     strictbounds: false,
  //     context: context,
  //     apiKey: googleApiKey,
  //     mode: Mode.overlay,
  //     language: "en",
  //   );
  // }
}
