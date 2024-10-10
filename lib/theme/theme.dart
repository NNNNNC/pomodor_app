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
      color: Color.fromRGBO(70, 130, 180, 1),
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

ThemeData forest_theme = ThemeData(
  primaryColor: Colors.green[800],
  primaryColorDark: Colors.green[900],
  disabledColor: Colors.brown[300],
  highlightColor: Colors.green[300],
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.dark(
    background: Color.fromRGBO(34, 45, 34, 1), // Deep forest green
    primary: Color.fromRGBO(21, 71, 52, 1), // Dark green
    secondary: Color.fromRGBO(143, 188, 143, 1), // Sage green
    primaryContainer: Color(0xff4CBB17), // Bright green
    secondaryContainer: Color(0xffB8860B), // Golden brown
    tertiaryContainer: Color(0xff556B2F), // Olive green
    surface: Color(0xff3a3a2f), // Earthy tone
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.greenAccent[100], // Light green accent
    ),
    displaySmall: TextStyle(
      color: Color.fromARGB(255, 210, 207, 207),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.lightGreen[100], // Pale green title
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.green[200], // Light forest green body
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff6B8E23), // Olive green
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 23,
      color: Colors.greenAccent[100],
    ),
    backgroundColor: Color(0xff2E8B57), // Sea green app bar
  ),
);

ThemeData purple_modern_theme = ThemeData(
  primaryColor: Colors.deepPurple[800],
  primaryColorDark: Colors.deepPurple[900],
  disabledColor: Colors.grey[400],
  highlightColor: Colors.deepPurple[300],
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.dark(
    background: Color(0xff1E1E2F), // Dark purple background
    primary: Colors.deepPurple, // Deep purple
    secondary: const Color.fromARGB(255, 186, 104, 200), // Light purple
    primaryContainer: Colors.purple[600], // Medium purple
    secondaryContainer: Colors.purple[400], // Soft purple
    tertiaryContainer: Colors.purple[700], // Darker purple
    surface: Color(0xff2B2B3D), // Dark surface
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white, // White for large titles
    ),
    displaySmall: TextStyle(
      color: Color.fromARGB(255, 210, 207, 207),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.purple[200], // Light purple for titles
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.purple[100], // Light purple for body text
    ),
    bodySmall: TextStyle(
      color: Colors.purple[50], // Very light purple for small body text
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple[400], // Bright purple for FAB
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor:
        Colors.deepPurple[800], // Dark purple background for bottom bar
    selectedItemColor: Colors.purple[200], // Light purple for selected items
    unselectedItemColor: Colors.purple[100], // Light gray for unselected items
    type: BottomNavigationBarType.fixed,
    elevation: 8.0,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 23,
      color: Colors.white, // White for app bar title
    ),
    backgroundColor: Colors.deepPurple[800], // Dark purple app bar
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.purple[200], // Light purple cursor color
    selectionColor: Colors.purple[300], // Light purple selection color
    selectionHandleColor: Colors.purple[400], // Medium purple selection handle
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.deepPurple[700], // Dark purple for list tiles
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.deepPurple[900], // Very dark purple for popups
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 12,
    ),
  ),
);

ThemeData wooden_theme = ThemeData(
  primaryColor: Colors.brown[800],
  primaryColorDark: Colors.brown[900],
  disabledColor: Colors.brown[300],
  highlightColor: Colors.amber[400],
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.dark(
    background: Color(0xff4E342E), // Dark brown background
    primary: Color(0xff3E2723), // Deep brown
    secondary: Color(0xffA1887F), // Light brown
    primaryContainer: Color(0xff8D6E63), // Medium brown
    secondaryContainer: Color(0xffFFD54F), // Soft amber
    tertiaryContainer: Color(0xff6D4C41), // Mahogany
    surface: Color(0xff5D4037), // Brown surface
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.amber[100], // Soft amber for large titles
    ),
    displaySmall: TextStyle(
      color: Color.fromARGB(255, 210, 207, 207),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.amber[200], // Light amber title
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.brown[200], // Light brown for body text
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xffD7CCC8), // Beige floating action button
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 23,
      color:
          const Color.fromARGB(255, 215, 207, 183), // Light amber app bar title
    ),
    backgroundColor: Color(0xff3E2723), // Dark brown app bar
  ),
);

