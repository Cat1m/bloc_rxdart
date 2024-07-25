import '../models/post/post.dart';

abstract class PostRepository {
  Stream<List<Post>> getPosts();
}
