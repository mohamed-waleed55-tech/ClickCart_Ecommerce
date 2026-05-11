import '../../../home/data/api_error_handling/network_exceptions.dart';
import '../../model/firestore_product.dart';
import '../../model/firestore_result.dart';
import '../data_sources/local_data_source/cart_local_data_source.dart';
import '../data_sources/remote_data_source/cart_remote_data_source.dart';
import 'cart_repository.dart';

class CartRepositoryImp implements CartRepository {
  final CartLocalDataSource _localDataSource;
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImp(this._localDataSource, this._remoteDataSource);

  @override
  Future<void> addProductToCart(FirestoreProduct product) async {
    try {
      await Future.wait([
        _localDataSource.insertOrUpdateProduct(product),
        _remoteDataSource.addToRemoteCart(product),
      ]);
      print("✅ تم الحفظ في الـ Local والـ Remote بنجاح بالتوازي!");
    } catch (e) {
      print("🚨 حصلت مشكلة أثناء الحفظ: $e");
    }
  }

  @override
  Future<void> removeProductFromCart(int productId) async {
    await _remoteDataSource.deleteItemFromRemoteCart(productId);
    await _localDataSource.deleteProduct(productId);
  }

  @override
  Future<void> updateCartItemQuantity(int productId, int newQuantity) async {
    await _remoteDataSource.updateRemoteQuantity(productId, newQuantity);
    return await _localDataSource.updateProductQuantity(productId, newQuantity);
  }

  @override
  Future<void> deleteProduct(int id) async {
    await _localDataSource.deleteProduct(id);
  }

  @override
  Future<FirestoreResult<List<FirestoreProduct>>> getLocalCarts() async {
    try {
      final carts = await _localDataSource.getLocalCartItems();
      return FirestoreResult.success(carts);
    } catch (e) {
      return FirestoreResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<void> insertOrUpdateProduct(FirestoreProduct product) async {
    await _localDataSource.insertOrUpdateProduct(product);
  }

  @override
  Future<void> updateProductQuantity(int id, int newQuantity) async {
    await _localDataSource.updateProductQuantity(id, newQuantity);
  }

  @override
  Future<FirestoreResult<List<FirestoreProduct>>> getRemoteCarts() async {
    try {
      final carts = await _remoteDataSource.getRemoteCartItems();
      return FirestoreResult.success(carts);
    } catch (e) {
      return FirestoreResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
