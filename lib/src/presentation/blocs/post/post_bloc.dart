import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart/src/domain/models/post/post.dart';
import 'package:bloc_rxdart/src/domain/repositories/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _repository;
  PostBloc(this._repository) : super(const PostState.initial()) {
    on<PostEvent>((event, emit) async {
      await event.when(
        fetch: () => _handleFetch(emit),
      );
    });
  }

  Future<void> _handleFetch(Emitter<PostState> emit) async {
    emit(const PostState.loading());
    try {
      final posts = await _repository.getPosts().first;
      emit(PostState.loaded(posts));
    } catch (e) {
      emit(PostState.error(e.toString()));
    }
  }
}
