import 'package:ecommerce_app/core/error_handling/network_exceptions.dart';
import 'package:ecommerce_app/features/home/data/products_repository/api_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/products_repository/products_repository.dart';
import '../../model/api_response/product_model.dart';
import '../../model/categorey/category_model.dart';

class HomeViewModel extends GetxController {
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

  HomeViewModel(this._productsRepository);
  
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCategories();
      getProducts();
    });
    searchController.addListener(() {
      currentSearchQuery.value = searchController.text;
    });
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    var result = await _productsRepository.getCategoriesFromApi();
    result.when(
      success: (data) {
        categories.assignAll(data);
        isLoading.value = false;
      },
      failure: (networkExceptions) {
        error.value = networkExceptions.toString();
        isLoading.value = false;
      },
    );
  }

  void getProducts() async {
    try {
      isLoading.value = true;
      var result = await _productsRepository.getProductsFromApi();

      result.when(
        success: (data) {
          debugPrint("========== SUCCESS ==========");
          debugPrint("Products Count: ${data.length}");
          products.assignAll(data);
        },
        failure: (networkExceptions) {
          debugPrint("========== failure ==========");
          debugPrint("Products Error: ${networkExceptions.toString()}");
          error.value = NetworkExceptions.getErrorMessage(networkExceptions as NetworkExceptions);
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
}
