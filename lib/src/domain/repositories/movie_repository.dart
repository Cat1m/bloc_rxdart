import '../models/movie/movie_model.dart';

abstract class MovieRepository {
  Future<MovieModel> getMovie();
}
