part of 'todos_bloc.dart';

@freezed
class TodosState with _$TodosState {
  const factory TodosState.initial() = _Initial;
  const factory TodosState.loading() = _Loading;
  const factory TodosState.loaded(List<TodosModel> todos) = _Loaded;
  const factory TodosState.error(String message) = _Error;
}
