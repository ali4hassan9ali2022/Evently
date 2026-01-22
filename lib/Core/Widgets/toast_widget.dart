import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToastWidget {
  static void showSuccessToast(String message) {
    _showToast("$message ✅", Colors.green, Icons.check_circle);
  }

  static void showErrorToast(String message) {
    _showToast("$message 🛑", Colors.red, Icons.cancel);
  }

  static void showWarningToast(String message) {
    _showToast("$message ⚠", Colors.orange, Icons.warning);
  }

  static void showInfoToast(String message) {
    _showToast("$message ❕", Colors.blue, Icons.info);
  }

  static void _showToast(String message, Color backgroundColor, IconData icon) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );

    // You can use this logic to show a custom Toast with an icon beside the message.
    // For now, FlutterToast doesn't allow custom widgets, so you can display the default toast with the background color and message.
    // However, if you want a widget-based toast, you can implement a custom overlay or use a package like overlay_support.
  }
}