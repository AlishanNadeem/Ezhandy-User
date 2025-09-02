import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  ToastMessage({required String toastmsg}) {
    Fluttertoast.showToast(msg: toastmsg, toastLength: Toast.LENGTH_LONG);
  }
}
