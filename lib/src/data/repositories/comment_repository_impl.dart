import 'dart:developer';

import 'package:bloc_rxdart/src/data/datasources/remote/post_api.dart/post_api_service.dart';
import 'package:bloc_rxdart/src/domain/models/comment/comment_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/comment_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/error/error_handler.dart';

class CommentRepositoryImpl implements CommentRepository {
  final PostApiService _apiService;

  CommentRepositoryImpl(this._apiService);
  @override
  Stream<List<CommentModel>> getComment() {
    return Stream.fromFuture(_apiService.getComments())
        .onErrorResume((error, stackTrace) {
      log('Caught error in repository: $error');
      log('Stack trace: $stackTrace');
      final failure = ErrorHandler.handle(error).failure;
      throw failure;
    }).map((photos) => photos);
  }
}
