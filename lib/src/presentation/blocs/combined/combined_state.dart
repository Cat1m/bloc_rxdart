part of 'combined_bloc.dart';

@freezed
class CombinedState with _$CombinedState {
  const factory CombinedState.initial() = _Initial;
  const factory CombinedState.loading() = _Loading;
  const factory CombinedState.loaded(
    List<CommentModel> comments,
    List<Post> posts,
    List<AlbumModel> album,
  ) = _Loaded;
  const factory CombinedState.error(String message) = _Error;
}
