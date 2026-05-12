import 'package:freezed_annotation/freezed_annotation.dart';

part 'firestore_product.g.dart';

@JsonSerializable()
class FirestoreProduct {
  int? id;
  String? title;
  double? price;
  int? stock;
  String? image;
  double? discountPercentage;
  int? quantity;

  @JsonKey(name: 'is_synced', defaultValue: 0)
  int? isSynced;

  FirestoreProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.image,
    required this.discountPercentage,
    required this.quantity,
    this.isSynced = 0,
  });

  factory FirestoreProduct.fromJson(Map<String, dynamic> json) =>
      _$FirestoreProductFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreProductToJson(this);

  FirestoreProduct copyWith({
    int? id,
    String? title,
    double? price,
    int? stock,
    String? image,
    double? discountPercentage,
    int? quantity,
    int? isSynced,
  }) {
    return FirestoreProduct(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      image: image ?? this.image,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      quantity: quantity ?? this.quantity,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}