// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ThemeData app_theme = ThemeData(
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.dark(
      background: Color.fromRGBO(37, 37, 37, 1),
      primary: Color.fromRGBO(21, 21, 21, 1),
      secondary: Color.fromRGBO(172, 198, 255, 1)),
  textTheme: TextTheme(
      // title font style
      titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color.fromRGBO(172, 198, 255, 1)),
      titleMedium: TextStyle(
          fontWeight: FontWeight.bold, color: Color.fromRGBO(172, 198, 255, 1)),
      titleSmall: TextStyle(
          fontWeight: FontWeight.bold, color: Color.fromRGBO(158, 158, 158, 1)),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.bold, color: Color.fromRGBO(192, 192, 192, 1)),
      bodySmall: TextStyle(
          color: Color.fromRGBO(158, 158, 158, 1), fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          color: Color.fromRGBO(158, 158, 158, 1), fontWeight: FontWeight.bold),
      labelSmall: TextStyle(
          color: Color.fromRGBO(172, 198, 255, 1),
          fontWeight: FontWeight.bold)),
  // floating button style
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(172, 198, 255, 1),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(21, 21, 21, 1),
      type: BottomNavigationBarType.fixed,
      elevation: 8.0),
  appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23,
          color: Color.fromRGBO(192, 192, 192, 1)),
      backgroundColor: Color.fromRGBO(21, 21, 21, 1),
      elevation: 8.0),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.red,
    selectionHandleColor: Colors.red,
  ),
);
