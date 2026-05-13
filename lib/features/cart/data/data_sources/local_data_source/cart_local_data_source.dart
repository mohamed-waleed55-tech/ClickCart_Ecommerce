import '../../../model/firestore_product.dart';

abstract class CartLocalDataSource {
  Future<void> insertOrUpdateProduct(FirestoreProduct product);
  Future<List<FirestoreProduct>> getLocalCartItems();
  Future<void> updateProductQuantity(int id, int newQuantity);
  Future<void> deleteProduct(int id);
}