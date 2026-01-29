import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/camera_document_bottom_sheet.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/image_picker_bottom_sheet.dart';
// import 'package:ezhandy_user/widgets/view_image/arguments/view_full_image_arguments.dart';
// import 'package:file_picker/file_pick/er.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/image_picker_bottom_sheet.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/image_picker_bottom_sheet.dart';
import 'package:ezhandy_user/widgets/view_image/arguments/view_full_image_arguments.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:table_calendar/table_calendar.dart';

class Utils {
  // ///-------------------- Capitalize word -------------------- ///
  static String capitalizeWords(String text) {
    final words = text.split(' ');
    final capitalizedWords = words.map((word) {
      final firstLetter = word[0].toUpperCase();
      final restOfWord = word.substring(1);
      return '$firstLetter$restOfWord';
    });
    return capitalizedWords.join(' ');
  }

  // // ///-------------------- Video Extention -------------------- ///
  // static bool vedioExtension(String filePath) {
  //   String fileExtension = filePath.split('.').last;
  //   // log(AppConstant.formats.contains(fileExtension).toString());
  //   // log(AppConstant.formats.contains(fileExtension).toString());
  //   return AppConstant.formats.contains(fileExtension);
  // }

  ///------------------------------------------View Image----------------------------///
  static onTapViewImage({
    required BuildContext context,
    String? image,
    String? mediaType,
  }) {
    if (image != "" && image != null) {
      AppNavigation.navigateTo(context, AppRoutes.viewFullImageScreenRoute,
          arguments: ViewFullImageRoutingArgumentss(
              mediaType: mediaType ?? MediaPathType.network.name,
              image: image));
    }
  }

  // ///-------------------- Image Picker Bottom Sheet (Image Picker and File Pdf) -------------------- ///
  // static void showImageFileSourceSheet({
  //   BuildContext? context,
  //   final Function(File)? setFile,
  //   bool isVideo = false,
  // }) {
  //   showModalBottomSheet(
  //     context: context!,
  //     builder: (BuildContext context) {
  //       return CameraDocumentBottomSheet(
  //         setFile: setFile,
  //         // isVideo: isVideo,
  //       );
  //     },
  //   );
  // }

  ///-------------------- Image Picker Bottom Sheet (Image Picker and Cropper) -------------------- ///
  static void showImageSourceSheet({
    BuildContext? context,
    final Function(File)? setFile,
    bool isVideo = false,
  }) {
    showModalBottomSheet(
      context: context!,
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(
          setFile: setFile,
          isVideo: isVideo,
        );
      },
    );
  }

  // static void showVideoSourceSheet({
  //   BuildContext? context,
  //   final Function(File)? setFile,
  // }) {
  //   showModalBottomSheet(
  //     context: context!,
  //     builder: (BuildContext context) {
  //       return ImagePickerBottomSheet(
  //         setFile: setFile,
  //         isVideo: true,
  //       );
  //     },
  //   );
  // }

  static Future<void> showCustomBottomSheet({
    BuildContext? context,
    required Widget bottomSheet,
  }) async {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context!,
      builder: (BuildContext context) {
        return bottomSheet;
      },
    );
  }

  static Future openFilePicker({
    BuildContext? context,
    Function(File)? setFile,
    required bool isPdf,
    bool isPop = true,
  }) async {
    FocusScope.of(context!).unfocus();
    if (isPop) {
      AppNavigation.navigatorPop(context);
    }
    // Pop : To close Image Selection Dialog
    try {
      final file = await FilePicker.platform.pickFiles(
        type: isPdf ? FileType.custom : FileType.image,
        allowedExtensions: isPdf == true
            ? ['png', 'jpg', 'jpeg', 'pdf']
            : null, // ✅ Allow PNG, JPG, PDF
      );

      if (file != null) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print(file.files.single.path);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print(file.files.single.name);

        setFile!(File(file.files.single.path.toString()));
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      }
    } catch (e) {
      print("$e 5455555555555555555555555555555555555555555");
    }
  }

  static Future openImagePicker({
    ImageSource? source,
    BuildContext? context,
    Function(File)? setFile,
    bool action = true,
  }) async {
    FocusScope.of(context!).unfocus();
    action == true ? Get.back() : null;
    try {
      final image =
          await ImagePicker().pickImage(source: source!, imageQuality: 50);
      if (image != null) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print(image.path);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        cropImage(image: image.path, setFile: setFile!, context: context);
      }
    } catch (e) {
      print(e.toString() + "5455555555555555555555555555555555555555555");
    }
  }

 static Future openVideoPicker({
  ImageSource? source,
  BuildContext? context,
  Function(File)? setFile,
  Function(File)? setThumbnail,
  bool action = true,
}) async {
  FocusScope.of(context!).unfocus();
  if (action) Get.back();

  final picked = await ImagePicker().pickVideo(source: source!);
  if (picked == null) return;

  final videoFile = File(picked.path);

  // Give camera time to finalize video
  await Future.delayed(const Duration(milliseconds: 300));

  final thumbBytes = await VideoThumbnail.thumbnailData(
    video: picked.path,
    imageFormat: ImageFormat.JPEG, // ✅ IMPORTANT
    maxHeight: 512,
    quality: 80,
  );

  if (thumbBytes == null || thumbBytes.isEmpty) return;

  final dir = await getTemporaryDirectory();
  final thumbFile = File(
    '${dir.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.jpg',
  );

  await thumbFile.writeAsBytes(thumbBytes);

  setFile?.call(videoFile);
  setThumbnail?.call(thumbFile);
}




  showAppDialog({
    required BuildContext context,
    required Widget child,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(25).r,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: child,
          );
        });
  }

  // static Future openFilePicker(
  //     {BuildContext? context, Function(String)? setFile}) async {
  //   FocusScope.of(context!).unfocus();
  //   // Pop : To close Image Selection Dialog
  //   // Navigation.pop(context);
  //   try {
  //     final file = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //     );
  //     if (file != null) {
  //       print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  //       print(file.files.single.path);
  //       print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  //       print(file.files.single.name);
  //       setFile!(file.files.single.name);
  //       print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

  //       // cropImage(image: image.path, setFile: setFile, context: context);
  //     }
  //   } catch (e) {
  //     print(e.toString() + "5455555555555555555555555555555555555555555");
  //   }
  // }

  static void cropImage(
      {required String image,
      required Function(File) setFile,
      required BuildContext context}) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image,
        // cropStyle: CropStyle.rectangle, // New required parameter
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Edit Image",
            toolbarColor: AppColors.orange,
            toolbarWidgetColor:
                AppColors.white, // Replace with your AppColors.white
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: false, // Ensure crop controls are visible
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );

      if (croppedFile != null) {
        File _image = File(croppedFile.path);
        setFile(_image);
      }
    } catch (e) {
      debugPrint("Error cropping image: ${e.toString()}");
    }
  }

