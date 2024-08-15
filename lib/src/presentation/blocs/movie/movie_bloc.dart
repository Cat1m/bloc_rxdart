import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart/src/domain/models/api_response/api_response.dart';
import 'package:bloc_rxdart/src/domain/models/movie/movie_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieRepository movieRepository;
  MovieBloc({required this.movieRepository})
      : super(MovieState(moviesList: ApiResponse.loading())) {
    on<MoviesFetch>(fetchMoviesList);
  }

  FutureOr<void> fetchMoviesList(
      MoviesFetch event, Emitter<MovieState> emit) async {
    await movieRepository.getMovie().then((value) {
      emit(MovieState(moviesList: ApiResponse.completed(value)));
    }).onError((error, stackTrace) {
      emit(MovieState(moviesList: ApiResponse.error(error.toString())));
    });
  }
}
