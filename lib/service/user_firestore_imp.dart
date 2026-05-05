import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/service/user_firestore.dart';

import '../features/authentication/model/user_model.dart';

class UserFirestoreImp extends UserFirestore {
  static final _userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUserToFirestore(UserModel user) async {
    _userCollection.doc(user.id).set(user.toMap());

  }
}
