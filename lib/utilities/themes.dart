// theme.dart

import 'package:flutter/material.dart';

// Define the theme settings
class AppTheme {
  static const _lightPrimaryColor = Colors.green;
  static const _lightSecondaryColor = Color(0xFF9E9E9E);
  static const _darkPrimaryColor = Color(0xFF2196F3);
  static const _darkSecondaryColor = Color(0xFF212121);

  static const _lightTextColor = Color(0xFF000000);
  static const _darkTextColor = Color(0xFFFFFFFF);

  static const _lightButtonColor = Colors.green;
  static const _darkButtonColor = Color(0xFF212121);

  static const _lightButtonTextColor = Colors.black;
  static const _darkButtonTextColor = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _lightPrimaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: _lightSecondaryColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: _lightPrimaryColor,
        titleTextStyle: TextStyle(
          color: _lightTextColor,
          fontSize: 20,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: _lightTextColor,
          fontSize: 24,
        ),
        titleMedium: TextStyle(
          color: _lightTextColor,
          fontSize: 20,
        ),
        titleSmall: TextStyle(
          color: _lightTextColor,
          fontSize: 18,
        ),
        bodyLarge: TextStyle(
          color: _lightTextColor,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: _lightTextColor,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: _lightTextColor,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: _lightTextColor,
          fontSize: 16,
        ),
        labelMedium: TextStyle(
          color: _lightTextColor,
          fontSize: 14,
        ),
        labelSmall: TextStyle(
          color: _lightTextColor,
          fontSize: 12,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _lightButtonColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightButtonColor,
          foregroundColor: _lightButtonTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _darkPrimaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: _darkSecondaryColor,
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: _darkPrimaryColor,
        titleTextStyle: TextStyle(
          color: _darkTextColor,
          fontSize: 20,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: _darkTextColor,
          fontSize: 24,
        ),
        titleMedium: TextStyle(
          color: _darkTextColor,
          fontSize: 20,
        ),
        titleSmall: TextStyle(
          color: _darkTextColor,
          fontSize: 18,
        ),
        bodyLarge: TextStyle(
          color: _darkTextColor,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: _darkTextColor,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: _darkTextColor,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: _darkTextColor,
          fontSize: 16,
        ),
        labelMedium: TextStyle(
          color: _darkTextColor,
          fontSize: 14,
        ),
        labelSmall: TextStyle(
          color: _darkTextColor,
          fontSize: 12,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _darkButtonColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkButtonColor,
          foregroundColor: _darkButtonTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
