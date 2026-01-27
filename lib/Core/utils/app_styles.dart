import 'package:flutter/material.dart';

abstract final class AppStyles {
  //! Regular => 400
  static TextStyle textStyleRegular14({Color? color}) {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color);
  }

  static TextStyle textStyleRegular16({Color? color}) {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color);
  }

  //! Medium => 500
  static TextStyle textStyleMedium14({Color? color}) {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color);
  }

  static TextStyle textStyleMedium16({Color? color}) {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color);
  }

  static TextStyle textStyleMedium18({Color? color}) {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color);
  }

  static TextStyle textStyleMedium20({Color? color}) {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: color);
  }

  //! SemiBold => 600
  static TextStyle textStyleSemiBold14({Color? color}) {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle textStyleSemiBold20({Color? color}) {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle textStyleSemiBold24({Color? color}) {
    return TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: color);
  }
}
