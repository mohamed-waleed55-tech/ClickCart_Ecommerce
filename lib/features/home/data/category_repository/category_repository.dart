import 'package:ecommerce_app/features/home/model/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>>getCategories();
}