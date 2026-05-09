

import 'package:ecommerce_app/features/home/model/categorey/category_model.dart';

import '../../model/api_response/product_model.dart';
import 'api_result.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> getProductsFromFirebase();
  Future<void> uploadingProducts(List<ProductModel> products);
  Future<ApiResult<List<ProductModel>>> getProductsFromApi() ;
  Future<ApiResult<List<CategoryModel>>> getCategoriesFromApi();

  Future<ApiResult<List<ProductModel>>> getProductsByCategory(String slug) ;
  Future<ApiResult<List<ProductModel>>> searchProducts(String query) ;

  }
