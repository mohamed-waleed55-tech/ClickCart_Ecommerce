// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  pic: json['pic'] as String,
  phoneNumber: json['phoneNumber'] as String,
  fName: json['fName'] as String,
  lName: json['lName'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'pic': instance.pic,
  'phoneNumber': instance.phoneNumber,
  'fName': instance.fName,
  'lName': instance.lName,
};
