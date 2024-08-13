import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart/src/domain/models/user/user_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';
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
  final UserRepository _userRepository;
  final PhotoRepository _photoRepository;

  CombinedBloc(
    this._albumRepository,
    this._commentRepository,
    this._postRepository,
    this._userRepository,
    this._photoRepository,
  ) : super(const CombinedState.initial()) {
    on<CombinedEvent>((event, emit) async {
      await event.when(
        fetchDataEvent: () => onFetchDataEvent(emit),
        selectUser: (user) => onSelectUser(emit, user),
        selectPost: (post) => onSelectPost(emit, post),
        selectComment: (comment) => onSelectComment(emit, comment),
        selectAlbum: (album) => onSelectAlbum(emit, album),
        selectPhoto: (photo) => onSelectPhoto(emit, photo),
      );
    });
  }

  dynamic onSelectPhoto(Emitter<CombinedState> emit, Photo photo) {
    state.maybeWhen(
      loaded: (users, photos, posts, comments, albums, selectedUser,
          selectedPost, selectedComment, selectedAlbum, selectedPhoto) {
        emit(CombinedState.loaded(
          users: users,
          photos: photos,
          posts: posts,
          comments: comments,
          albums: albums,
          selectedUser: selectedUser,
          selectedPost: selectedPost,
          selectedComment: selectedComment,
          selectedAlbum: selectedAlbum,
          selectedPhoto: photo,
        ));
      },
      orElse: () {},
    );
  }

  dynamic onSelectAlbum(Emitter<CombinedState> emit, AlbumModel album) {
    state.maybeWhen(
      loaded: (users, photos, posts, comments, albums, selectedUser,
          selectedPost, selectedComment, selectedAlbum, selectedPhoto) {
        emit(CombinedState.loaded(
          users: users,
          photos: photos,
          posts: posts,
          comments: comments,
          albums: albums,
          selectedUser: selectedUser,
          selectedPost: selectedPost,
          selectedComment: selectedComment,
          selectedAlbum: album,
          selectedPhoto: null,
        ));
      },
      orElse: () {},
    );
  }

  dynamic onSelectComment(Emitter<CombinedState> emit, CommentModel comment) {
    state.maybeWhen(
      loaded: (users, photos, posts, comments, albums, selectedUser,
          selectedPost, selectedComment, selectedAlbum, selectedPhoto) {
        emit(CombinedState.loaded(
          users: users,
          photos: photos,
          posts: posts,
          comments: comments,
          albums: albums,
          selectedUser: selectedUser,
          selectedPost: selectedPost,
          selectedComment: comment,
          selectedAlbum: null,
          selectedPhoto: null,
        ));
      },
      orElse: () {},
    );
  }

  dynamic onSelectPost(Emitter<CombinedState> emit, Post post) {
    state.maybeWhen(
      loaded: (users, photos, posts, comments, albums, selectedUser,
          selectedPost, selectedComment, selectedAlbum, selectedPhoto) {
        emit(CombinedState.loaded(
          users: users,
          photos: photos,
          posts: posts,
          comments: comments,
          albums: albums,
          selectedUser: selectedUser,
          selectedPost: post,
          selectedComment: null,
          selectedAlbum: null,
          selectedPhoto: null,
        ));
      },
      orElse: () {},
    );
  }

  dynamic onSelectUser(Emitter<CombinedState> emit, User user) {
    state.maybeWhen(
      loaded: (users, photos, posts, comments, albums, selectedUser,
          selectedPost, selectedComment, selectedAlbum, selectedPhoto) {
        emit(CombinedState.loaded(
          users: users,
          photos: photos,
          posts: posts,
          comments: comments,
          albums: albums,
          selectedUser: user,
          selectedPost: null,
          selectedComment: null,
          selectedAlbum: null,
          selectedPhoto: null,
        ));
      },
      orElse: () {},
    );
  }

  onFetchDataEvent(Emitter<CombinedState> emit) async {
    emit(const CombinedState.loading());

    try {
      final result = await Rx.combineLatest5(
        _userRepository.getUser(),
        _photoRepository.getPhotos(),
        _postRepository.getPosts(),
        _commentRepository.getComment(),
        _albumRepository.getAlbum(),
        (
          users,
          photos,
          posts,
          comments,
          albums,
        ) =>
            (
          users,
          photos,
          posts,
          comments,
          albums,
        ),
      ).first;

      emit(CombinedState.loaded(
        users: result.$1,
        photos: result.$2,
        posts: result.$3,
        comments: result.$4,
        albums: result.$5,
      ));
    } on Failure catch (failure) {
      emit(CombinedState.error(failure.message));
    } catch (e) {
      emit(const CombinedState.error('Lỗi chưa xác định'));
    }
  }
}
