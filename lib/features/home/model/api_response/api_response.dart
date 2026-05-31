import 'package:ecommerce_app/features/home/model/api_response/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  final List<ProductModel>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ApiResponse({this.products, this.total, this.skip, this.limit});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

ApiResponse deserializeApiResponse(Map<String, dynamic> json) => ApiResponse.fromJson(json);