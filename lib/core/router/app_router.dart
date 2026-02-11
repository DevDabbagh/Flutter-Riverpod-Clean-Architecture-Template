import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_riverpod/layers/presentation/posts/posts_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/posts',
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/posts'),
      GoRoute(path: '/posts', builder: (context, state) => const PostsPage()),
      GoRoute(path: '/posts', builder: (context, state) => const PostsPage()),
    ],
  );
}
