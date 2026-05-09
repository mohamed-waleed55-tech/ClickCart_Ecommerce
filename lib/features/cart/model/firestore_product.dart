import 'package:freezed_annotation/freezed_annotation.dart';

part 'firestore_product.g.dart';

@JsonSerializable()
class FirestoreProduct {
  int? id;
  String? title;
  String? price;
  String? stock;
  String? image;
  double? discountPercentage;
  int? quantity;

  FirestoreProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.image,
    required this.discountPercentage,
    required this.quantity,
  });

  factory FirestoreProduct.fromJson(Map<String, dynamic> json) =>
      _$FirestoreProductFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreProductToJson(this);
}
