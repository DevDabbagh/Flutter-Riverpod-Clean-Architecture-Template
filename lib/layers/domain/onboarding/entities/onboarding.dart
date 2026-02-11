// lib/layers/domain/onboarding/entities/onboarding.dart
import 'package:flutter/material.dart'; // For IconData, though strictly domain shouldn't know about Flutter UI, but for dummy data it's fine.
// Ideally, we'd use a String for image path or icon code.
// I'll keep IconData for now as it was in the previous file, but usually Domain uses Strings for assets.

class Onboarding {
  final String title;
  final String description;
  final IconData icon;

  const Onboarding({
    required this.title,
    required this.description,
    required this.icon,
  });
}
