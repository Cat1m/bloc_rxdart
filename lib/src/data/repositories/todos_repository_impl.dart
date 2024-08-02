import 'dart:developer';

import 'package:bloc_rxdart/src/data/datasources/remote/remote.dart';
import 'package:bloc_rxdart/src/domain/models/todos/todos_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/todos_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/error/error_handler.dart';

class TodosRepositoryImpl implements TodosRepository {
  final PostApiService _apiService;

  TodosRepositoryImpl(this._apiService);

  @override
  Stream<List<TodosModel>> getTodos() {
    return Stream.fromFuture(_apiService.getTodos())
        .onErrorResume((error, stackTrace) {
      log('Caught error in repository: $error');
      log('Stack trace: $stackTrace');
      final failure = ErrorHandler.handle(error).failure;
      throw failure;
    }).map((todos) => todos);
  }
}
