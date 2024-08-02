import 'package:bloc_rxdart/src/domain/models/photo/photo.dart';
import 'package:bloc_rxdart/src/domain/models/todos/todos_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../domain/models/album/album_model.dart';
import '../../../../domain/models/comment/comment_model.dart';
import '../../../../domain/models/post/post.dart';

part 'post_api_service.g.dart';

@RestApi()
abstract class PostApiService {
  factory PostApiService(Dio dio) = _PostApiService;

  @GET("/posts")
  Future<List<Post>> getPosts();

  @GET("/photos")
  Future<List<Photo>> getPhotos();

  @GET("/todos")
  Future<List<TodosModel>> getTodos();

  @GET("/comments")
  Future<List<CommentModel>> getComments();

  @GET("/albums")
  Future<List<AlbumModel>> getAlbums();
}
