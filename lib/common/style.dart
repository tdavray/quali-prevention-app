import 'package:flutter/material.dart';

final ThemeData kTheme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    errorMaxLines: 10,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
  ),
  searchBarTheme: SearchBarThemeData(
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 18)),
    elevation: const WidgetStatePropertyAll(0),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: primary, width: 1),
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(primaryBackground),
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        color: primary,
        fontSize: 16,
        height: 1,
        fontWeight: FontWeight.w500,
        fontFamily: 'Made Tommy',
      ),
    ),
  ),
);

Color primary = const Color(0xFF003C4E);
Color primaryBackground = const Color(0xFFE5ECED);
Color secondary = const Color(0xFF2F52A9);

Color textPrimary = const Color(0xFF00607C);
Color textBlack = const Color(0xFF333333);
Color textSecondary = const Color(0xFF2F52A9);

Color white = Colors.white;
Color grey = const Color(0xFFE5E7E7);
Color darkGrey = const Color(0xFF434343);
