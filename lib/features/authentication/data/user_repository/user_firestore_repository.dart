import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authentication/data/user_repository/user_repositroy.dart';
import 'package:ecommerce_app/features/cart/model/firestore_product.dart';
import 'package:ecommerce_app/features/home/data/api_error_handling/network_exceptions.dart';
import 'package:ecommerce_app/features/home/data/products_repository/api_result.dart';
import 'package:ecommerce_app/features/home/model/api_response/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user_model.dart';



class UserFirestoreRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  UserFirestoreRepository(this._firestore);

  @override
  Future<void> saveUser(UserModel user) async {
    final doc = _firestore.collection('users').doc(user.id);

    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set(user.toJson());
    }
  }
}

