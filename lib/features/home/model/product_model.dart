import '../../../core/assets/images_manager.dart';

class ProductModel {
  String id;
  String name;
  String shop;
  String price;
  String image;
  ProductModel(this.id, this.name, this.shop, this.price, this.image);
  static List <ProductModel> products = [
    ProductModel("1", "Product 1", "Shop 1", "100", ImagesManager.facebook),
    ProductModel("2", "Product 2", "Shop 2", "200", ImagesManager.facebook),
    ProductModel("3", "Product 3", "Shop 3", "300", ImagesManager.facebook),
    ProductModel("4", "Product 4", "Shop 4", "400", ImagesManager.facebook),
    ProductModel("5", "Product 5", "Shop 5", "500", ImagesManager.facebook),
    ProductModel("6", "Product 6", "Shop 6", "600", ImagesManager.facebook),
  ];
}