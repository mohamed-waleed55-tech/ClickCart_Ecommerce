import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authentication/data/user_repository/user_repositroy.dart';

import '../../model/user_model.dart';



class UserFirestoreRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  UserFirestoreRepository(this._firestore);

  @override
  Future<void> saveUser(UserModel user) async {
    final doc = _firestore.collection('users').doc(user.id);

    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set(user.toMap());
    }
  }
}