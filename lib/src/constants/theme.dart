import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF); // Example modern purple
  static const Color accentColor = Color(0xFF00E676); // Example vibrant green
  static const Color backgroundColor = Color(0xFF1E1E2C); // Dark background like Termius
  static const Color surfaceColor = Color(0xFF2D2D44); // Slightly lighter for cards
  static const Color glassColor = Color(0x20FFFFFF); // White with low opacity for glass

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      cardColor: surfaceColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        background: backgroundColor,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      useMaterial3: true,
    );
  }
}
