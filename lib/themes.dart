import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'SequelSans',
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.bodyColor,
      dividerColor: AppColors.mainBackgroundColor,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(circularTrackColor: Colors.white),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainBackgroundColor,
          surfaceTintColor: AppColors.mainBackgroundColor),
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
          background: AppColors.mainBackgroundColor,
          onBackground: AppColors.textColorPrimary),
      textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontSize: 14.0,
              color: AppColors.textColorPrimary,
              fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              fontSize: 20.0,
              color: AppColors.textColorPrimary,
              fontWeight: FontWeight.normal),
          titleLarge: TextStyle(
              fontSize: 32.0,
              color: AppColors.textColorSecondary,
              fontWeight: FontWeight.normal),
          titleMedium: TextStyle(
              fontSize: 13.0,
              color: AppColors.textColorPrimary,
              fontWeight: FontWeight.normal)));

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
      fontFamily: 'SequelSans',
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.bodyColor,
      dividerColor: AppColors.mainBackgroundColor,
      progressIndicatorTheme:
      const ProgressIndicatorThemeData(circularTrackColor: Colors.white),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainBackgroundColor,
          surfaceTintColor: AppColors.mainBackgroundColor),
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          brightness: Brightness.dark,
          primary: AppColors.primaryColor,
          background: AppColors.mainBackgroundColor,
          onBackground: AppColors.textColorPrimary),
      textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontSize: 14.0,
              color: AppColors.textColorPrimary,
              fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              fontSize: 20.0,
              color: AppColors.textColorPrimary,
              fontWeight: FontWeight.normal),
          titleLarge: TextStyle(
              fontSize: 32.0,
              color: AppColors.textColorSecondary,
              fontWeight: FontWeight.normal),
          titleMedium: TextStyle(
              fontSize: 13.0,
              color: AppColors.textColorPrimary,
              fontWeight: FontWeight.normal)));
}
