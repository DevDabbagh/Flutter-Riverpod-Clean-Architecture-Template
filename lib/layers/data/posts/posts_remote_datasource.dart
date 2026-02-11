import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/network/dio_helper.dart';
import 'post_model.dart';
import '../../../app/config/constants.dart'; // Import for ApiEndPoints

part 'posts_remote_datasource.g.dart';

@RestApi()
abstract class PostsRemoteDataSource {
  factory PostsRemoteDataSource(Dio dio, {String baseUrl}) =
      _PostsRemoteDataSource;

  // 1. Get Pagination List
  @GET(ApiEndPoints.posts)
  Future<List<PostModel>> getPosts({
    @Query('_page') int page = 1,
    @Query('_limit') int limit = 10,
  });

  // 2. Normal Get Data (Single Item)
  @GET('${ApiEndPoints.posts}/{id}')
  Future<PostModel> getPostById(@Path("id") int id);

  // 3. Post Request with Normal Data
  @POST(ApiEndPoints.posts)
  Future<PostModel> createPost(@Body() Map<String, dynamic> body);

  // 4. Post Request with Image (Multipart)
  @POST(ApiEndPoints.upload)
  @MultiPart()
  Future<void> uploadImage({
    @Part() required File image,
    @Part() String? description,
  });
}

@riverpod
PostsRemoteDataSource postsRemoteDataSource(PostsRemoteDataSourceRef ref) {
  final dio = ref.watch(dioHelperProvider);
  return PostsRemoteDataSource(dio);
}
