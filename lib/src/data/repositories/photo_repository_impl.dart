import 'dart:developer';

import 'package:bloc_rxdart/src/data/datasources/remote/json_place_holder_api.dart/json_place_holder_api_service.dart';
import 'package:bloc_rxdart/src/domain/models/photo/photo.dart';
import 'package:bloc_rxdart/src/domain/repositories/photo_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/error/error_handler.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final JsonPlaceHolderApiService _apiService;

  PhotoRepositoryImpl(this._apiService);

  @override
  Stream<List<Photo>> getPhotos() {
    return Stream.fromFuture(_apiService.getPhotos())
        .onErrorResume((error, stackTrace) {
      log('Caught error in repository: $error');
      log('Stack trace: $stackTrace');
      final failure = ErrorHandler.handle(error).failure;
      throw failure;
    }).map((photos) => photos);
  }
}
