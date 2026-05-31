import '../../../../../core/database/database_helper.dart';
import '../../../model/firestore_product.dart';
import 'cart_local_data_source.dart';

class CartLocalDataSourceImp implements CartLocalDataSource {
  final DatabaseHelper _dbHelper;

  CartLocalDataSourceImp(this._dbHelper);

  @override
  Future<void> insertOrUpdateProduct(FirestoreProduct product) async {
    try {
      final db = await _dbHelper.database;

      final List<Map<String, dynamic>> result = await db.query(
        'local_cart',
        where: 'id = ?',
        whereArgs: [product.id],
      );

      if (result.isNotEmpty) {
        final dynamic dbQty = result.first['quantity'];
        int currentQty = (dbQty is int) ? dbQty : (int.tryParse(dbQty?.toString() ?? '1') ?? 1);

        await db.update(
          'local_cart',
          {'quantity': currentQty + 1},
          where: 'id = ?',
          whereArgs: [product.id],
        );
      } else {
        final Map<String, dynamic> safeProductMap = {
          'id': product.id,
          'title': product.title ?? 'Unknown Product',
          'price': product.price ?? '0.0',
          'stock': product.stock ?? '0',
          'image': product.image ?? '',
          'discountPercentage': product.discountPercentage ?? 0.0,
          'quantity': product.quantity ?? 1,
        };

        await db.insert(
          'local_cart',
          safeProductMap,
        );
      }
    } catch (e) {
      throw Exception("Failed to insert/update product in local storage: $e");
    }
  }
  @override
  Future<List<FirestoreProduct>> getLocalCartItems() async {
    try {
      final db = await _dbHelper.database;

      final List<Map<String, dynamic>> result = await db.query('local_cart');

      return result.map((json) => FirestoreProduct.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to fetch local cart items: $e");
    }
  }

  @override
  Future<void> updateProductQuantity(int id, int newQuantity) async {
    try {
      final db = await _dbHelper.database;

      if (newQuantity <= 0) {
        await deleteProduct(id);
      } else {
        await db.update(
          'local_cart',
          {'quantity': newQuantity},
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    } catch (e) {
      throw Exception("Failed to update product quantity: $e");
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      final db = await _dbHelper.database;

      await db.delete(
        'local_cart',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Failed to delete product from local storage: $e");
    }
  }

  @override
  Future<void> clearLocalCartAfterCheckout()async {
   await _dbHelper.clearLocalCart();


  }


}