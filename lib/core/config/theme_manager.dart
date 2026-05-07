import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeManager {
  static final ColorScheme colorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF10B981),
    onPrimary: Colors.white,
    secondary: Colors.grey,
    onSecondary: Colors.black,
    error: Color(0xFFEF4444),
    onError: Colors.white,
    background: Color(0xFFF9FAFB),
    onBackground: Color(0xFF111827),
    surface: Colors.white,
    onSurface: Color(0xFF111827),
  );

  static final ThemeData light = ThemeData(
    fontFamily: "SourceSans",
    useMaterial3: true,
    colorScheme: colorScheme,

    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
      titleMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSecondary,
      ),
      titleLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSecondary,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: colorScheme.secondary.withOpacity(0.9),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
  static final ThemeData dark = ThemeData();
}
