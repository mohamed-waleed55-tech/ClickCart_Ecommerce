import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_shopping_response.freezed.dart';
part 'ai_shopping_response.g.dart';
@freezed
abstract class AiShoppingResponse with _$AiShoppingResponse {
  const factory AiShoppingResponse({
    String? category,
    double? maxPrice,
    String? searchQuery,
    required String replyText,
  }) = _AiShoppingResponse;

  factory AiShoppingResponse.fromJson(Map<String, dynamic> json) =>
      _$AiShoppingResponseFromJson(json);
}