import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/regular_expressions.dart';

extension FieldValidator on String {
  static bool isHideoldpassword = true;
  static bool isHidepassword = true;
  static bool isHideconfirmpassword = true;
  static const String passwordRegix = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  //------------- hide/Un hide--------------//
  static void oldPasswordHideIcon() {
    if (isHideoldpassword) {
      isHideoldpassword = false;
    } else {
      isHideoldpassword = true;
    }
  }

  static void passwordHideIcon() {
    if (isHidepassword) {
      isHidepassword = false;
    } else {
      isHidepassword = true;
    }
  }

  static void confirmPasswordHideIcon() {
    if (isHideconfirmpassword) {
      isHideconfirmpassword = false;
    } else {
      isHideconfirmpassword = true;
    }
  }

  //-------------- Email Validator -------------------
  get validateEmail {
    if (!RegularExpressions.emailValidRegex.hasMatch(this) && isNotEmpty) {
      return AppStrings.invalidEmailAddress;
    } else if (trim().isEmpty) {
      return AppStrings.emptyEmailAddress;
    }
    return null;
  }

  get validateVerificationCode {
    if (trim().isEmpty) {
      return AppStrings.otpFieldCantBeEmpty;
    } else if (trim().length < 4) {
      return AppStrings.otpFieldCantBeEmpty;
    } else if (!RegularExpressions.verificationCodeRegex.hasMatch(this) && isNotEmpty) {
      return AppStrings.invalidVerificationCode;
    } else
      return null;
  }

  //-----------------Password Validator--------------
  static String? validateLoginPassword(String value, String? label) {
    if (value.trim().isEmpty) {
      return "$label field can\'t be empty.";
    } else if (!RegExp(passwordRegix).hasMatch(value)) {
      return "Password must be of 8 characters long.";
    }
    return null;
  }

//--------------------Confirm Password Validator--------//
  static String? validateConfirmPassword(String confirmPassword, String password, String label) {
    if (confirmPassword.isEmpty) {
      return 'Confirm Password field can\'t be empty.';
    } else if (!(password == confirmPassword)) {
      return '$label and Confirm Password must be same.';
    } else if (confirmPassword.isEmpty) {
      return 'Confirm Password field can\'t be empty.';
    } else {
      return null;
    }
  }



  //---------------- Website Validator -----------------//
String? validateWebsite(String message, {bool isOptionalCheck = false}) {
  final pattern =
      r'^(https?:\/\/)?(www\.)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(/.*)?$';
  final regExp = RegExp(pattern);

  final value = trim();

  if (isOptionalCheck) {
    if (value.isEmpty) {
      return null; // ✅ Empty is allowed
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid $message URL.';
    }
  } else {
    if (value.isEmpty) {
      return '$message field can\'t be empty.';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid $message URL.';
    }
  }

  return null; // ✅ Passes validation
}



  //---------------- Empty Validator -----------------
  validateEmpty(String message) {
    if (trim().isEmpty) {
      return '$message field can\'t be empty.';
    } else {
      return null;
    }
  }

  //---------------- CVC Validator -----------------//
  static String? validateCVC({required String value, String? label}) {
    if (value.trim().isEmpty) {
      return "$label  field can't be empty.";
    } else if (value.length <= 2) {
      return "$label must be atleast 3 digits.";
    }
    return null;
  }

  //---------------- Password Validator -----------------//
  static String? validateCardNo({required String value, String? label}) {
    if (value.trim().isEmpty) {
      return "$label  field can't be empty.";
    } else if (value.length <= 15) {
      return "$label must be atleast 16 digits.";
    }
    return null;
  }

  // get validateYear {
  //
  // if (trim().isEmpty) {
  //     return AppStrings.yearEmpty;
  //   }
  // else if (int.parse(this).isWithinLastTenYears()==false && isNotEmpty) {
  //   return AppStrings.invalidYear;
  // } else {
  //   return null;
  // }
  // }

  //---------------- Phone Number Validator ----------
  get validatePhoneNumber {
    // print("Number : " + this);
    if (trim().isEmpty) {
      return AppStrings.emptyPhoneNumber;
    }
    // if (length < 10) {
    //   return AppStrings.PHONE_NO_INVALID_LENGTH;
    // }
    else {
      return null;
    }
  }

//---------------- OTP Validator ---------------
  String? validateOtp(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  static String getTimeDifferenceFromNow(DateTime? dateTime) {
    Duration difference = DateTime.now().difference(dateTime!);
    if (difference.inSeconds < 5) {
      return "Just now";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds}s ago";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays > 7) {
      return "more a week";
    } else {
      return "${difference.inDays}d ago";
    }
  }
}
