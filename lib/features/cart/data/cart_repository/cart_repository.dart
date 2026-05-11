
import '../../model/firestore_product.dart';
import '../../model/firestore_result.dart';

abstract class CartRepository {
  Future<void> addProductToCart(FirestoreProduct product);
  Future<void> updateCartItemQuantity(int productId, int newQuantity);
  Future<void> removeProductFromCart(int productId);
  Future<FirestoreResult<List<FirestoreProduct>>> getRemoteCarts();
  Future<void> insertOrUpdateProduct(FirestoreProduct product);
  Future<FirestoreResult<List<FirestoreProduct>>> getLocalCarts();
  Future<void> updateProductQuantity(int id, int newQuantity);
  Future<void> deleteProduct(int id);
}