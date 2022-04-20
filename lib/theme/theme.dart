import 'package:flutter/material.dart';
import 'package:case_study/theme/colors.dart';

abstract class ThemeSettings {
  static final myTheme = ThemeData.from(
    textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 16)),
    colorScheme: const ColorScheme.light(
      primary: ColorPalette.primary,
    ),
  ).copyWith(
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            padding: EdgeInsets.zero,
            minimumSize: Size.zero)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      minimumSize: const Size(80, 28),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      minimumSize: const Size(80, 28),
      side: const BorderSide(color: ColorPalette.primary),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    )),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF3F3F3),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      contentPadding: EdgeInsets.all(24),
    ),
  );
}
