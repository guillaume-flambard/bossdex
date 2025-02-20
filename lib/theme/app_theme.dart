import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightColors = ColorScheme.fromSeed(
    seedColor: const Color(0xFF2563EB),
    brightness: Brightness.light,
  );

  static final darkColors = ColorScheme.fromSeed(
    seedColor: const Color(0xFF2563EB),
    brightness: Brightness.dark,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColors,
    textTheme: GoogleFonts.poppinsTextTheme(),
    scaffoldBackgroundColor: Colors.grey[50],
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColors,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: Colors.grey[900],
    cardTheme: CardTheme(
      color: Colors.grey[850],
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[850],
    ),
  );
} 