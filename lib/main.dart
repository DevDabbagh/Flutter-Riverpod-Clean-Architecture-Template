import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app.dart';
import 'app/router/app_router.dart'; // Import to access provider

void main() {
  runApp(const ProviderScope(child: BaseApplication()));
}
