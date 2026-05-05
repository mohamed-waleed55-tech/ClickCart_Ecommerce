import '../../model/user_model.dart';

abstract class UserRepository {
  Future<void> saveUser(UserModel user);
}
