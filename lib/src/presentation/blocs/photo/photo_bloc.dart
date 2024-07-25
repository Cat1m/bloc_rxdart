import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart/src/domain/repositories/photo_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/photo/photo.dart';
import '../../../utils/error/error_handler.dart';

part 'photo_event.dart';
part 'photo_state.dart';
part 'photo_bloc.freezed.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository _repository;
  PhotoBloc(this._repository) : super(const PhotoState.initial()) {
    on<PhotoEvent>((event, emit) async {
      await event.when(
        fetch: () => _handleFetch(emit),
      );
    });
  }

  Future<void> _handleFetch(Emitter<PhotoState> emit) async {
    emit(const PhotoState.loading());
    try {
      final photos = await _repository.getPhotos().first;
      emit(PhotoState.loaded(photos));
    } on Failure catch (failure) {
      emit(PhotoState.error(failure.message));
    } catch (e) {
      emit(const PhotoState.error('An unexpected error occurred'));
    }
  }
}
