import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/Constants.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Backgroundcolor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black), // For large text
        bodyMedium: TextStyle(color: Colors.black), // Default text
        bodySmall: TextStyle(color: Colors.black54), // Slightly faded text
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff2a569a),
          titleTextStyle: GoogleFonts.ibmPlexSansArabic(fontSize: 27)));
}
