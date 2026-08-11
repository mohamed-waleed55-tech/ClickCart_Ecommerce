import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_error_model.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  const factory NetworkExceptions.firebaseAuthError(String message) =
      FirebaseAuthError;

  const factory NetworkExceptions.firebaseFirestoreError(String message) =
      FirebaseFirestoreError;

  static NetworkExceptions handleResponse(Response? response) {
    String allErrors = "Unexpected error occurred";

    if (response?.data != null) {
      if (response?.data is Map) {
        try {
          final apiError = ApiErrorModel.fromJson(response?.data);
          allErrors = apiError.message ?? "Unknown Error";
        } catch (e) {
          allErrors = response?.data['message'] ?? "Unknown Error";
        }
      } else if (response?.data is List) {
        try {
          List<ApiErrorModel> listOfErrors = List.from(
            response?.data,
          ).map((e) => ApiErrorModel.fromJson(e)).toList();
          allErrors = listOfErrors.map((e) => e.message).join(", ");
        } catch (e) {
          allErrors = "Error parsing list of errors";
        }
      }
    }

    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkExceptions.unauthorizedRequest(allErrors);
      case 404:
        return NetworkExceptions.notFound(allErrors);
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unprocessableEntity(allErrors);
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return NetworkExceptions.defaultError(
          "Received invalid status code: $statusCode",
        );
    }
  }

  // =========================================================================
  //    Firebase (Auth & Firestore)
  // =========================================================================
  static NetworkExceptions getFirebaseException(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return const NetworkExceptions.firebaseAuthError(
            "This email address is not registered.",
          );
        case 'wrong-password':
          return const NetworkExceptions.firebaseAuthError(
            "Incorrect password. Please try again.",
          );
        case 'email-already-in-use':
          return const NetworkExceptions.firebaseAuthError(
            "This email is already in use by another account.",
          );
        case 'invalid-email':
          return const NetworkExceptions.firebaseAuthError(
            "The email address is badly formatted.",
          );
        case 'weak-password':
          return const NetworkExceptions.firebaseAuthError(
            "The password must be at least 6 characters.",
          );
        case 'network-request-failed':
          return const NetworkExceptions.noInternetConnection();
        default:
          return NetworkExceptions.firebaseAuthError(
            error.message ?? "Authentication failed. Please try again.",
          );
      }
    } else if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return const NetworkExceptions.firebaseFirestoreError(
            "You do not have permission to access this data.",
          );
        case 'unavailable':
          return const NetworkExceptions.noInternetConnection();
        default:
          return NetworkExceptions.firebaseFirestoreError(
            error.message ??
                "An error occurred while connecting to the database.",
          );
      }
    } else if (error is SocketException) {
      return const NetworkExceptions.noInternetConnection();
    } else {
      return const NetworkExceptions.unexpectedError();
    }
  }

  static NetworkExceptions getDioException(error) {
    if (error is FirebaseException || error is FirebaseAuthException) {
      return getFirebaseException(error);
    }

    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions = NetworkExceptions.handleResponse(
                error.response,
              );
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.unexpectedError();
              break;
            case DioExceptionType.connectionError:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.transformTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(
      notImplemented: () {
        errorMessage = "Not Implemented";
      },
      requestCancelled: () {
        errorMessage = "Request Cancelled";
      },
      internalServerError: () {
        errorMessage = "Internal Server Error";
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = "Service unavailable";
      },
      methodNotAllowed: () {
        errorMessage = "Method Allowed";
      },
      badRequest: () {
        errorMessage = "Bad request";
      },
      unauthorizedRequest: (String error) {
        errorMessage = error;
      },
      unprocessableEntity: (String error) {
        errorMessage = error;
      },
      unexpectedError: () {
        errorMessage = "Unexpected error occurred";
      },
      requestTimeout: () {
        errorMessage = "Connection request timeout";
      },
      noInternetConnection: () {
        errorMessage = "No internet connection";
      },
      conflict: () {
        errorMessage = "Error due to a conflict";
      },
      sendTimeout: () {
        errorMessage = "Send timeout in connection with API server";
      },
      unableToProcess: () {
        errorMessage = "Unable to process the data";
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = "Unexpected error occurred";
      },
      notAcceptable: () {
        errorMessage = "Not acceptable";
      },
      firebaseAuthError: (String message) {
        errorMessage = message;
      },
      firebaseFirestoreError: (String message) {
        errorMessage = message;
      },
    );
    return errorMessage;
  }
}
