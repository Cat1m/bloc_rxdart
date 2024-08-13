part of 'user_bloc.dart';

sealed class UserState {}

class InitialState extends UserState {}

class LoadingState extends UserState {}

class LoadedState extends UserState {
  final List<User> users;

  LoadedState(this.users);
}

class ErrorState extends UserState {
  final String message;

  ErrorState(this.message);
}
