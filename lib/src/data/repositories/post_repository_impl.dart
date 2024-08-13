import 'package:rxdart/rxdart.dart';
import '../../domain/models/post/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/remote/json_place_holder_api.dart/json_place_holder_api_service.dart';

class PostRepositoryImpl implements PostRepository {
  final JsonPlaceHolderApiService _apiService;

  PostRepositoryImpl(this._apiService);

  @override
  Stream<List<Post>> getPosts() {
    return Stream.fromFuture(_apiService.getPosts())
        .onErrorReturnWith((error, stackTrace) => []);
  }
}
