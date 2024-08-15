import 'package:bloc_rxdart/src/domain/models/movie/movie_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_api.g.dart';

@RestApi()
abstract class MovieApi {
  factory MovieApi(Dio dio) = _MovieApi;

  @POST("/api/most-popular?page=1")
  Future<MovieModel> getMovies();
}
