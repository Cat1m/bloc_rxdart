import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart/src/domain/models/user/user_model.dart';
import 'package:bloc_rxdart/src/domain/repositories/user_repository.dart';
import 'package:bloc_rxdart/src/utils/error/error_handler.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(InitialState()) {
    on<FetchDataUser>(_onFetchDataUser);
  }

  FutureOr<void> _onFetchDataUser(
    FetchDataUser event,
    Emitter<UserState> emit,
  ) async {
    emit(LoadingState());
    try {
      final users = await _userRepository.getUser().first;
      emit(LoadedState(users));
    } on Failure catch (failure) {
      emit(ErrorState(failure.message));
    } catch (e) {
      emit(ErrorState('Lỗi chưa xác định'));
    }
  }
}
