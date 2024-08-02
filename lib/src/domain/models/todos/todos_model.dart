import 'package:freezed_annotation/freezed_annotation.dart';

part 'todos_model.freezed.dart';
part 'todos_model.g.dart';

@freezed
abstract class TodosModel with _$TodosModel {
  factory TodosModel({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _TodosModel;
  factory TodosModel.fromJson(Map<String, dynamic> json) =>
      _$TodosModelFromJson(json);
}
