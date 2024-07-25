import 'package:bloc_rxdart/src/domain/models/photo/photo.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/post/post.dart';

part 'post_api_service.g.dart';

@RestApi()
abstract class PostApiService {
  factory PostApiService(Dio dio) = _PostApiService;

  @GET("/posts")
  Future<List<Post>> getPosts();

  @GET("/photos")
  Future<List<Photo>> getPhotos();
}
