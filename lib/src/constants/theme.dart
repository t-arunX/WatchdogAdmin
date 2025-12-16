import 'package:flutter/material.dart';

class AppColors {
  // Deep dark background (Visual analysis of IMG_4372)
  static const Color background = Color(0xFF050509);

  // Sidebar / Surface colors
  static const Color sidebarBackground = Color(0xFF0F0F12);
  static const Color cardBackground = Color(0xFF1E1E2E);

  // Input area
  static const Color inputBackground = Color(0xFF1E1E2E); // Dark pill shape

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA1A1AA); // Light grey
  static const Color textDiscreet = Color(0xFF52525B); // Darker grey for disclaimers

  // Accents
  static const Color primary = Color(0xFF6D28D9); // Purple accent
  static const Color secondary = Color(0xFF10B981); // Green accent (e.g. for "Ready" badges)

  // Avatars
  static const Color userAvatarColor = Color(0xFF3F3F46);
  static const Color julesAvatarColor = Color(0xFF6D28D9); // Purple for Jules
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleTextStyle: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: AppColors.textSecondary),
      ),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.textPrimary),
        bodySmall: TextStyle(color: AppColors.textSecondary),
      ),

      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintStyle: const TextStyle(color: AppColors.textDiscreet),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Pill shape defaults
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
