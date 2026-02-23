import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager {
  static final ConnectivityManager _instance = ConnectivityManager._internal();
  final Connectivity _connectivity = Connectivity();

  factory ConnectivityManager() {
    return _instance;
  }

  ConnectivityManager._internal();

  /// Checks if the device is connected to the internet
  Future<bool> isInternetConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Additional check to verify actual internet access
    return await _hasActiveInternetConnection();
  }

  /// Checks if actual internet is accessible by pinging Google
  Future<bool> _hasActiveInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
