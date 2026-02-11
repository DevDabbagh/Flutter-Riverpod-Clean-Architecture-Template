import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/core/errors/exceptions.dart';
import '../../../app/core/errors/failures.dart';
import '../../../app/core/errors/dio_exceptions.dart'; // Import DioExceptions
import '../../domain/posts/post.dart';
import '../../domain/posts/posts_repository.dart';
import 'posts_remote_datasource.dart';

part 'posts_repository_impl.g.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource remoteDataSource;

  PostsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Post>>> getPosts({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final remotePosts = await remoteDataSource.getPosts(
        page: page,
        limit: limit,
      );
      return Right(remotePosts);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, Post>> getPostById(int id) async {
    try {
      final post = await remoteDataSource.getPostById(id);
      return Right(post);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, Post>> createPost(
    String title,
    String body,
    int userId,
  ) async {
    try {
      final post = await remoteDataSource.createPost({
        'title': title,
        'body': body,
        'userId': userId,
      });
      return Right(post);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> uploadImage(File image) async {
    try {
      await remoteDataSource.uploadImage(
        image: image,
        description: "Test Image",
      );
      return const Right(null);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  Failure _handleError(dynamic e) {
    if (e is DioException) {
      // Map DioException to Failure using Helper
      final failureEx = DioExceptions.fromDioError(e);
      return ServerFailure(failureEx.message);
    }
    return ServerFailure(e.toString());
  }
}

@riverpod
PostsRepository postsRepository(PostsRepositoryRef ref) {
  final remoteDataSource = ref.watch(postsRemoteDataSourceProvider);
  return PostsRepositoryImpl(remoteDataSource);
}
