import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/posts/post.dart';
import '../../data/posts/posts_repository_impl.dart';

part 'posts_provider.g.dart';

@riverpod
class PostsController extends _$PostsController {
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;

  @override
  Future<List<Post>> build() async {
    _page = 1;
    _hasMore = true;
    final repository = ref.watch(postsRepositoryProvider);
    final result = await repository.getPosts(page: _page, limit: _limit);

    return result.fold((failure) => throw Exception(failure.message), (posts) {
      if (posts.length < _limit) _hasMore = false;
      return posts;
    });
  }

  Future<void> loadMore() async {
    if (state.isLoading || !_hasMore) return;

    final currentData = state.value ?? [];

    _page++;
    final repository = ref.read(postsRepositoryProvider);
    final result = await repository.getPosts(page: _page, limit: _limit);

    result.fold(
      (failure) {
        _page--;
      },
      (newPosts) {
        if (newPosts.isEmpty) {
          _hasMore = false;
        } else {
          if (newPosts.length < _limit) _hasMore = false;
          state = AsyncValue.data([...currentData, ...newPosts]);
        }
      },
    );
  }

  // --- Demo Methods for API Examples ---

  // 1. Get Single Post
  Future<void> demoGetPost(int id) async {
    final repository = ref.read(postsRepositoryProvider);
    final result = await repository.getPostById(id);
    result.fold(
      (l) => print("Error: ${l.message}"),
      (r) => print("Success: ${r.title}"),
    );
  }

  // 2. Create Post
  Future<void> demoCreatePost() async {
    final repository = ref.read(postsRepositoryProvider);
    final result = await repository.createPost("New Title", "New Body", 1);
    result.fold(
      (l) => print("Error: ${l.message}"),
      (r) => print("Created Post: ${r.title}"),
    );
  }

  // 3. Upload Image
  Future<void> demoUploadImage() async {
    // This requires a real file path to work
    // final file = File('/path/to/image.png');
    // final repository = ref.read(postsRepositoryProvider);
    // await repository.uploadImage(file);
    print("Upload Image Demo needs a real file path.");
  }
}
