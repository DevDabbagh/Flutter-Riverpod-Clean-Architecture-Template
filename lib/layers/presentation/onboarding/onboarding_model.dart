
import 'package:flutter/material.dart';

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon; // Using Icons for now, can be replaced with SVG/Image

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}
