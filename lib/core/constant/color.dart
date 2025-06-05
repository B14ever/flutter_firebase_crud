import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Palette
  static const Color primaryBackground = Color(0xFFFFFFFF); // White
  static const Color secondaryBackground =
      Color(0xFFFAF8F5); // Existing off-white

  // Accent Colors
  static const Color primaryAccent = Color(0xFF42A5F5); // Blue 400
  static const Color secondaryAccent = Color(0xFF81C784); // Green 300

  // Text Colors
  static const Color primaryText = Color(0xFF212121); // Dark Gray
  static const Color secondaryText = Color(0xFF616161); // Medium Gray

  // Surface Colors
  static const Color cardBackground =
      Color(0xFFF8F8F8); // Very light gray for cards
  static const Color borderColor =
      Color(0xFFE0E0E0); // Light gray for borders/dividers

  // Status Colors
  static const Color errorColor = Color(0xFFEF5350); // Red 400
  static const Color successColor =
      Color(0xFF4CAF50); // Green 500 (A slightly stronger green for success)
  static const Color infoColor =
      Color(0xFF2196F3); // Blue 500 (A standard blue for informational)
  static const Color warningColor = Color(0xFFFFC107);
}
