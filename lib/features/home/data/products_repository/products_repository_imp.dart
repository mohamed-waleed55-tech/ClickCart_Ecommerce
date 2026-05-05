import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/home/data/products_repository/products_repository.dart';
import 'package:ecommerce_app/features/home/model/product_model.dart';

class ProductsRepositoryImp extends ProductsRepository {
  CollectionReference<ProductModel> getProductsCollection() {
    return FirebaseFirestore.instance
        .collection("products")
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) =>
              ProductModel.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final productsCollection = getProductsCollection();
    QuerySnapshot<ProductModel> productsDocs = await productsCollection.get();
    List<ProductModel> products = productsDocs.docs
        .map((doc) => doc.data())
        .toList();
    return products;
  }

  @override
  Future<void> uploadingProducts() async{
    final productsCollection = getProductsCollection();
    await Future.wait(
      ProductModel.products.map((e) {
        return productsCollection.doc(e.id).set(e);
      }),
    );

    return Future.value();
  }
}
