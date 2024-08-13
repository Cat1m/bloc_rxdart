import 'package:bloc_rxdart/src/domain/models/user/user_model.dart';

abstract class UserRepository {
  Stream<List<User>> getUser();
}
