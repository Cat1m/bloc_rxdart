part of 'movie_bloc.dart';

class MovieState extends Equatable {
  const MovieState({
    required this.moviesList,
  });

  final ApiResponse<MovieModel> moviesList;

  MovieState copyWith({
    ApiResponse<MovieModel>? moviesList,
  }) {
    return MovieState(
      moviesList: moviesList ?? this.moviesList,
    );
  }

  @override
  List<Object> get props => [moviesList];
}
