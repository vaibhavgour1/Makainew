
import 'package:flutter/material.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/text_styles.dart';

/// Application Theme
final appTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColor.chatBgColor,
    textTheme: ThemeData.light(useMaterial3: true).textTheme.copyWith(
          bodyMedium: textRegular, // default text widget
        ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.textColor,
      titleTextStyle: textBold.copyWith(fontSize: 18),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF4A4A4A),
      selectedColor: AppColor.primaryColor,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    splashColor: Colors.transparent);
