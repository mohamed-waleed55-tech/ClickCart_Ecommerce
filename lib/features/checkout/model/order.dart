import 'package:json_annotation/json_annotation.dart';
import 'package:ecommerce_app/features/cart/model/firestore_product.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  @JsonKey(name: 'orderId')
  final String id;

  final String orderDate;
  final String status; // Pending, Shipped, Delivered, Cancelled
  final double totalAmount;
  final int deliveryOption;
  final Map<String, String> shippingAddress;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<FirestoreProduct>? items;

  OrderModel({
    required this.id,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    required this.deliveryOption,
    required this.shippingAddress,
    this.items,
  });

  OrderModel copyWith({
    String? id,
    String? orderDate,
    String? status,
    double? totalAmount,
    int? deliveryOption,
    Map<String, String>? shippingAddress,
    List<FirestoreProduct>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryOption: deliveryOption ?? this.deliveryOption,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      items: items ?? this.items,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}