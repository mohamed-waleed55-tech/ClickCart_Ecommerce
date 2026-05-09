import 'package:ecommerce_app/features/home/model/categorey/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>>getCategories();
}