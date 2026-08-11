// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreProduct _$FirestoreProductFromJson(Map<String, dynamic> json) =>
    FirestoreProduct(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt(),
      image: json['image'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      isSynced: (json['is_synced'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$FirestoreProductToJson(FirestoreProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'stock': instance.stock,
      'image': instance.image,
      'discountPercentage': instance.discountPercentage,
      'quantity': instance.quantity,
      'is_synced': instance.isSynced,
    };
