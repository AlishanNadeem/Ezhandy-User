import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/network_strings.dart';

class SharedPreference {
  static SharedPreference? _sharedPreferenceHelper;
  static SharedPreferences? _sharedPreferences;

  SharedPreference._createInstance();

  factory SharedPreference() {
    // factory with constructor, return some value
    if (_sharedPreferenceHelper == null) {
      _sharedPreferenceHelper = SharedPreference
          ._createInstance(); // This is executed only once, singleton object
    }
    return _sharedPreferenceHelper!;
  }

  Future<SharedPreferences> get sharedPreference async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!;
  }

  ///-------------------- Clear Preference -------------------- ///
  void clear() {
    _sharedPreferences?.clear();
  }
///-------------------- Logout Safe Clear -------------------- ///
void clearSessionOnly() {
  _sharedPreferences?.remove(NetworkStrings.BEARER_TOKEN);
  _sharedPreferences?.remove(NetworkStrings.USER);
}

  ///-------------------- Bearer Token -------------------- ///
  String? getBearerToken() {
    return _sharedPreferences?.getString(NetworkStrings.BEARER_TOKEN);
  }

  void setBearerToken({String? token}) {
    _sharedPreferences?.setString(NetworkStrings.BEARER_TOKEN, token ?? '');
  }

  ///-------------------- User -------------------- ///
  void setUser({String? user}) {
    _sharedPreferences?.setString(NetworkStrings.USER, user ?? '');
  }

  AppUser? getUser() {
    if (_sharedPreferences?.getString(NetworkStrings.USER) == null) {
      return null;
    } else {
      var jsonResponse = convert
          .jsonDecode((_sharedPreferences!.getString(NetworkStrings.USER) ?? ''));
      var user = AppUser.fromJson(jsonResponse);
      return user;
    }
  }


///-------------------- Remember Me -------------------- ///
static const String REMEMBER_EMAIL = "remember_email";
static const String REMEMBER_PASSWORD = "remember_password";
static const String REMEMBER_ME = "remember_me";

void setRememberMe(bool value) {
  _sharedPreferences?.setBool(REMEMBER_ME, value);
}

bool getRememberMe() {
  return _sharedPreferences?.getBool(REMEMBER_ME) ?? false;
}

void saveCredentials({required String email, required String password}) {
  _sharedPreferences?.setString(REMEMBER_EMAIL, email);
  _sharedPreferences?.setString(REMEMBER_PASSWORD, password);
}

void clearCredentials() {
  _sharedPreferences?.remove(REMEMBER_EMAIL);
  _sharedPreferences?.remove(REMEMBER_PASSWORD);
}

String getSavedEmail() {
  return _sharedPreferences?.getString(REMEMBER_EMAIL) ?? '';
}

String getSavedPassword() {
  return _sharedPreferences?.getString(REMEMBER_PASSWORD) ?? '';
}


}
