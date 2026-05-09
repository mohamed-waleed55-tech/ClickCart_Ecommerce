import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/api_error_handling/network_exceptions.dart';
import '../../data/products_repository/api_result.dart';
import '../../data/products_repository/products_repository.dart';
import '../../model/api_response/product_model.dart';
import '../../model/categorey/category_model.dart';

class CategoryProductsViewModel extends GetxController {
  final ProductsRepository _repository;
  CategoryProductsViewModel(this._repository);

  var products = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final CategoryModel category = Get.arguments;
    fetchProducts(category.slug ?? "");
  }
  void onChanged(String query) async {
    if (query.isEmpty) {
      fetchProducts("");
      return;
    }

    isLoading.value = true;

    final result = await _repository.searchProducts(query);

    result.when(
      success: (data) {
        products.assignAll(data);
        isLoading.value = false;
      },
      failure: (networkExceptions) {
        isLoading.value = false;
        print("Search Error: ${NetworkExceptions.getErrorMessage(networkExceptions)}");
      },
    );
  }


  void fetchProducts(String slug) async {
    isLoading.value = true;
    final result = await _repository.getProductsByCategory(slug);
    result.when(
      success: (data) => products.assignAll(data),
      failure: (error) => null,
    );
    isLoading.value = false;
  }
}