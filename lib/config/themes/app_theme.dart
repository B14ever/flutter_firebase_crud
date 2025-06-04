import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_crud/core/constant/color.dart';


class AppTheme {
  AppTheme._();
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.secondaryBackground,
      // foregroundColor: AppColors.lightTitleText,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android
        statusBarBrightness: Brightness.light, // For iOS
      ),
    ),
    scaffoldBackgroundColor: AppColors.primaryBackground,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(AppColors.secondaryBackground),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: AppColors.titleText,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito'),
      headlineMedium: TextStyle(
        color: AppColors.titleText,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        color: AppColors.titleText,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w200,
      ),
      // bodyLarge,
      // bodyMedium,
      // bodySmall,
      // labelLarge,
      // labelMedium,
      // labelSmall,
    ),
  );


}
