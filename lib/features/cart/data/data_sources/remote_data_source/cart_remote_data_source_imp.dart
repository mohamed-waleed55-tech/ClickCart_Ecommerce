import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/cart/model/firestore_product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'cart_remote_data_source.dart';

class CartRemoteDataSourceImp extends CartRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _currentUserId {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("User must be authenticated to access the cart.");
    }
    return uid;
  }

  CollectionReference<FirestoreProduct> getUserCartRef() {
    return _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('cart')
        .withConverter<FirestoreProduct>(
          toFirestore: (value, _) => value.toJson(),
          fromFirestore: (snapshot, _) =>
              FirestoreProduct.fromJson(snapshot.data()!),
        );
  }

  @override
  Future<void> addToRemoteCart(FirestoreProduct product) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final syncedProduct = product.copyWith(isSynced: 1);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(product.id as String?)
        .set(syncedProduct.toJson());
  }

  @override
  Future<void> deleteItemFromRemoteCart(int productId) {
    final cartRef = getUserCartRef();
    return cartRef.doc(productId.toString()).delete();
  }

  @override
  Future<List<FirestoreProduct>> getRemoteCartItems() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();

    return snapshot.docs
        .map((doc) => FirestoreProduct.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> updateRemoteQuantity(int productId, int quantity) {
    final cartRef = getUserCartRef();

    if (quantity <= 0) {
      return deleteItemFromRemoteCart(productId);
    }

    return cartRef.doc(productId.toString()).update({'quantity': quantity});
  }
  @override
  Future<void> clearRemoteCartAfterCheckout(WriteBatch batch) async {
    final cartSnapshot = await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('cart')
        .get();

    for (var doc in cartSnapshot.docs) {
      batch.delete(doc.reference);
    }
  }

}
