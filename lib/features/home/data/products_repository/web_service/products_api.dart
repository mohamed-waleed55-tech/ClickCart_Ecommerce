import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/home/model/categorey/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../model/api_response/api_response.dart';

part 'products_api.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/',parser: Parser.FlutterCompute)
abstract class ProductsApi {
  factory ProductsApi(Dio dio, {String? baseUrl}) = _ProductsApi;

  @GET('products')
  Future<ApiResponse> getProductsFromApi();

  @GET('products/categories')
  Future<List<CategoryModel>> getCategoriesFromApi();

  @GET('products/category/{slug}')
  Future<ApiResponse> getProductsByCategory(@Path('slug') String slug);

  @GET('products/search')
  Future<ApiResponse> searchProducts(@Query('q') String query);
}
