import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff000000), // Color(0xFF2E2F36);
    cardColor: Color(0xfffbfafe),
    primaryColor: Color(0xFFd81e27),
    shadowColor: Color(0xFF324754).withOpacity(0.24),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.gruppo(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.4,
      ),
      headlineSmall: GoogleFonts.chango(
        color: Color(0xFFFFFFFF),
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: Color(0xFF324754),
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.montserrat(
        color: Color(0xFF324754),
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 12,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: Color(0xFF819ab1),
        fontSize: 12,
      ),
      labelLarge: GoogleFonts.montserrat(
        color: Colors.white,
        letterSpacing: 0.8,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}