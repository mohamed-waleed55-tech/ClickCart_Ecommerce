import 'package:get/get.dart';

import '../../data/category_repository/category_repository.dart';
import '../../data/products_repository/products_repository.dart';
import '../../model/category_model.dart';
import '../../model/product_model.dart';

class HomeViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    getProducts();
  }

  final CategoryRepository _categoryRepository;
  final ProductsRepository _productsRepository;
  List<ProductModel> _products = <ProductModel>[];
  RxBool isLoading = false.obs;
  RxString error = "".obs;


  List<ProductModel> get products => _products;
  List<CategoryModel> _categories = <CategoryModel>[];

  HomeViewModel(this._categoryRepository, this._productsRepository);

  List<CategoryModel> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      _categories = await _categoryRepository.getCategories();

    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void getProducts() async {
    _products = await _productsRepository.getProducts();
    update();
  }
}