ThemeData underwater_theme = ThemeData(
  primaryColor: Colors.teal[800], // Deep teal for primary color
  primaryColorDark: Colors.teal[900], // Darker teal for dark mode
  disabledColor: Colors.grey[600], // Dimmed grey for disabled elements
  highlightColor: Colors.teal[300], // Aqua highlight color
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.dark(
    background: Color(0xff001f2b), // Very dark blue for background
    primary:
        const Color.fromARGB(255, 0, 137, 123), // Teal for primary elements
    secondary: const Color.fromARGB(
        255, 77, 208, 225), // Light cyan for secondary elements
    primaryContainer: Colors.teal[700], // Darker teal for primary container
    secondaryContainer: Colors.cyan[200], // Softer cyan for secondary container
    tertiaryContainer: Colors.teal[800], // Very dark teal for tertiary elements
    surface: Color(0xff002b36), // Dark surface color resembling ocean depths
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white, // White for large titles
    ),
    displaySmall: TextStyle(
      color: Colors.cyan[300], // Light cyan for small display text
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.cyan[100], // Light cyan for titles
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.cyan[50], // Very light cyan for body text
    ),
    bodySmall: TextStyle(
      color: Colors.white70, // Softer white for small body text
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.cyan[400], // Bright cyan for FAB
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.teal[800], // Deep teal background for bottom bar
    selectedItemColor: Colors.cyan[200], // Light cyan for selected items
    unselectedItemColor: Colors.cyan[100], // Lighter cyan for unselected items
    type: BottomNavigationBarType.fixed,
    elevation: 8.0,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 23,
      color: Colors.white, // White for app bar title
    ),
    backgroundColor: Colors.teal[700], // Dark teal app bar
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.cyan[200], // Light cyan cursor color
    selectionColor: Colors.cyan[300], // Light cyan selection color
    selectionHandleColor:
        Colors.cyan[400], // Brighter cyan for selection handle
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.teal[600], // Deep teal for list tiles
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.teal[900], // Very dark teal for popups
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 12,
    ),
  ),
);

ThemeData desert_theme = ThemeData(
  primaryColor: Colors.orange[800],
  primaryColorDark: Colors.orange[900],
  disabledColor: Colors.brown[200],
  highlightColor: Colors.amber[600],
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.light(
    background: Color(0xffFFF3E0), // Light sand background
    primary: Color(0xffFF9800), // Desert orange
    secondary: Color(0xffFFB74D), // Light amber
    primaryContainer: Color(0xffF57C00), // Burnt orange
    secondaryContainer: Color(0xffFFE0B2), // Pale sand
    tertiaryContainer: Color(0xffBF360C), // Deep desert brown
    surface: Color(0xffFBE9E7), // Soft sand surface
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 228, 156, 46), // Pale orange title
    ),
    displaySmall: TextStyle(
      color: Color.fromARGB(255, 113, 113, 112),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.orange[200], // Light orange title
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.orange[300], // Orange body text
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xffFF6F00), // Vibrant orange button
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 23,
      color: Colors.orange[200], // Light orange app bar title
    ),
    backgroundColor: Color(0xffFF9800), // Deep orange app bar
  ),
);

