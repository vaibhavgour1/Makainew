import 'package:flutter/material.dart' show Alignment, Color, Colors, Gradient, LinearGradient, immutable;

/// [AppColor] class which contains all colors used in project
@immutable
final class AppColor {
  /// private constructor to avoid create instance
  const AppColor._();

  /// this primary color
  static const primaryColor = Color(0xFFFF3000);

  /// this secondary color
  static const secondaryColor = Color(0xFF00F0FF);

  static const Color accentColor = Color(0xFFF709FD);

  /// this scaffold color
  static const scaffoldBgColor = Color(0xFF3C3C3B);
  static const appBackgroundBlueColor = Color(0xFF5367FC);
  static const appBackgroundDarkColor = Color(0xFF333332);

  /// this appbar color
  static const appbarBgColor = Color(0xFF3C3C3B);

  /// button color primary
  static const Color buttonPrimaryColor = Color(0xFFFF3000);

  /// button color secondary
  static const Color buttonSecondaryColor = Color(0xff4a4a4a);

  /*********  Put All Text Colors in this region only **********/

  /// text color
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textColorSecondary = Color(0xFF6F6F78);
  static const Color textBlueColor = Color(0xFF3369FF);
  static const Color textRedColor = Color(0xFFBB0000);
  static const Color textGreenColor = Color(0xFF008490);

  /// text dark color
  static const Color textDarkColor = Color(0xFF3C3C3B);

  /// text hint color
  static const Color textHintColor = Color(0xFF1B4332);

  static const Color textFieldSecondaryColor = Color(0x40FFFFFF);
  static const Color textFieldColor = Color(0xFFEFEFEF);

  static const Color textTertiary = Color(0xFF2C2C2B);
  static const Color placeholderColor = Color(0xCC3C3C3B);
  static const Color errorColor = Color(0xFFFE0257);
  static const Color colorHint = Color(0xff9FA2AA);
  static const Color rediousfillcolot = Color(0xffD9D9D9);
  static const Color bordercolor = Color(0xffEAEAEA);



  /// ****************


  static const Color black = Color(0xFF231F20);
  static const Color chatBgColor = Color(0xFFF5F5F5);
  static const Color chatRedBgColor = Color(0xFFFFE0E0);
  static const Color chatBlueBgColor = Color(0xFFB9C2FB);

  static const Color white = Colors.white;
  static const Color backGroundColor = Color(0XFFF2F2F2);
  static const Color darkBlue = Color(0XFF0E59C4);
  static const Color grey = Colors.grey;
  // static const Gradient gradientRedPink = LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [
  //     purple,
  //     errorColor,
  //   ],
  // );
  static const Color textSecondaryLight = Color(0xFFD9D9D9);
}
