import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';

abstract class ThemeApp {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.offWhite,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.blue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.white,
      border: AppHelper.outlineInputBorder(color: AppColor.lightGrey),
      enabledBorder: AppHelper.outlineInputBorder(color: AppColor.lightGrey),
      focusedBorder: AppHelper.outlineInputBorder(color: AppColor.lightGrey),
      hintStyle: AppStyles.textStyleRegular14().copyWith(color: AppColor.grey2),
    ),
    textTheme: TextTheme(
      titleLarge: AppStyles.textStyleMedium20(color: AppColor.black),
      titleMedium: AppStyles.textStyleMedium18(),
      titleSmall: AppStyles.textStyleMedium16(),
      bodyLarge: AppStyles.textStyleRegular16(),
      bodyMedium: AppStyles.textStyleRegular14(color: AppColor.grey),
      headlineLarge: AppStyles.textStyleSemiBold24(),
      headlineMedium: AppStyles.textStyleSemiBold20(),
      headlineSmall: AppStyles.textStyleSemiBold14(color: AppColor.white),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.darkBlue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.dartBlue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.darkBlue2,
      border: AppHelper.outlineInputBorder(color: Color(0xff002678)),
      enabledBorder: AppHelper.outlineInputBorder(color: Color(0xff002678)),
      focusedBorder: AppHelper.outlineInputBorder(color: Color(0xff002678)),
      hintStyle: AppStyles.textStyleRegular14().copyWith(
        color: AppColor.darkGrey,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: AppStyles.textStyleMedium20(color: AppColor.white),
      titleMedium: AppStyles.textStyleMedium18(),
      titleSmall: AppStyles.textStyleMedium16(),
      bodyLarge: AppStyles.textStyleRegular16(),
      bodyMedium: AppStyles.textStyleRegular14(color: AppColor.darkGrey),
      headlineLarge: AppStyles.textStyleSemiBold24(),
      headlineMedium: AppStyles.textStyleSemiBold20(),
      headlineSmall: AppStyles.textStyleSemiBold14(color: AppColor.white),
    ),
  );
}
