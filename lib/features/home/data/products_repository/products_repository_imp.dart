import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/home/data/products_repository/api_result.dart';
import 'package:ecommerce_app/features/home/data/products_repository/products_repository.dart';
import 'package:ecommerce_app/features/home/data/products_repository/web_service/products_api.dart';
import 'package:ecommerce_app/features/home/model/categorey/category_model.dart';

import '../../model/api_response/product_model.dart';
import '../api_error_handling/network_exceptions.dart';

class ProductsRepositoryImp extends ProductsRepository {
  ProductsApi apiServices;

  ProductsRepositoryImp(this.apiServices);

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
  Future<List<ProductModel>> getProductsFromFirebase() async {
    final productsCollection = getProductsCollection();
    QuerySnapshot<ProductModel> productsDocs = await productsCollection.get();
    List<ProductModel> products = productsDocs.docs
        .map((doc) => doc.data())
        .toList();
    return products;
  }

  @override
  Future<void> uploadingProducts(List<ProductModel> products) async {
    final productsCollection = getProductsCollection();
    await Future.wait(
      products.map((e) {
        return productsCollection.doc(e.id.toString()).set(e);
      }),
    );

    return Future.value();
  }

  @override
  Future<ApiResult<List<ProductModel>>> getProductsFromApi() async {
    try {
      final response = await apiServices.getProductsFromApi();
      return ApiResult.success(response.products!);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<List<CategoryModel>>> getCategoriesFromApi() async {
    try {
      final response = await apiServices.getCategoriesFromApi();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<List<ProductModel>>> getProductsByCategory(String slug)async {
    try {
      final response = await apiServices.getProductsByCategory(slug);
      return ApiResult.success(response.products!);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<List<ProductModel>>> searchProducts(String query)async {
    try{
      final response = await apiServices.searchProducts(query);
      return ApiResult.success(response.products!);
    }catch (e){
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
