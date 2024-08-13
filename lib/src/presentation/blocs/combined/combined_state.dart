part of 'combined_bloc.dart';

@freezed
class CombinedState with _$CombinedState {
  const factory CombinedState.initial() = _Initial;
  const factory CombinedState.loading() = _Loading;
  const factory CombinedState.loaded({
    required List<User> users,
    required List<Photo> photos,
    required List<Post> posts,
    required List<CommentModel> comments,
    required List<AlbumModel> albums,
    User? selectedUser,
    Post? selectedPost,
    CommentModel? selectedComment,
    AlbumModel? selectedAlbum,
    Photo? selectedPhoto,
  }) = _Loaded;
  const factory CombinedState.error(String message) = _Error;
}
