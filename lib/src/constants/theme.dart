import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Main Backgrounds
  static const Color background = Color(0xFF343541); // Main chat bg
  static const Color sidebarBackground = Color(0xFF202123); // Sidebar bg
  
  // Message Backgrounds
  static const Color assistantMessageBackground = Color(0xFF444654);
  static const Color userMessageBackground = Color(0xFF343541); // Matches main bg
  
  // Input Area
  static const Color inputBackground = Color(0xFF40414F);
  static const Color inputBorder = Color(0xFF565869); // Subtle border
  
  // Text Colors
  static const Color textPrimary = Color(0xFFECECF1);
  static const Color textSecondary = Color(0xFFC5C5D2);
  static const Color textDiscreet = Color(0xFF8E8EA0); // For the footer disclaimer
  
  // Accents / Buttons
  static const Color primaryAction = Color(0xFF19C37D); // ChatGPT Green
  static const Color primaryActionHover = Color(0xFF1A7F64);
  static const Color newChatButton = Color(0xFF202123); // Matches sidebar but has border
  static const Color iconColor = Color(0xFFD9D9E3);

  // Avatars
  static const Color userAvatarColor = Color(0xFF5436DA); // Example purple for user
  static const Color gptAvatarColor = Color(0xFF19C37D); // Green logo
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primaryAction,
      brightness: Brightness.dark,
      
      // Typography
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.iconColor),
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background, // Mobile header often blends or is slightly dark
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: AppColors.textSecondary),
      ),
      
      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.sidebarBackground,
      ),
      
      // Input Decoration (Defaults)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintStyle: const TextStyle(color: Colors.white38),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12),
           borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12),
           borderSide: BorderSide.none,
        ),
      ),
      
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryAction,
        selectionColor: Color(0xFF1A7F64), // Darker green
        selectionHandleColor: AppColors.primaryAction,
      )
    );
  }
}
