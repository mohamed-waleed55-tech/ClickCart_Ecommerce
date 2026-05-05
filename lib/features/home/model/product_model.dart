class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  final String id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };
  }
  static const List<ProductModel> products = [
    ProductModel(
      id: "1",
      title: 'Wireless Headphones',
      price: 59.99,
      description: 'Comfortable wireless headphones with clear sound and long battery life.',
      category: 'Gadgets',
      image: 'https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg',
    ),
    ProductModel(
      id: "2",
      title: 'Smart Watch',
      price: 89.99,
      description: 'Stylish smart watch with fitness tracking and notification support.',
      category: 'Watches',
      image: 'https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg',
    ),
    ProductModel(
      id: "3",
      title: 'Gaming Controller',
      price: 39.99,
      description: 'Responsive gaming controller for smooth and comfortable gameplay.',
      category: 'Gaming',
      image: 'https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg',
    ),
    ProductModel(
      id: "4",
      title: 'Running Shoes',
      price: 74.99,
      description: 'Lightweight running shoes designed for daily comfort and training.',
      category: 'Shoes',
      image: 'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
    ),
    ProductModel(
      id: "5",
      title: 'Leather Bag',
      price: 49.99,
      description: 'Everyday leather bag with a clean look and practical storage.',
      category: 'Bags',
      image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    ),
    ProductModel(
      id: "6",
      title: 'Casual Jacket',
      price: 64.99,
      description: 'Modern casual jacket made for easy everyday styling.',
      category: 'Men',
      image: 'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg',
    ),
    ProductModel(
      id: "7",
      title: 'Women Handbag',
      price: 54.99,
      description: 'Elegant handbag with a compact shape and premium finish.',
      category: 'Women',
      image: 'https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg',
    ),
    ProductModel(
      id: "8",
      title: 'Home Lamp',
      price: 29.99,
      description: 'Minimal table lamp that adds warm lighting to your home.',
      category: 'Home',
      image: 'https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg',
    ),
  ];

}
