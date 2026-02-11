import 'dart:io';
import 'package:dartz/dartz.dart';

import '../../../app/core/errors/failures.dart';
import 'post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getPosts({int page = 1, int limit = 10});
  Future<Either<Failure, Post>> getPostById(int id);
  Future<Either<Failure, Post>> createPost(
    String title,
    String body,
    int userId,
  );
  Future<Either<Failure, void>> uploadImage(File image);
}
