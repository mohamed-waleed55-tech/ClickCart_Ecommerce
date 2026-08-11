// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['orderId'] as String,
  orderDate: json['orderDate'] as String,
  status: json['status'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  deliveryOption: (json['deliveryOption'] as num).toInt(),
  shippingAddress: Map<String, String>.from(json['shippingAddress'] as Map),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.id,
      'orderDate': instance.orderDate,
      'status': instance.status,
      'totalAmount': instance.totalAmount,
      'deliveryOption': instance.deliveryOption,
      'shippingAddress': instance.shippingAddress,
    };
