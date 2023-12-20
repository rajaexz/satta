import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/utilis/AllColor.dart';

class ThemeController extends GetxController {
  // Define custom color schemes for light and dark themes
  final ColorScheme lightColorScheme = ColorScheme.light(
    primary: myColor, // Customize the primary color for light theme
    secondary: myColorRed, // Customize the accent color for light theme
    onSecondary: myColorGray, // Customize the secondary color for light theme
  );

  final ColorScheme darkColorScheme = ColorScheme.dark(
    primary: myColorRed, // Customize the primary color for dark theme
    secondary: myColorWhite, // Customize the accent color for dark theme
    onSecondary: myColorGray, // Customize the secondary color for dark theme
  );

  // Create an observable theme mode
  final Rx<ThemeMode> currentThemeMode = ThemeMode.light.obs;

  // Create an observable boolean variable to indicate light/dark mode
  final RxBool isLightMode = true.obs;

  // Function to toggle the theme
  void toggleTheme() {
    currentThemeMode.value =
        currentThemeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    
    // Update the isLightMode variable
    isLightMode.value = currentThemeMode.value == ThemeMode.light;
  }

  // Function to get the current theme data
  ThemeData get currentThemeData => ThemeData(
        colorScheme: currentThemeMode.value == ThemeMode.light
            ? lightColorScheme
            : darkColorScheme,
      );
}

