// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_shopping_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiShoppingResponse _$AiShoppingResponseFromJson(Map<String, dynamic> json) =>
    _AiShoppingResponse(
      category: json['category'] as String?,
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      searchQuery: json['searchQuery'] as String?,
      replyText: json['replyText'] as String,
    );

Map<String, dynamic> _$AiShoppingResponseToJson(_AiShoppingResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
      'maxPrice': instance.maxPrice,
      'searchQuery': instance.searchQuery,
      'replyText': instance.replyText,
    };
