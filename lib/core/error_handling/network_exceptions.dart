import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'response_error_model.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.unauthorizedRequest(String reason) = UnauthorizedRequest;
  const factory NetworkExceptions.badRequest() = BadRequest;
  const factory NetworkExceptions.notFound(String reason) = NotFound;
  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;
  const factory NetworkExceptions.notAcceptable() = NotAcceptable;
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;
  const factory NetworkExceptions.sendTimeout() = SendTimeout;
  const factory NetworkExceptions.unprocessableEntity(String reason) = UnprocessableEntity;
  const factory NetworkExceptions.conflict() = Conflict;
  const factory NetworkExceptions.internalServerError() = InternalServerError;
  const factory NetworkExceptions.notImplemented() = NotImplemented;
  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  const factory NetworkExceptions.formatException() = FormatException;
  const factory NetworkExceptions.unableToProcess() = UnableToProcess;
  const factory NetworkExceptions.defaultError(String error) = DefaultError;
  const factory NetworkExceptions.unexpectedError() = UnexpectedError;


  const factory NetworkExceptions.firebaseAuthError(String message) = FirebaseAuthError;
  const factory NetworkExceptions.firebaseFirestoreError(String message) = FirebaseFirestoreError;
  const factory NetworkExceptions.firebaseDatabaseError(String message) = FirebaseDatabaseError;
  const factory NetworkExceptions.firebaseStorageError(String message) = FirebaseStorageError;
  const factory NetworkExceptions.agoraConnectionError(String message) = AgoraConnectionError;
  const factory NetworkExceptions.agoraTokenExpired() = AgoraTokenExpired;

  static NetworkExceptions handleResponse(Response? response) {
    String allErrors = "Unexpected error occurred";

    if (response?.data != null) {
      if (response?.data is Map) {
        try {
          final apiError = ResponseErrorModel.fromJson(response?.data as Map<String, dynamic>);
          allErrors = apiError.displayMessage;
        } catch (e) {
          allErrors = response?.data['error']?['message'] ?? response?.data['message'] ?? "Unknown Error";
        }
      } else if (response?.data is List) {
        try {
          List<ResponseErrorModel> listOfErrors = List.from(response?.data)
              .map((e) => ResponseErrorModel.fromJson(e))
              .toList();
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
        return NetworkExceptions.defaultError("Received invalid status code: $statusCode");
    }
  }
static NetworkExceptions getFirebaseException(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return const NetworkExceptions.firebaseAuthError("This email address is not registered.");
        default:
          return NetworkExceptions.firebaseAuthError(error.message ?? "Authentication failed.");
      }
    } 
    else if (error is FirebaseException && error.plugin == 'firebase_database') { 
      switch (error.code) {
        case 'unauthorized':
        case 'permission-denied': 
        return const NetworkExceptions.firebaseStorageError("You do not have permission to access this file.");
        case 'unavailable':
          return const NetworkExceptions.noInternetConnection();
        default:
          return NetworkExceptions.firebaseDatabaseError(error.message ?? "Database error occurred.");
      }
    } 
    else if (error is FirebaseException && error.plugin == 'firebase_storage') {
      switch (error.code) {
        case 'object-not-found':
          return const NetworkExceptions.firebaseStorageError("The requested file does not exist on the server.");
        case 'unauthorized':
          return const NetworkExceptions.firebaseStorageError("You do not have permission to access this file.");
        case 'canceled':
          return const NetworkExceptions.firebaseStorageError("The upload/download operation was canceled.");
        case 'unknown':
          return const NetworkExceptions.firebaseStorageError("An unknown error occurred with the storage server.");
        case 'retry-limit-exceeded':
          return const NetworkExceptions.firebaseStorageError("The operation exceeded the retry limit.");
        case 'non-matching-checksum':
          return const NetworkExceptions.firebaseStorageError("The file's checksum does not match the expected value.");  

        
        default:
          return NetworkExceptions.firebaseStorageError(error.message ?? "An error occurred with storage server.");
      }
    }
    else if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return const NetworkExceptions.firebaseFirestoreError("You do not have permission to access this data.");
        case 'unavailable':
          return const NetworkExceptions.noInternetConnection();
        default:
          return NetworkExceptions.firebaseFirestoreError(error.message ?? "An error occurred while connecting to the database.");
      }
    } else if (error is SocketException) {
      return const NetworkExceptions.noInternetConnection();
    } else {
      return const NetworkExceptions.unexpectedError();
    }
  }

  static NetworkExceptions getAgoraException(dynamic error) {
    if (error.toString().contains("109") || error.toString().toLowerCase().contains("token")) {
      return const NetworkExceptions.agoraTokenExpired();
    }
    return NetworkExceptions.agoraConnectionError(
      error.toString().isNotEmpty ? error.toString() : "Failed to connect to Agora streaming servers.",
    );
  }
