import 'package:ecommerce_app/features/home/data/api_error_handling/network_exceptions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_result_state.freezed.dart';

@freezed
sealed class ProfileResultState<T> with _$ProfileResultState<T> {
  const factory ProfileResultState.success(T orders) = Success<T>;
  const factory ProfileResultState.error(NetworkExceptions networkExceptions) = Error<T>;
}