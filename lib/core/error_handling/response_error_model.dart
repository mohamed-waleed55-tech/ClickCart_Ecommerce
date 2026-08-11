import 'package:json_annotation/json_annotation.dart';

part 'response_error_model.g.dart';

@JsonSerializable()
class ResponseErrorModel {
  @JsonKey(name: 'message', defaultValue: 'Unknown error')
  final String message;
  
  @JsonKey(name: 'code', defaultValue: 0)
  final int code;

  ResponseErrorModel({
    required this.message,
    required this.code,
  });

  factory ResponseErrorModel.fromJson(Map<String, dynamic> json) {
    if (json['error'] is Map<String, dynamic>) {
      return _$ResponseErrorModelFromJson(json['error'] as Map<String, dynamic>);
    }
    
    return _$ResponseErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResponseErrorModelToJson(this);

  String get displayMessage => code != 0 ? "[$code] $message" : message;
}