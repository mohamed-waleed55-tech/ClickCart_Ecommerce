import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ThemeManager {
  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF388E3C),
    primary: const Color(0xFF388E3C),
    onPrimary: Colors.white,
    secondary: const Color(0xFF6B7280),
    onSecondary: Colors.white,
    error: const Color(0xFFEF4444),
    surface: const Color(0xFFF9FAFB),
    onSurface: const Color(0xFF111827),
  );

  static final ThemeData light = ThemeData(
    fontFamily: "SourceSans-SemiBold",
    useMaterial3: true,
    colorScheme: _colorScheme,
    scaffoldBackgroundColor: _colorScheme.surface,

    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: _colorScheme.onSurface),
      titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: _colorScheme.onSurface),
      titleMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: _colorScheme.onSurface),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: _colorScheme.onSurface),
      bodySmall: TextStyle(fontSize: 14.sp, color: _colorScheme.secondary),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: _colorScheme.surface,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _colorScheme.onSurface),
      titleTextStyle: TextStyle(
        color: _colorScheme.onSurface,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "SourceSans",
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _colorScheme.primary,
        foregroundColor: _colorScheme.onPrimary,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _colorScheme.secondary.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _colorScheme.secondary.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _colorScheme.primary, width: 2),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );

  static final ThemeData dark = ThemeData();
}
