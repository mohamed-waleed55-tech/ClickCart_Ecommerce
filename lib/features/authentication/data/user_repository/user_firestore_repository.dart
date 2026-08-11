import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/error_handling/network_exceptions.dart';
import 'package:ecommerce_app/core/error_handling/result_state.dart';
import 'package:ecommerce_app/features/authentication/data/user_repository/user_repositroy.dart';

import '../../model/user_model.dart';

class UserFirestoreRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  UserFirestoreRepository(this._firestore);

  @override
  Future<ResultState<void>> saveUser(UserModel user) async {
    try {
      final doc = _firestore.collection('users').doc(user.id);

      final snapshot = await doc.get();

      if (!snapshot.exists) {
        await doc.set(user.toJson());
      }

      return const ResultState.success(null);
    } catch (e) {
      return ResultState.failure(NetworkExceptions.getDioException(e));
    }
  }
}