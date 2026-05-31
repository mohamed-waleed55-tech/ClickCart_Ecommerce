import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String street1;
  final String? street2;
  final String city;
  final String state;
  final String country;

  AddressModel({
    required this.street1,
    this.street2,
    required this.city,
    required this.state,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}