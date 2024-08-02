import 'package:bloc_rxdart/src/domain/models/comment/comment_model.dart';

abstract class CommentRepository {
  Stream<List<CommentModel>> getComment();
}
