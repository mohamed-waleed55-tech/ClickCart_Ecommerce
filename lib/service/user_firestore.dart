
import '../features/authentication/model/user_model.dart';

abstract class UserFirestore {
  Future<void>addUserToFirestore(UserModel user);
}