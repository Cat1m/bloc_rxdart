import 'dart:developer';

import 'package:bloc_rxdart/src/data/datasources/remote/json_place_holder_api.dart/json_place_holder_api_service.dart';
import 'package:bloc_rxdart/src/domain/models/album/album_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/album_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/error/error_handler.dart';

class AlbumRepositoryImple implements AlbumRepository {
  final JsonPlaceHolderApiService _apiService;

  AlbumRepositoryImple(this._apiService);
  @override
  Stream<List<AlbumModel>> getAlbum() {
    return Stream.fromFuture(_apiService.getAlbums())
        .onErrorResume((error, stackTrace) {
      log('Caught error in repository: $error');
      log('Stack trace: $stackTrace');
      final failure = ErrorHandler.handle(error).failure;
      throw failure;
    }).map((photos) => photos);
  }
}
