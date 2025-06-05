import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_crud/core/constant/color.dart'; // Make sure this path is correct

class AppTheme {
  AppTheme._();
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor:
        AppColors.primaryAccent, // Set primary color for overall theme
    scaffoldBackgroundColor: AppColors.primaryBackground,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.secondaryBackground,
      foregroundColor: AppColors.primaryText, // Text color for app bar title
      elevation: 1, // A subtle shadow for app bar
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryAccent,
      foregroundColor: Colors.white,
      elevation: 4,
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.cardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // Input Decoration Theme (for TextFormFields)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryAccent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.secondaryText),
      hintStyle: TextStyle(color: AppColors.secondaryText.withOpacity(0.7)),
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryAccent,
      ),
    ),

    // Chip Theme (for active users)
    chipTheme: ChipThemeData(
      backgroundColor:
          AppColors.secondaryAccent.withOpacity(0.2), // Light green background
      labelStyle: const TextStyle(color: AppColors.primaryText),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // ListTile Theme
    listTileTheme: const ListTileThemeData(
      tileColor: AppColors.cardBackground,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Text Theme (updated to use new text colors)
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.w700, // Slightly bolder for titles
        fontFamily: 'Nunito',
      ),
      headlineMedium: TextStyle(
        color: AppColors.primaryText,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        color: AppColors.primaryText,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600, // For modal titles
      ),
      titleLarge: TextStyle(
        // Used for 'Confirm Deletion' in modal
        color: AppColors.primaryText,
        fontWeight: FontWeight.w600,
        fontFamily: 'Nunito',
      ),
      bodyLarge: TextStyle(
        color: AppColors.primaryText,
        fontFamily: 'Nunito',
      ),
      bodyMedium: TextStyle(
        color: AppColors.secondaryText,
        fontFamily: 'Nunito',
      ),
      bodySmall: TextStyle(
        color: AppColors.secondaryText,
        fontFamily: 'Nunito',
        fontSize: 12,
      ),
      // Add other text styles as needed, using primaryText or secondaryText
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.secondaryText, // Default icon color
    ),
  );
}
