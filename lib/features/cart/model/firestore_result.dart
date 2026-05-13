import 'package:freezed_annotation/freezed_annotation.dart';
import '../../home/data/api_error_handling/network_exceptions.dart';

part 'firestore_result.freezed.dart';
@Freezed(genericArgumentFactories: true)
sealed class FirestoreResult<T> with _$FirestoreResult<T> {
  const factory FirestoreResult.success(T data) = Success<T>;
  const factory FirestoreResult.failure(NetworkExceptions error) = Failure<T>;
}