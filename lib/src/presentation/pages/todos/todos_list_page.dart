import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/todos/todos_bloc.dart';

class TodosListPage extends StatelessWidget {
  const TodosListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GetIt.I<TodosBloc>()..add(const TodosEvent.fetch()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Todolist'),
          ),
          body: BlocBuilder<TodosBloc, TodosState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (todos) => ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.completed.toString()),
                    );
                  },
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            },
          ),
        ));
  }
}
