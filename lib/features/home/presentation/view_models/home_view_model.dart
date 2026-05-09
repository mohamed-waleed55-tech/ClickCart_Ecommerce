import 'package:ecommerce_app/features/authentication/data/user_repository/user_repositroy.dart';
import 'package:ecommerce_app/features/home/data/products_repository/api_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cart/model/firestore_product.dart';
import '../../data/products_repository/products_repository.dart';
import '../../model/api_response/product_model.dart';
import '../../model/categorey/category_model.dart';
class HomeViewModel extends GetxController {
  final  UserRepository _userRepository;
  final ProductsRepository _productsRepository;

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  RxBool isLoading = false.obs;
  RxString error = "".obs;
  RxString selectedCategory = "".obs;
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  var isSearching = false.obs;
  final searchController = TextEditingController();
  RxString currentSearchQuery = "".obs;




  HomeViewModel(this._userRepository, this._productsRepository);

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    getProducts();
    searchController.addListener(() {
      currentSearchQuery.value = searchController.text;
    });
  }


  Future<void> fetchCategories() async {
      isLoading.value = true;
      var result = await _productsRepository.getCategoriesFromApi();
      result.when(success: (data){
        categories.assignAll(data);
        isLoading.value = false;
      }, failure: (networkExceptions){
        error.value = networkExceptions.toString();
        isLoading.value = false;
      });

  }

  void getProducts() async {
    try {
      isLoading.value = true;
      var result = await _productsRepository.getProductsFromApi();

      result.when(
        success: (data) {
          products.assignAll(data);
        },
        failure: (networkExceptions) {
          error.value = networkExceptions.toString();
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    isLoading.value = true;

    final result = await _productsRepository.searchProducts(query);
    result.when(
      success: (data) {
        filteredProducts.assignAll(data);
        isLoading.value = false;
      },
      failure: (error) {
        isLoading.value = false;
      },
    );
  }

  void clearSearch() {
    searchController.clear();
    searchController.dispose();
    isSearching.value = false;
    filteredProducts.clear();
  }
  void addProductToCart(ProductModel product)async {
    FirestoreProduct firestoreProduct = FirestoreProduct(
      id: product.id,
      title: product.title,
      price: product.price.toString(),
      stock: product.stock.toString(),
      image: product.thumbnail,
      discountPercentage: product.discountPercentage,
      quantity: 1,
    );

    try{
      await _userRepository.addProductToCart(firestoreProduct);
      Get.snackbar("Success", "Product added to cart");


    }catch(e){
      Get.snackbar("Error", "Failed to add product to cart");
    }
  }
}
