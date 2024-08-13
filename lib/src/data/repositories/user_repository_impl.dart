import 'dart:developer';
import 'package:bloc_rxdart/src/data/datasources/remote/json_place_holder_api.dart/json_place_holder_api_service.dart';
import 'package:bloc_rxdart/src/domain/models/user/user_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/error/error_handler.dart';

class UserRepositoryImpl implements UserRepository {
  final JsonPlaceHolderApiService _apiService;

  UserRepositoryImpl(this._apiService);
  @override
  Stream<List<User>> getUser() {
    return Stream.fromFuture(_apiService.getUsers())
        .onErrorResume((error, stackTrace) {
      log('Caught error in repository: $error');
      log('Stack trace: $stackTrace');
      final failure = ErrorHandler.handle(error).failure;
      throw failure;
    }).map((user) => user);
  }
}
