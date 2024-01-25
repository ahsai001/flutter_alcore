import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var purple200 = const Color(0xFFBB86FC);
var purple500 = const Color(0xFF6200EE);
var purple700 = const Color(0xFF3700B3);
var teal200 = const Color(0xFF03DAC5);

var puhbaPrimary = const Color.fromARGB(255, 68, 183, 189);
var puhbaPrimaryVariant = purple500;
var puhbaSecondary = teal200;
var facebookColor = const Color(0xFF3B5998);
var googleColor = Colors.white;

var topBarColor = Colors.white;
var puhbaTextColor = const Color(0xFF868686);

double imageAspectRatio = 3 / 4;

var lightColorScheme = ColorScheme.light(
    primary: puhbaPrimary,
    onPrimary: Colors.white,
    secondary: puhbaSecondary,
    onSecondary: Colors.white);

var darkColorScheme = ColorScheme.dark(
    primary: puhbaPrimary,
    onPrimary: Colors.white,
    secondary: puhbaSecondary,
    onSecondary: Colors.white);

var bottomNavBarThemeData = BottomNavigationBarThemeData(
  selectedItemColor: puhbaTextColor,
  unselectedItemColor: puhbaTextColor.withAlpha(100),
  selectedIconTheme: IconThemeData(color: puhbaPrimary),
  unselectedIconTheme: IconThemeData(color: puhbaPrimary),
  showSelectedLabels: true,
  showUnselectedLabels: true,
  backgroundColor: Colors.transparent,
);

var lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: lightColorScheme,
    iconTheme: IconThemeData(color: puhbaTextColor),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(iconColor: MaterialStateProperty.all(puhbaPrimary))),
    bottomNavigationBarTheme: bottomNavBarThemeData,
    hintColor: puhbaTextColor,
    textTheme: GoogleFonts.poppinsTextTheme(Typography.whiteCupertino
        .apply(bodyColor: puhbaTextColor, displayColor: puhbaTextColor)
        .copyWith(
          // displayLarge: TextStyle(color: puhbaPrimary),
          // displayMedium: TextStyle(color: puhbaPrimary),
          // displaySmall: TextStyle(color: puhbaPrimary),
          // headlineLarge: TextStyle(color: puhbaPrimary),
          // headlineMedium: TextStyle(color: puhbaPrimary),
          headlineSmall: TextStyle(color: lightColorScheme.onBackground),
          titleLarge: TextStyle(color: lightColorScheme.onBackground),
          titleMedium: TextStyle(color: lightColorScheme.primary),
          // titleSmall: TextStyle(color: puhbaPrimary),
          // bodyLarge: TextStyle(color: puhbaPrimary),
          // bodyMedium: TextStyle(color: puhbaPrimary),
          // bodySmall: TextStyle(color: puhbaPrimary),
          // labelLarge: TextStyle(color: puhbaPrimary),
          // labelMedium: TextStyle(color: puhbaPrimary),
          // labelSmall: TextStyle(color: puhbaPrimary),
        )));
var darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: darkColorScheme,
    iconTheme: IconThemeData(color: puhbaTextColor),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(iconColor: MaterialStateProperty.all(puhbaPrimary))),
    bottomNavigationBarTheme: bottomNavBarThemeData,
    hintColor: puhbaTextColor,
    textTheme: GoogleFonts.poppinsTextTheme(Typography.blackCupertino
        .apply(bodyColor: puhbaTextColor, displayColor: puhbaTextColor)
        .copyWith(
          // displayLarge: TextStyle(color: puhbaPrimary),
          // displayMedium: TextStyle(color: puhbaPrimary),
          // displaySmall: TextStyle(color: puhbaPrimary),
          // headlineLarge: TextStyle(color: puhbaPrimary),
          // headlineMedium: TextStyle(color: puhbaPrimary),
          headlineSmall: TextStyle(color: darkColorScheme.onBackground),
          titleLarge: TextStyle(color: darkColorScheme.onBackground),
          titleMedium: TextStyle(color: darkColorScheme.primary),
          // titleSmall: TextStyle(color: puhbaPrimary),
          // bodyLarge: TextStyle(color: puhbaPrimary),
          // bodyMedium: TextStyle(color: puhbaPrimary),
          // bodySmall: TextStyle(color: puhbaPrimary),
          // labelLarge: TextStyle(color: puhbaPrimary),
          // labelMedium: TextStyle(color: puhbaPrimary),
          // labelSmall: TextStyle(color: puhbaPrimary),
        )));
