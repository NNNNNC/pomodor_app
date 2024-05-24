// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ThemeData app_theme = ThemeData(
  primaryColor: Colors.grey,
  primaryColorDark: Colors.grey[900],
  disabledColor: Colors.grey[850],
  highlightColor: Colors.grey[300],
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.dark(
    background: Color.fromRGBO(37, 37, 37, 1),
    primary: Color.fromRGBO(21, 21, 21, 1),
    secondary: Color.fromRGBO(172, 198, 255, 1),
    primaryContainer: const Color(0xffc50e0e),
    secondaryContainer: const Color(0xff1dc50e),
    tertiaryContainer: const Color(0xff0e15c5),
    surface: const Color(0xff3a3939),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white70,
      shadows: CupertinoContextMenu.kEndBoxShadow,
    ),
    displaySmall: TextStyle(
      color: Color.fromARGB(255, 210, 207, 207),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
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
    labelLarge: TextStyle(
      color: Colors.grey[300],
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
        color: Color.fromRGBO(158, 158, 158, 1), fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w100,
    ),
  ),
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
  listTileTheme: ListTileThemeData(
    tileColor: Colors.grey,
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Color.fromARGB(208, 107, 106, 106),
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 12,
    ),
  ),
);

ThemeData app_theme_light = ThemeData(
  fontFamily: 'DMSans',
  primaryColor: Colors.blue,
  primaryColorDark: Colors.blue[900],
  disabledColor: Colors.grey[200],
  highlightColor: Colors.grey[850],
  colorScheme: ColorScheme.light(
    background: Color.fromRGBO(245, 245, 245, 1), // Light grey background
    primary: Color.fromRGBO(255, 255, 255, 1), // White primary color
    secondary: Color.fromRGBO(70, 130, 180, 1), // Steel blue secondary color
    primaryContainer: Colors.red,
    secondaryContainer: Colors.green,
    tertiaryContainer: Colors.blue,
    surface: Colors.grey[300]!,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(164, 0, 0, 0),
      shadows: CupertinoContextMenu.kEndBoxShadow,
    ),
    displaySmall: TextStyle(
      color: Colors.black54,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    // Title font style
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Color.fromRGBO(70, 130, 180, 1), // Steel blue color
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(70, 130, 180, 1), // Steel blue color
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(100, 100, 100, 1), // Dark grey color
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(80, 80, 80, 1), // Dark grey color
    ),
    bodySmall: TextStyle(
      color: Color.fromRGBO(100, 100, 100, 1), // Dark grey color
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      color: Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: Color.fromRGBO(100, 100, 100, 1), // Dark grey color
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      color: Colors.black87,
      fontSize: 12,
      fontWeight: FontWeight.w100,
    ),
  ),
  // Floating button style
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(70, 130, 180, 1), // Steel blue color
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(255, 255, 255, 1), // White background
    type: BottomNavigationBarType.fixed,
    elevation: 8.0,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 23,
      color: Color.fromRGBO(80, 80, 80, 1), // Dark grey color
    ),
    backgroundColor: Color.fromRGBO(255, 255, 255, 1), // White background
    elevation: 8.0,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue,
    selectionHandleColor: Colors.blue,
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.grey[100],
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Color.fromARGB(208, 107, 106, 106),
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 12,
    ),
  ),
);
