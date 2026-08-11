// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseErrorModel _$ResponseErrorModelFromJson(Map<String, dynamic> json) =>
    ResponseErrorModel(
      message: json['message'] as String? ?? 'Unknown error',
      code: (json['code'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ResponseErrorModelToJson(ResponseErrorModel instance) =>
    <String, dynamic>{'message': instance.message, 'code': instance.code};
