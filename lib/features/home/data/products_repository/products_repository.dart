import '../../model/product_model.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> getProducts();

  Future<void> uploadingProducts();
}
