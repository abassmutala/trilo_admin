import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/app_colors.dart';

final ThemeData triloLightTheme = lightTheme();

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      brightness: Brightness.light,
      colorScheme: base.colorScheme.copyWith(
        surface: AppColours.backgroundLight,
        primary: AppColours.primary,
        primaryContainer: AppColours.primary.withOpacity(0.5),
        secondary: AppColours.secondary,
        // surface: AppColours.surfaceLight,
      ),
      scaffoldBackgroundColor: AppColours.backgroundLight,
      textTheme: base.textTheme.copyWith(
        headlineLarge: const TextStyle(
            color: AppColours.foregroundLight,
            // fontWeight: FontWeight.w600,
            fontFamily: "Nunito"),
        headlineMedium: const TextStyle(
          color: AppColours.foregroundLight,
          fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        headlineSmall: const TextStyle(
          color: AppColours.foregroundLight,
          fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        titleLarge: const TextStyle(
          color: AppColours.foregroundLight,
          // fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        titleMedium: const TextStyle(
          color: AppColours.foregroundLight,
          // fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        titleSmall: const TextStyle(
          color: AppColours.foregroundLight,
          // fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        bodyLarge: const TextStyle(
          color: AppColours.foregroundLight,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: const TextStyle(
          fontFamily: "Nunito",
          color: AppColours.foregroundLight,
        ),
        bodySmall: const TextStyle(
          color: Colors.white,
          fontFamily: "Nunito",
        ),
        labelLarge: const TextStyle(fontFamily: "Nunito"),
        labelMedium: const TextStyle(fontFamily: "Nunito"),
        labelSmall: const TextStyle(fontFamily: "Nunito"),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: AppColours.inputBgLight,
      ),
      listTileTheme: base.listTileTheme.copyWith(
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      appBarTheme: base.appBarTheme.copyWith(
          color: AppColours.primary,
          foregroundColor: AppColours.foregroundLight,
          titleTextStyle: const TextStyle(fontWeight: FontWeight.w600, color: AppColours.backgroundLight),
          iconTheme: const IconThemeData(color: AppColours.backgroundLight),
          toolbarTextStyle: base.textTheme.titleLarge,
          centerTitle: true,
          // titleTextStyle: base.textTheme.headline6,
          ),
      tabBarTheme: base.tabBarTheme.copyWith(
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      backgroundColor: AppColours.backgroundLight,
        selectedItemColor: AppColours.primary,
        // unselectedItemColor: 
      ),
      cardTheme: base.cardTheme.copyWith(color: AppColours.surfaceLight),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColours.primary,
        primaryContrastingColor: AppColours.primary,
        // textTheme: _bookiemaCupertinoLightTextTheme(appleBase),
      ),
      applyElevationOverlayColor: false);
}

final ThemeData triloDarkTheme = darkTheme();

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
      brightness: Brightness.dark,
      colorScheme: base.colorScheme.copyWith(
        surface: AppColours.backgroundDark,
        primary: AppColours.primary,
        secondary: AppColours.secondary,
        // surface: AppColours.surfaceDark,
      ),
      scaffoldBackgroundColor: AppColours.backgroundDark,
      textTheme: base.textTheme.copyWith(
        headlineLarge: const TextStyle(
            color: AppColours.foregroundDark,
            // fontWeight: FontWeight.w600,
            fontFamily: "Nunito"),
        headlineMedium: const TextStyle(
          color: AppColours.foregroundDark,
          fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        headlineSmall: const TextStyle(
          color: AppColours.foregroundDark,
          fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        titleLarge: const TextStyle(
          color: AppColours.foregroundDark,
          // fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        titleMedium: const TextStyle(
          color: AppColours.foregroundDark,
          // fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        titleSmall: const TextStyle(
          color: AppColours.foregroundDark,
          // fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        bodyLarge: const TextStyle(
          color: AppColours.foregroundDark,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: const TextStyle(
          fontFamily: "Nunito",
          color: AppColours.foregroundDark,
        ),
        bodySmall: const TextStyle(
          color: Colors.white,
          fontFamily: "Nunito",
        ),
        labelLarge: const TextStyle(fontFamily: "Nunito"),
        labelMedium: const TextStyle(fontFamily: "Nunito"),
        labelSmall: const TextStyle(fontFamily: "Nunito"),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: AppColours.surfaceDark,
      ),
      listTileTheme: base.listTileTheme.copyWith(
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        color: AppColours.backgroundDark,
        iconTheme: const IconThemeData(color: AppColours.foregroundDark),
        // toolbarTextStyle: base.textTheme.bodyText2,
        // titleTextStyle: base.textTheme.headline6,
      ),
      tabBarTheme: base.tabBarTheme.copyWith(
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Nunito",
        ),
      ),
      cardTheme: base.cardTheme.copyWith(color: AppColours.surfaceDark),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColours.primary,
        primaryContrastingColor: AppColours.primary,
        // textTheme: _bookiemaCupertinoLightTextTheme(appleBase),
      ),
      applyElevationOverlayColor: false);
}
