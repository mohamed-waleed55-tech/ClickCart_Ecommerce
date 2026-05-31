import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../home/data/api_error_handling/network_exceptions.dart';
import '../../model/firestore_product.dart';
import '../../model/firestore_result.dart';
import '../data_sources/local_data_source/cart_local_data_source.dart';
import '../data_sources/remote_data_source/cart_remote_data_source.dart';
import '../sync_manager/sync_manager.dart';
import 'cart_repository.dart';

class CartRepositoryImp implements CartRepository {
  final CartLocalDataSource _localDataSource;
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImp(this._localDataSource, this._remoteDataSource);

  @override
  Future<void> addProductToCart(FirestoreProduct product) async {
    try {
      final localProduct = product.copyWith(isSynced: 0);

      await _localDataSource.insertOrUpdateProduct(localProduct);
      print(
        "✅ تم الحفظ في قاعدة البيانات المحلية بنجاح. الـ SyncManager سيتولى الرفع لاحقاً.",
      );

      Get.find<CartSyncManager>().syncLocalCartToFirestore();
    } catch (e) {
      print("🚨 حصلت مشكلة أثناء الحفظ المحلي: $e");
    }
  }

  @override
  Future<void> removeProductFromCart(int productId) async {
    await _remoteDataSource.deleteItemFromRemoteCart(productId);
    await _localDataSource.deleteProduct(productId);
  }

  @override
  Future<void> updateCartItemQuantity(int productId, int newQuantity) async {
    await _localDataSource.updateProductQuantity(productId, newQuantity);

    try {
      await _remoteDataSource.updateRemoteQuantity(productId, newQuantity);
    } catch (error) {
      throw Exception("Failed to sync with server. Reverting changes.");
    }
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
  Future<void> insertOrUpdateProduct(FirestoreProduct remoteProduct) async {
    remoteProduct = remoteProduct.copyWith(isSynced: 1);
    await _localDataSource.insertOrUpdateProduct(remoteProduct);
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


  @override
  void clearRemoteCartBeforeCommit(WriteBatch batch) {
    _remoteDataSource.clearRemoteCartAfterCheckout(batch);
  }

  @override
  Future<void> clearLocalCartAfterCheckout() async {
    await _localDataSource.clearLocalCartAfterCheckout();
  }
}
