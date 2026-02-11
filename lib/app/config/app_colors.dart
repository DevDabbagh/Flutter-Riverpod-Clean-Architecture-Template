import 'package:flutter/material.dart';

class AppColors {
  // Main Brand Colors (Derived from Logo)
  static const Color brandBlue = Color(0xFF2B559E); // Approx Royal Blue from Logo
  static const Color brandGreen = Color(0xFF6AC259); // Approx Lime Green from Logo

  // UI Primary Colors (From Onboarding Buttons)
  static const Color primary = Color(0xFF5E9A6); // Teal/Cyan color from buttons (Approx)
  // Let's adjust closer to the screenshot: It looks like a muted cyan/teal.
  // Trying #5097A4
  static const Color primaryTeal = Color(0xFF5097A4); 
  
  // Secondary/Accent
  static const Color secondary = brandGreen;

  // Backgrounds
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF8F9FB); // Light grey for inputs/cards
  static const Color inputFill = Color(0xFFF5F6FA);

  // Text
  static const Color textPrimary = Color(0xFF1D2B44); // Dark Blue-Grey
  static const Color textSecondary = Color(0xFF7D8FAB); // Light Grey-Blue

  // Status
  static const Color success = brandGreen;
  static const Color error = Color(0xFFD32F2F);
}
