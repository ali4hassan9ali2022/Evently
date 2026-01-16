import 'package:evently/Core/utils/app_color.dart';
import 'package:flutter/material.dart';

abstract final class AppStyles {
  //! Regular => 400
  TextStyle textStyleRegular14() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.black,
    );
  }
  TextStyle textStyleRegular16() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.black,
    );
  }
  //! Medium => 500
  TextStyle textStyleMedium16() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.blue,
    );
  }
  TextStyle textStyleMedium18() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColor.blue,
    );
  }
  TextStyle textStyleMedium20() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColor.white,
    );
  }
  //! SemiBold => 600
  TextStyle textStyleSemiBold14() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColor.blue,
    );
  }
  TextStyle textStyleSemiBold20() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.grey,
    );
  }
  TextStyle textStyleSemiBold24() {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColor.blue,
    );
  }
}