static NetworkExceptions getDioException(dynamic error) {
    if (error is FirebaseAuthException || error is FirebaseException) {
      return getFirebaseException(error);
    }
    
    if (error.toString().contains("Agora") || error.toString().contains("Rtc")) {
      return getAgoraException(error);
    }

    try {
      if (error is DioException) { 
        switch (error.type) {
          case DioExceptionType.cancel:
            return const NetworkExceptions.requestCancelled();
          case DioExceptionType.connectionTimeout:
            return const NetworkExceptions.requestTimeout();
          case DioExceptionType.unknown:
            if (error.error is SocketException) {
              return const NetworkExceptions.noInternetConnection();
            }
            return const NetworkExceptions.noInternetConnection();
          case DioExceptionType.receiveTimeout:
            return const NetworkExceptions.sendTimeout();
          case DioExceptionType.badResponse:
            return NetworkExceptions.handleResponse(error.response);
          case DioExceptionType.sendTimeout:
            return const NetworkExceptions.sendTimeout();
          case DioExceptionType.badCertificate:
            return const NetworkExceptions.unexpectedError();
          case DioExceptionType.connectionError:
            return const NetworkExceptions.noInternetConnection();
          case DioExceptionType.transformTimeout:
            return const NetworkExceptions.sendTimeout();
          
        }
      } else if (error is SocketException) {
        return const NetworkExceptions.noInternetConnection();
      } else if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    } on FormatException catch (_) {
      return const NetworkExceptions.formatException();
    } catch (_) {
      return const NetworkExceptions.unexpectedError();
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(
      notImplemented: () => errorMessage = "Not Implemented",
      requestCancelled: () => errorMessage = "Request Cancelled",
      internalServerError: () => errorMessage = "Internal Server Error",
      notFound: (String reason) => errorMessage = reason,
      serviceUnavailable: () => errorMessage = "Service unavailable",
      methodNotAllowed: () => errorMessage = "Method Allowed",
      badRequest: () => errorMessage = "Bad request",
      unauthorizedRequest: (String error) => errorMessage = error,
      unprocessableEntity: (String error) => errorMessage = error,
      unexpectedError: () => errorMessage = "Unexpected error occurred",
      requestTimeout: () => errorMessage = "Connection request timeout",
      noInternetConnection: () => errorMessage = "No internet connection",
      conflict: () => errorMessage = "Error due to a conflict",
      sendTimeout: () => errorMessage = "Send timeout in connection with API server",
      unableToProcess: () => errorMessage = "Unable to process the data",
      defaultError: (String error) => errorMessage = error,
      formatException: () => errorMessage = "Unexpected error occurred",
      notAcceptable: () => errorMessage = "Not acceptable",
      firebaseAuthError: (String message) => errorMessage = message,
      firebaseFirestoreError: (String message) => errorMessage = message,
      firebaseDatabaseError: (String message) => errorMessage = message,
      firebaseStorageError: (String message) => errorMessage = message, 
      agoraConnectionError: (String message) => errorMessage = message,
      agoraTokenExpired: () => errorMessage = "Video chat session expired. Please rejoin the room.",
    );
    return errorMessage;
  }
}