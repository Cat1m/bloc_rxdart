import 'dart:developer';

import 'package:bloc_rxdart/src/domain/models/movie/movie_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/movie_repository.dart';

import '../datasources/remote/movie_api.dart/movie_api.dart';

class MovieRepositoryImple implements MovieRepository {
  final MovieApi _movieApi;

  MovieRepositoryImple(this._movieApi);

  @override
  Future<MovieModel> getMovie() async {
    final response = await _movieApi.getMovies();
    log('Raw response: $response'); // In ra response để kiểm tra
    return response;
  }
}
