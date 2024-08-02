import 'package:bloc_rxdart/src/domain/models/todos/todos_model.dart';

abstract class TodosRepository {
  Stream<List<TodosModel>> getTodos();
}
