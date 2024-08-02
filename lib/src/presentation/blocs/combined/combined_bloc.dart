import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart/src/domain/repositories/album_repository.dart';
import 'package:bloc_rxdart/src/domain/repositories/comment_repository.dart';
import 'package:bloc_rxdart/src/domain/repositories/repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/album/album_model.dart';
import '../../../domain/models/comment/comment_model.dart';
import '../../../domain/models/models.dart';
import '../../../utils/error/error_handler.dart';

part 'combined_event.dart';
part 'combined_state.dart';
part 'combined_bloc.freezed.dart';

class CombinedBloc extends Bloc<CombinedEvent, CombinedState> {
  final PostRepository _postRepository;
  final CommentRepository _commentRepository;
  final AlbumRepository _albumRepository;
  CombinedBloc(
    this._albumRepository,
    this._commentRepository,
    this._postRepository,
  ) : super(const CombinedState.initial()) {
    on<CombinedEvent>((event, emit) async {
      await event.when(
        fetchDataEvent: () => onFetchDataEvent(emit),
      );
    });
  }

  onFetchDataEvent(Emitter<CombinedState> emit) async {
    emit(const CombinedState.loading());
    try {
      final posts = await _postRepository.getPosts().first;
      final comments = await _commentRepository.getComment().first;
      final albums = await _albumRepository.getAlbum().first;
      emit(CombinedState.loaded(
        comments,
        posts,
        albums,
      ));
    } on Failure catch (failure) {
      emit(CombinedState.error(failure.message));
    } catch (e) {
      emit(const CombinedState.error('Lỗi chưa xác định'));
    }
  }
}
