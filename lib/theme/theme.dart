import 'package:flutter/material.dart';
import 'app_colors.dart';


class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(0XFF270FFB, primaryColorScheme),
      ),
      scaffoldBackgroundColor: const Color(0xFFFDFDFD),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFDFDFD),
        surfaceTintColor: Color(0xFFFDFDFD),
      ));
}
