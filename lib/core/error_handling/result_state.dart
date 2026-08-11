import 'package:ecommerce_app/core/error_handling/network_exceptions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'result_state.freezed.dart';

@freezed
sealed class ResultState<T> with _$ResultState<T> {
  const factory ResultState.success(T orders) = Success<T>;
  const factory ResultState.failure(NetworkExceptions networkExceptions) = Failure<T>;
}