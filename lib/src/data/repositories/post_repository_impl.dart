import 'package:rxdart/rxdart.dart';
import '../../domain/models/post/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/remote/post_api.dart/post_api_service.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService _apiService;

  PostRepositoryImpl(this._apiService);

  @override
  Stream<List<Post>> getPosts() {
    return Stream.fromFuture(_apiService.getPosts())
        .onErrorReturnWith((error, stackTrace) => []);
  }
}
