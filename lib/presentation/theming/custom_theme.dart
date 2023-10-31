import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

/// The custom theme for the app
class CustomTheme {
  static ThemeData commonTheme = ThemeData(
    timePickerTheme: const TimePickerThemeData(
      dialHandColor: K.primaryBlue,
      dialBackgroundColor: Colors.transparent,
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    ),
  );

  /// The light theme for the app
  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: K.white,
    colorScheme: const ColorScheme.light(
      primary: K.black,
    ),
    cardTheme: const CardTheme(
      color: K.cardsLightBackgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: K.white,
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: K.black,
      displayColor: K.black,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    timePickerTheme: commonTheme.timePickerTheme,
    dialogTheme: commonTheme.dialogTheme,
  );

  /// The dark theme for the app
  static ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: K.black,
    colorScheme: const ColorScheme.dark(
      primary: K.white,
    ),
    cardTheme: CardTheme(
      color: K.white5,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: K.black,
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: K.white,
      displayColor: K.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    timePickerTheme: commonTheme.timePickerTheme,
    dialogTheme: commonTheme.dialogTheme,
  );

  /// The Dark theme for login screen
  static ThemeData loginScreenDarkTheme = darkTheme.copyWith(
    cardTheme: const CardTheme(
      color: K.black,
    ),
  );

  /// The Light theme for login screen
  static ThemeData loginScreenLightTheme = lightTheme.copyWith(
    cardTheme: const CardTheme(
      color: K.white,
    ),
  );

  /// The light theme for auth screens
  static ThemeData authScreensLightTheme = lightTheme.copyWith(
    scaffoldBackgroundColor: K.cardsLightBackgroundColor,
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
  );
}
