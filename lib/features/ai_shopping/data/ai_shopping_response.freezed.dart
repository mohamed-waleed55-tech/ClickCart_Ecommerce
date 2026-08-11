// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_shopping_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiShoppingResponse {

 String? get category; double? get maxPrice; String? get searchQuery; String get replyText;
/// Create a copy of AiShoppingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiShoppingResponseCopyWith<AiShoppingResponse> get copyWith => _$AiShoppingResponseCopyWithImpl<AiShoppingResponse>(this as AiShoppingResponse, _$identity);

  /// Serializes this AiShoppingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiShoppingResponse&&(identical(other.category, category) || other.category == category)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.replyText, replyText) || other.replyText == replyText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,maxPrice,searchQuery,replyText);

@override
String toString() {
  return 'AiShoppingResponse(category: $category, maxPrice: $maxPrice, searchQuery: $searchQuery, replyText: $replyText)';
}


}

/// @nodoc
abstract mixin class $AiShoppingResponseCopyWith<$Res>  {
  factory $AiShoppingResponseCopyWith(AiShoppingResponse value, $Res Function(AiShoppingResponse) _then) = _$AiShoppingResponseCopyWithImpl;
@useResult
$Res call({
 String? category, double? maxPrice, String? searchQuery, String replyText
});




}
/// @nodoc
class _$AiShoppingResponseCopyWithImpl<$Res>
    implements $AiShoppingResponseCopyWith<$Res> {
  _$AiShoppingResponseCopyWithImpl(this._self, this._then);

  final AiShoppingResponse _self;
  final $Res Function(AiShoppingResponse) _then;

/// Create a copy of AiShoppingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = freezed,Object? maxPrice = freezed,Object? searchQuery = freezed,Object? replyText = null,}) {
  return _then(_self.copyWith(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,replyText: null == replyText ? _self.replyText : replyText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiShoppingResponse].
extension AiShoppingResponsePatterns on AiShoppingResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiShoppingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiShoppingResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiShoppingResponse value)  $default,){
final _that = this;
switch (_that) {
case _AiShoppingResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiShoppingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AiShoppingResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? category,  double? maxPrice,  String? searchQuery,  String replyText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiShoppingResponse() when $default != null:
return $default(_that.category,_that.maxPrice,_that.searchQuery,_that.replyText);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? category,  double? maxPrice,  String? searchQuery,  String replyText)  $default,) {final _that = this;
switch (_that) {
case _AiShoppingResponse():
return $default(_that.category,_that.maxPrice,_that.searchQuery,_that.replyText);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? category,  double? maxPrice,  String? searchQuery,  String replyText)?  $default,) {final _that = this;
switch (_that) {
case _AiShoppingResponse() when $default != null:
return $default(_that.category,_that.maxPrice,_that.searchQuery,_that.replyText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiShoppingResponse implements AiShoppingResponse {
  const _AiShoppingResponse({this.category, this.maxPrice, this.searchQuery, required this.replyText});
  factory _AiShoppingResponse.fromJson(Map<String, dynamic> json) => _$AiShoppingResponseFromJson(json);

@override final  String? category;
@override final  double? maxPrice;
@override final  String? searchQuery;
@override final  String replyText;

/// Create a copy of AiShoppingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiShoppingResponseCopyWith<_AiShoppingResponse> get copyWith => __$AiShoppingResponseCopyWithImpl<_AiShoppingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiShoppingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiShoppingResponse&&(identical(other.category, category) || other.category == category)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.replyText, replyText) || other.replyText == replyText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,maxPrice,searchQuery,replyText);

@override
String toString() {
  return 'AiShoppingResponse(category: $category, maxPrice: $maxPrice, searchQuery: $searchQuery, replyText: $replyText)';
}


}

/// @nodoc
abstract mixin class _$AiShoppingResponseCopyWith<$Res> implements $AiShoppingResponseCopyWith<$Res> {
  factory _$AiShoppingResponseCopyWith(_AiShoppingResponse value, $Res Function(_AiShoppingResponse) _then) = __$AiShoppingResponseCopyWithImpl;
@override @useResult
$Res call({
 String? category, double? maxPrice, String? searchQuery, String replyText
});




}
/// @nodoc
class __$AiShoppingResponseCopyWithImpl<$Res>
    implements _$AiShoppingResponseCopyWith<$Res> {
  __$AiShoppingResponseCopyWithImpl(this._self, this._then);

  final _AiShoppingResponse _self;
  final $Res Function(_AiShoppingResponse) _then;

/// Create a copy of AiShoppingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? maxPrice = freezed,Object? searchQuery = freezed,Object? replyText = null,}) {
  return _then(_AiShoppingResponse(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,replyText: null == replyText ? _self.replyText : replyText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
