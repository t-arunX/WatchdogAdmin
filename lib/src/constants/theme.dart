import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF343541);
  static const Color sidebarBackground = Color(0xFF202123);
  static const Color assistantMessageBackground = Color(0xFF444654);
  static const Color userMessageBackground = Color(0xFF343541); // Transparent/Same as bg usually
  static const Color inputBackground = Color(0xFF40414F);
  static const Color textPrimary = Color(0xFFECECF1);
  static const Color textSecondary = Color(0xFFC5C5D2);
  static const Color primaryAction = Color(0xFF10A37F);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primaryAction,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.sidebarBackground,
        elevation: 0,
        titleTextStyle: TextStyle(color: AppColors.textPrimary),
        iconTheme: IconThemeData(color: AppColors.textSecondary),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.sidebarBackground,
      ),
    );
  }
}
