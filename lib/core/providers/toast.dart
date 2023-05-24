//Package Dependancy
import 'package:fluttertoast/fluttertoast.dart' as toast;

class Toast {
  static void show(String message) {
    toast.Fluttertoast.showToast(
      msg: message,
      toastLength: toast.Toast.LENGTH_LONG,
      gravity: toast.ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0
    );
  }
}