import 'package:bloc_rxdart/src/presentation/blocs/user/user_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<UserBloc>()..add(FetchDataUser()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is InitialState) {
              return const Center(child: Text('Khởi tạo'));
            } else if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              );
            } else if (state is ErrorState) {
              return Center(child: Text('Lỗi: ${state.message}'));
            }
            return const Center(child: Text('Trạng thái không xác định'));
          },
        ),
      ),
    );
  }
}
