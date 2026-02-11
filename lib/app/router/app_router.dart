import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../layers/presentation/posts/posts_page.dart';
import '../../layers/presentation/onboarding/onboarding_page.dart';
import '../../app.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    navigatorKey: BaseApplication.navigatorKey,
    initialLocation: '/onboarding', // Changed to start with onboarding
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: '/posts', builder: (context, state) => const PostsPage()),
    ],
  );
}
