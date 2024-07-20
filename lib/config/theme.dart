import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:offers_hub/features/home_page.dart';

class AppTheme extends ChangeNotifier {
  static appTextTheme() {
    return GoogleFonts.comfortaaTextTheme();
  }

  static ThemeData currentTheme = ThemeData(
      useMaterial3: true,
      textTheme: appTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFEEAEA),
      ));

  void changeCurrentTheme() {
    if (currentScreen == 2) {
      //nearbuyscreen
      currentTheme = ThemeData(
          useMaterial3: true,
          textTheme: appTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 248, 248, 248),
          ));
    } else if (currentScreen == 1) {
      //offers
      currentTheme = ThemeData(
          useMaterial3: true,
          textTheme: appTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFF8E2FA),
          ));
    } else {
      //reward
      currentTheme = ThemeData(
          useMaterial3: true,
          textTheme: appTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFEEAEA),
          ));
    }
    notifyListeners();
  }
}
