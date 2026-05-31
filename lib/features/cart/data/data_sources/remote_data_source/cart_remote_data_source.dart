import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/firestore_product.dart';

abstract class CartRemoteDataSource {
  Future<void> addToRemoteCart(FirestoreProduct product);
  Future<void> deleteItemFromRemoteCart(int productId);
  Future<void> updateRemoteQuantity(int productId, int quantity);
  Future<List<FirestoreProduct>> getRemoteCartItems();
  Future<void> clearRemoteCartAfterCheckout(WriteBatch batch) ;

  }