import 'package:ecommerce_app/core/error_handling/result_state.dart';
import '../../model/user_model.dart';

abstract class UserRepository {
  Future<ResultState<void>> saveUser(UserModel user);

}