ThemeData rosy_theme = ThemeData(
  primaryColor: Colors.pink[600], // Warm pink for primary color
  primaryColorDark: Colors.pink[900], // Darker pink for dark mode
  disabledColor: Colors.grey[300], // Soft grey for disabled elements
  highlightColor: Colors.pink[200], // Light pink highlight color
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.light(
    background: Color(0xfffff0f5), // Soft rosy white for background
    primary: const Color.fromARGB(
        255, 240, 98, 146), // Light pink for primary elements
    secondary: const Color.fromARGB(
        255, 248, 187, 208), // Very light pink for secondary elements
    primaryContainer: Colors.pink[400], // Medium pink for primary container
    secondaryContainer: Colors.pink[200], // Soft pink for secondary container
    tertiaryContainer: Colors.pink[500], // Darker pink for tertiary elements
    surface: Colors.white, // Clean white for surfaces
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.pink[800], // Darker pink for large display text
    ),
    displaySmall: TextStyle(
      color: Colors.pink[600], // Medium pink for small display text
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.pink[700], // Slightly darker pink for titles
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey[800], // Dark grey for body text
    ),
    bodySmall: TextStyle(
      color: Colors.pink[500], // Softer pink for small body text
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.pink[400], // Medium pink for FAB
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.pink[50], // Light pink background for bottom bar
    selectedItemColor: Colors.pink[700], // Darker pink for selected items
    unselectedItemColor: Colors.pink[400], // Lighter pink for unselected items
    type: BottomNavigationBarType.fixed,
    elevation: 8.0,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 23,
      color: Colors.pink[900], // Darker pink for app bar title
    ),
    backgroundColor: Colors.pink[300], // Light pink app bar
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.pink[600], // Medium pink cursor color
    selectionColor: Colors.pink[300], // Light pink selection color
    selectionHandleColor:
        Colors.pink[400], // Slightly brighter pink for selection handle
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.pink[100], // Very light pink for list tiles
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.pink[200], // Light pink for popups
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.pink[900], // Dark pink for popup text
      fontSize: 12,
    ),
  ),
);

ThemeData zen_theme = ThemeData(
  primaryColor: Colors.blueGrey[200], // Soft blue-grey
  primaryColorDark: Colors.blueGrey[700], // Darker tone for primary elements
  disabledColor: Colors.blueGrey[400], // Muted for disabled elements
  highlightColor: Colors.lightGreenAccent[100], // Gentle accent color
  fontFamily: 'DMSans',
  colorScheme: ColorScheme.light(
    background: Color.fromRGBO(240, 248, 245, 1), // Light and airy background
    primary: Color.fromRGBO(
        115, 134, 129, 1), // Soft grey-green for primary elements
    secondary:
        Color.fromRGBO(186, 220, 215, 1), // Pale green for secondary elements
    primaryContainer: const Color(0xff8cb3a0), // Light teal for containers
    secondaryContainer:
        const Color(0xffd0e6df), // Softer version for secondary containers
    tertiaryContainer: const Color(0xffb2c2c1), // Soft neutral blue
    surface: Color.fromARGB(255, 110, 155, 127), // Light neutral surface color
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey[800],
      shadows: CupertinoContextMenu.kEndBoxShadow,
    ),
    displaySmall: TextStyle(
      color: Colors.blueGrey[600],
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    // title font style
    titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color.fromRGBO(115, 134, 129, 1)),
    titleMedium:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
    titleSmall:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey[500]),
    bodyMedium:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey[700]),
    bodySmall:
        TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
      color: Colors.blueGrey[300],
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
        color: const Color.fromARGB(255, 169, 192, 203),
        fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
      color: Colors.blueGrey[200],
      fontSize: 12,
      fontWeight: FontWeight.w100,
    ),
  ),
  // floating button style
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(186, 220, 215, 1), // Pale green for FAB
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:
          Color.fromRGBO(115, 134, 129, 1), // Soft grey-green background
      type: BottomNavigationBarType.fixed,
      elevation: 8.0),
  appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23,
          color: Colors.blueGrey[800]),
      backgroundColor: Color.fromRGBO(115, 134, 129, 1),
      elevation: 8.0),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.blueGrey[600],
    selectionColor: Colors.lightGreenAccent[200],
    selectionHandleColor: Colors.lightGreenAccent[200],
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.blueGrey[50], // Very light grey-blue for list tiles
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Color.fromARGB(
        208, 207, 227, 224), // Calm, muted greenish tones for popup
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey[800],
      fontSize: 12,
    ),
  ),
);
