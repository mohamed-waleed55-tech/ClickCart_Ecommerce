import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';
@JsonSerializable()
class CategoryModel {
  final String? slug;
  final String? name;
  final String? url;

  CategoryModel({this.slug, this.name, this.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}