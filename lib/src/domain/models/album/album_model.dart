import 'package:freezed_annotation/freezed_annotation.dart';

part 'album_model.freezed.dart';
part 'album_model.g.dart';

@freezed
abstract class AlbumModel with _$AlbumModel {
  factory AlbumModel({
    required int userId,
    required int id,
    required String title,
  }) = _AlbumModel;
  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);
}
