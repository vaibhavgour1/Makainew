import 'package:flutter/material.dart'
    show Brightness, BuildContext, ColorScheme, MediaQuery, TextTheme, Theme, ThemeData;
import 'package:makaihealth/extensions/constants.dart';

/// extension for [BuildContext]
extension BuildContextEx on BuildContext {
  /// to get theme
  ThemeData get theme => Theme.of(this);

  /// to get colorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// to get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  // ThemeColors get themeColors => Theme.of(this).extension<ThemeColors>()!;

  /// to get width from media query
  double get width => MediaQuery.sizeOf(this).width;

  /// to get width in pixels
  double get widthPixel => MediaQuery.sizeOf(this).width * MediaQuery.of(this).devicePixelRatio;

  /// to get height from media query
  double get height => MediaQuery.sizeOf(this).height;

  /// to get height in pixels
  double get heightPixel => MediaQuery.sizeOf(this).height * MediaQuery.of(this).devicePixelRatio;

  /// to theme brightness [Brightness.dark] or [Brightness.light]
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  double get heightAspectRatio {
    return height / designSize.height;
  }

  double get widthAspectRatio {
    return width / designSize.width;
  }
}
