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
    if (product.id == null) {
      print("🚨 [Remote Cart Error]: لا يمكن الإضافة لأن الـ ID الخاص بالمنتج null");
      return;
    }

    final userCartRef = getUserCartRef();
    final docRef = userCartRef.doc(product.id.toString());

    try {
      final snapshot = await docRef.get();

      if (snapshot.exists && snapshot.data() != null) {
        await docRef.update({
          'quantity': FieldValue.increment(1),
        });
        print("✅ تم زيادة كمية المنتج [${product.title}] في السيرفر.");
      } else {
        await docRef.set(product);
        print("✅ تم إضافة منتج جديد [${product.title}] للسيرفر باستخدام الـ Converter.");
      }
    } catch (e) {
      print("🚨 حصل خطأ أثناء الإضافة للـ Firestore: $e");
    }
  }

  @override
  Future<void> deleteItemFromRemoteCart(int productId) {
    final cartRef = getUserCartRef();
    return cartRef.doc(productId.toString()).delete();
  }

  @override
  Future<List<FirestoreProduct>> getRemoteCartItems() {
    final cartRef = getUserCartRef();
    return cartRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Future<void> updateRemoteQuantity(int productId, int quantity) {
    final cartRef = getUserCartRef();

    if (quantity <= 0) {
      return deleteItemFromRemoteCart(productId);
    }

    return cartRef.doc(productId.toString()).update({
      'quantity': quantity,
    });
  }
}