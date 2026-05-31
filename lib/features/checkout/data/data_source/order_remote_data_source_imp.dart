import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/cart/model/firestore_product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'order_remote_data_source.dart';

class OrdersRemoteDataSourceImp extends OrderRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _currentUserId {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User must be authenticated.");
    return uid;
  }

  @override
  Future<void> processCheckout({
    required Map<String, dynamic> orderData,
    required List<FirestoreProduct> products,
    required void Function(WriteBatch batch) clearCartCallback,
  }) async {
    final orderId = orderData['orderId'] as String;
    final batch = _firestore.batch();

    final orderDocRef = _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('orders')
        .doc(orderId);

    batch.set(orderDocRef, orderData);

    for (var product in products) {
      final productDocRef = orderDocRef
          .collection('order_items')
          .doc(product.id.toString());
      batch.set(productDocRef, product.copyWith(isSynced: 1).toJson());
    }

    clearCartCallback(batch);

    await batch.commit();
  }
}
