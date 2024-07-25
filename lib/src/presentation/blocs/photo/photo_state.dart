part of 'photo_bloc.dart';

@freezed
class PhotoState with _$PhotoState {
  const factory PhotoState.initial() = _Initial;
  const factory PhotoState.loading() = _Loading;
  const factory PhotoState.loaded(List<Photo> photos) = _Loaded;
  const factory PhotoState.error(String message) = _Error;
}
