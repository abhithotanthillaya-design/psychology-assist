import 'package:flutter/material.dart';

/// Medical-inspired color palettes for a calm, clinical aesthetic
class AppColors {
  // Light Theme Colors
  static const Color lightBg = Color(0xFFFAFBFC);
  static const Color lightSurface = Colors.white;
  static const Color lightPrimary = Color(0xFF5B8DEE); // Calm blue
  static const Color lightSecondary = Color(0xFF6AC5A8); // Soft green
  static const Color lightAccent = Color(0xFFF0A8A0); // Soft coral
  static const Color lightText = Color(0xFF1F2937); // Dark gray
  static const Color lightSubtext = Color(0xFF6B7280); // Medium gray
  static const Color lightBorder = Color(0xFFE5E7EB); // Light gray
  static const Color lightDivider = Color(0xFFF3F4F6); // Very light gray

  // Dark Theme Colors
  static const Color darkBg = Color(0xFF0F1419);
  static const Color darkSurface = Color(0xFF1A1E27);
  static const Color darkPrimary = Color(0xFF7BA3FF); // Lighter blue for dark
  static const Color darkSecondary = Color(0xFF7FD9BE); // Lighter green
  static const Color darkAccent = Color(0xFFF5B5AA); // Lighter coral
  static const Color darkText = Color(0xFFF3F4F6); // Light gray
  static const Color darkSubtext = Color(0xFFD1D5DB); // Medium gray
  static const Color darkBorder = Color(0xFF374151); // Dark gray
  static const Color darkDivider = Color(0xFF1F2937); // Very dark gray

  // Medical Theme (Soft & Clinical)
  static const Color medicalBg = Color(0xFFF8FAFB);
  static const Color medicalSurface = Color(0xFFFFFFFF);
  static const Color medicalPrimary = Color(0xFF4A90E2); // Medical blue
  static const Color medicalSecondary = Color(0xFF50C878); // Healthcare green
  static const Color medicalAccent = Color(0xFFFFB347); // Soft amber
  static const Color medicalText = Color(0xFF2C3E50);
  static const Color medicalSubtext = Color(0xFF7F8C8D);
  static const Color medicalBorder = Color(0xFFECF0F1);
  static const Color medicalDivider = Color(0xFFF5F7FA);

  // Universal semantic colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Mood colors (for mood logging)
  static const Color moodExcellent = Color(0xFF34D399); // Green
  static const Color moodGood = Color(0xFF60A5FA); // Blue
  static const Color moodNeutral = Color(0xFFFCD34D); // Yellow
  static const Color moodPoor = Color(0xFFF87171); // Red
  static const Color moodTerrible = Color(0xFF9333EA); // Purple

  // Overlay & transparency
  static const Color overlayDark = Color(0x80000000);
  static const Color overlayLight = Color(0x1A000000);
}
