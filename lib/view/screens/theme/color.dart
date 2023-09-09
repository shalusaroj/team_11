import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


ThemeData themeData = ThemeData(
  primaryColor: const Color(0xFFfb333b),
  canvasColor: const Color(0xFFfb333b),
  secondaryHeaderColor: const Color(0xFFfb333b),
  disabledColor: const Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: const Color(0xff28335b),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF01509b),
    ),
  ),
  textTheme: GoogleFonts.interTextTheme(),
);
