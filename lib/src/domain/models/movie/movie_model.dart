import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
abstract class MovieModel with _$MovieModel {
  factory MovieModel({
    @Default('') @JsonKey(name: 'total') String total, // tổng số phim
    @Default(0) int page, // trang hiện tại
    @Default(0) int pages, // tổng số trang
    @Default([]) @JsonKey(name: 'tv_shows') List<TvShows> tvShow,
  }) = _MovieModel;
  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}

@freezed
abstract class TvShows with _$TvShows {
  factory TvShows({
    @Default('') @JsonKey(name: 'name') String name,
    @Default('') @JsonKey(name: 'permalink') String permalink,
    @Default('') @JsonKey(name: 'end_date') String endDate,
    @Default('') @JsonKey(name: 'network') String network,
    @Default('')
    @JsonKey(name: 'image_thumbnail_path')
    String imageThumbnailPath,
    @Default('') @JsonKey(name: 'status') String status,
  }) = _TvShows;
  factory TvShows.fromJson(Map<String, dynamic> json) =>
      _$TvShowsFromJson(json);
}
