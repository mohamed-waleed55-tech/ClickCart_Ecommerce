import 'package:ecommerce_app/core/assets/images_manager.dart';

import '../../../core/assets/svg_icons_manager.dart';

class CategoryModel {
  String id;
  String categoryName;
  String image;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['categoryName'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'categoryName': categoryName, 'image': image};
  }
  static List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      categoryName: 'Women',
      image: ImagesManager.women,
    ),
    CategoryModel(
      id: '2',
      categoryName: 'Men',
      image: ImagesManager.men,
    ),
    CategoryModel(
      id: '3',
      categoryName: 'Gadgets',
      image: ImagesManager.gadgets,
    ),
    CategoryModel(
      id: '4',
      categoryName: 'Devices',
      image: ImagesManager.devices,
    ),
    CategoryModel(
      id: '5',
      categoryName: 'Gaming',
      image: ImagesManager.gaming,
    ),
    CategoryModel(
      id: '6',
      categoryName: 'Shoes',
      image: ImagesManager.shoes,
    ),
    CategoryModel(
      id: '7',
      categoryName: 'Bags',
      image: ImagesManager.bags,
    ),
    CategoryModel(
      id: '8',
      categoryName: 'Watches',
      image: ImagesManager.watches,
    ),
    CategoryModel(
      id: '9',
      categoryName: 'Beauty',
      image: ImagesManager.beauty,
    ),
    CategoryModel(
      id: '10',
      categoryName: 'Sports',
      image: ImagesManager.sports,
    ),
    CategoryModel(
      id: '11',
      categoryName: 'Kids',
      image: ImagesManager.kids,
    ),
    CategoryModel(
      id: '12',
      categoryName: 'Home',
      image: ImagesManager.home,
    ),
  ];

}
