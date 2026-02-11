import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'posts_provider.dart';

class PostsPage extends ConsumerStatefulWidget {
  const PostsPage({super.key});

  @override
  ConsumerState<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends ConsumerState<PostsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(postsControllerProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsState = ref.watch(postsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts API Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Trigger Create Post Demo
              ref.read(postsControllerProvider.notifier).demoCreatePost();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Creating Post... Check Console")),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Trigger Get Single Post Demo
              ref.read(postsControllerProvider.notifier).demoGetPost(1);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Getting Post 1... Check Console"),
                ),
              );
            },
          ),
        ],
      ),
      body: postsState.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(postsControllerProvider.future),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }

                final post = posts[index];
                return ListTile(
                  title: Text(
                    post.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(post.body),
                  leading: CircleAvatar(child: Text(post.id.toString())),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
