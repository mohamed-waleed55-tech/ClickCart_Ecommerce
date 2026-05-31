import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../cart/model/firestore_product.dart';

abstract class OrderRemoteDataSource {
  Future<void> processCheckout({
    required Map<String, dynamic> orderData,
    required List<FirestoreProduct> products,
    required Future<void> Function(WriteBatch batch) clearCartCallback,
  });

}