import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart/src/domain/repositories/todos_repository.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/todos/todos_model.dart';
import '../../../utils/error/error_handler.dart';

part 'todos_event.dart';
part 'todos_state.dart';
part 'todos_bloc.freezed.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _todosRepository;
  TodosBloc(this._todosRepository) : super(const TodosState.initial()) {
    on<TodosEvent>((event, emit) async {
      await event.when(fetch: () => _handleFetch(emit));
    });
  }

  Future<void> _handleFetch(Emitter<TodosState> emit) async {
    emit(const TodosState.loading());
    try {
      final todos = await _todosRepository.getTodos().first;
      emit(TodosState.loaded(todos));
    } on Failure catch (failure) {
      emit(TodosState.error(failure.message));
    } catch (e) {
      emit(const TodosState.error('Lỗi chưa xác định'));
    }
  }
}
