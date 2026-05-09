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


  @override
  Future<void> addProductToCart(FirestoreProduct product) async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        throw Exception("Authentication required");
      }

      await _firestore.collection('users').doc(userId).update({
        'cart': FieldValue.arrayUnion([product.toJson()])
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResult<List<FirestoreProduct>>> getCartProducts() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

      final snapshot = await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists && snapshot.data() != null) {

        final List<dynamic> cartData = snapshot.data()?['cart'] ?? [];

        List<FirestoreProduct> cartProducts = cartData.map((item) {
          return FirestoreProduct.fromJson(item as Map<String, dynamic>);
        }).toList();

        return ApiResult.success(cartProducts);
      } else {
        return const ApiResult.success([]);
      }

  }
}