// ///--------------------Show range date picker---------------///

  // static Future<RangeDateTime?> displayRangeDatePicker({
  //   RangeDateTime? rangeDate,
  //   DateTime? firstDate,
  //   DateTime? lastDate,
  //   required BuildContext context,
  //   bool isPurpleTheme = true, // Using Purple Theme
  // }) async {
  //   return await showDialog<RangeDateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       ValueNotifier<RangeDateTime?> rangeNotifier = ValueNotifier(
  //         rangeDate ??
  //             RangeDateTime(
  //               start: DateTime.now(),
  //               end: DateTime.now(),
  //             ),
  //       );

  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20), // Rounded corners
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // **Table Calendar UI**
  //               ValueListenableBuilder<RangeDateTime?>(
  //                 valueListenable: rangeNotifier,
  //                 builder: (_, RangeDateTime? v, __) {
  //                   return TableCalendar(
  //                     onRangeSelected: (start, end, focusedDay) {
  //                       rangeNotifier.value = rangeNotifier.value?.copyWith(
  //                         start: start,
  //                         end: end,
  //                       );
  //                     },
  //                     rowHeight: 50,
  //                     headerStyle: HeaderStyle(
  //                       formatButtonVisible: false,
  //                       titleCentered: true,
  //                       titleTextStyle: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                       leftChevronIcon: Icon(
  //                         Icons.arrow_back_ios_new_rounded,
  //                         color: Colors.black,
  //                         size: 18,
  //                       ),
  //                       rightChevronIcon: Icon(
  //                         Icons.arrow_forward_ios_rounded,
  //                         color: Colors.black,
  //                         size: 18,
  //                       ),
  //                     ),
  //                     daysOfWeekHeight: 40,
  //                     daysOfWeekStyle: DaysOfWeekStyle(
  //                       weekdayStyle: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                       weekendStyle: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     calendarStyle: CalendarStyle(
  //                       isTodayHighlighted: false,
  //                       defaultTextStyle: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                       rangeStartDecoration: BoxDecoration(
  //                         color: isPurpleTheme ? Color(0xFF9575CD) : Colors.blue,
  //                         shape: BoxShape.circle, // Circular shape for start
  //                       ),
  //                       rangeEndDecoration: BoxDecoration(
  //                         color: isPurpleTheme ? Color(0xFF9575CD) : Colors.blue,
  //                         shape: BoxShape.circle, // Circular shape for end
  //                       ),
  //                       rangeHighlightColor: isPurpleTheme ? Color(0xFFB39DDB).withOpacity(0.5) : Colors.blue.withOpacity(0.5),
  //                       outsideTextStyle: TextStyle(
  //                         color: Colors.grey,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     focusedDay: rangeNotifier.value?.start ?? DateTime.now(),
  //                     rangeSelectionMode: RangeSelectionMode.toggledOn,
  //                     rangeStartDay: rangeNotifier.value?.start,
  //                     rangeEndDay: rangeNotifier.value?.end,
  //                     firstDay: firstDate ?? DateTime.utc(2010, 10, 16),
  //                     lastDay: lastDate ?? DateTime.utc(2030, 3, 14),
  //                   );
  //                 },
  //               ),

  //               SizedBox(height: 8),

  //               // **Action Buttons**
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   TextButton(
  //                     onPressed: () => Navigator.pop(context, null),
  //                     child: Text(
  //                       "CANCEL",
  //                       style: TextStyle(
  //                         color: Colors.black54,
  //                         fontWeight: FontWeight.bold,
  //                         letterSpacing: 1.2,
  //                       ),
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () => Navigator.pop(context, rangeNotifier.value),
  //                     child: Text(
  //                       "OK",
  //                       style: TextStyle(
  //                         color: Color(0xFF9575CD),
  //                         fontWeight: FontWeight.bold,
  //                         letterSpacing: 1.2,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // ///-------------------- Show Date Picker -------------------- ///
  // static Future<DateTime?> displayDatePicker({
  //   DateTime? date,
  //   DateTime? lastDate,
  //   DateTime? firstDate,
  //   BuildContext? context,
  // }) async {
  //   try {
  //     date = await showDatePicker(
  //           context: context!,
  //           initialDate: date ?? DateTime.now(),
  //           firstDate: firstDate ?? DateTime(1900, 01, 01),
  //           lastDate: lastDate ?? DateTime(3000, 01, 01),
  //         ) ??
  //         (lastDate == null ? date : null);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return date;
  // }

  static Future<DateTime?> displayDatePicker({
    DateTime? date,
    DateTime? lastDate,
    DateTime? firstDate,
    required BuildContext context,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900, 01, 01),
      lastDate: lastDate ?? DateTime(3000, 01, 01),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF9575CD), // Purple header
            colorScheme: ColorScheme.light(
              primary: Color(0xFF9575CD), // Selected Date color
              onPrimary: AppColors.white, // Text on selected date
              surface: Color(0xFFF3E5F5), // Background color
              onSurface: AppColors.black, // Default text color
            ),
            dialogBackgroundColor: Color(0xFFF3E5F5), // Background color
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF9575CD), // Buttons color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  // /-------------------- Show Time Picker -------------------- ///
  static Future<TimeOfDay?> displayTimePicker({
    TimeOfDay? time,
    BuildContext? context,
  }) async {
    try {
      time = await showTimePicker(
            initialTime: time ?? TimeOfDay.now(),
            context: context!,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  timePickerTheme: TimePickerThemeData(
                    dialHandColor:
                        AppColors.green, // Clock selection hand color
                    // dialBackgroundColor: Colors.red, // Circle color
                    dayPeriodColor: WidgetStateColor.resolveWith((states) =>
                        states.contains(WidgetState.selected)
                            ? AppColors.green.withOpacity(
                                .3) // Selected AM/PM background color
                            : AppColors.grey), // Unselected AM/PM color
                    hourMinuteColor: WidgetStateColor.resolveWith((states) =>
                        states.contains(WidgetState.selected)
                            ? AppColors.green.withOpacity(
                                .3) // Selected hour/minute background color
                            : AppColors.grey), // Unselected background color
                  ),
                ),
                child: child!,
              );
            },
          ) ??
          null;
    } catch (e) {
      print(e.toString());
    }
    return time;
  }

  ///------------------------ Time duration -------------------///
  static String getDurationString(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '$hours hours $minutes minutes';
    } else if (hours > 0) {
      return '$hours hours';
    } else if (minutes > 0) {
      return '$minutes minutes';
    } else {
      return '0 minutes';
    }
  }

  ///-------------------- Time Converter -------------------- ///

  static String formatRelativeTime(
      {required String dateTimeString, required bool isChat}) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    Duration diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} mins ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hrs ago';
    } else if (diff.inDays == 1) {
      return 'yesterday';
    } else if (diff.inDays == 2) {
      return '2 days ago';
    } else if (diff.inDays == 3) {
      return '3 days ago';
    } else if (diff.inDays == 4) {
      return '4 days ago';
    } else {
      return DateFormat.yMMMd().format(dateTime);
    }
  }

  ///-------------------- Format Date -------------------- ///
  static String formatDate({String? pattern, DateTime? date}) {
    DateFormat _dateFormat = DateFormat(pattern);
    return _dateFormat.format(date ?? DateTime.now());
  }

  ///-------------------- Format Date -------------------- ///
  static String formatTime({required TimeOfDay time}) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // 5:08 PM
    return format.format(dt);
  }

  // static String maskCardNumber(String inputString) {
  //   // Split the input string into segments
  //   List<String> segments = inputString.split(' ');

  //   // Mask the first three segments with asterisks
  //   for (int i = 0; i < 3; i++) {
  //     segments[i] = "****";
  //   }

  //   // Join the segments back together with spaces
  //   String maskedString = segments.join(' ');

  //   return maskedString;
  // }
}
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

class RangeDateTime {
  final DateTime? start;
  final DateTime? end;

  RangeDateTime({this.start, this.end});

  RangeDateTime copyWith({DateTime? start, DateTime? end}) {
    return RangeDateTime(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
