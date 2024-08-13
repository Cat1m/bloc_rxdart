part of 'combined_bloc.dart';

@freezed
class CombinedEvent with _$CombinedEvent {
  const factory CombinedEvent.fetchDataEvent() = _FetchDataEvent;
  const factory CombinedEvent.selectUser(User user) = _SelectUser;
  const factory CombinedEvent.selectPost(Post post) = _SelectPost;
  const factory CombinedEvent.selectComment(CommentModel comment) =
      _SelectComment;
  const factory CombinedEvent.selectAlbum(AlbumModel album) = _SelectAlbum;
  const factory CombinedEvent.selectPhoto(Photo photo) = _SelectPhoto;
}
