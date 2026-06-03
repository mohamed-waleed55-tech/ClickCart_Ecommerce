import 'package:ecommerce_app/features/home/data/products_repository/api_result.dart';
import 'package:ecommerce_app/features/payment/data/payment_repository/payment_service_repo.dart';
import 'package:retrofit/dio.dart';

import '../../../../core/networking/payment_api_service.dart';
import '../../../home/data/api_error_handling/network_exceptions.dart';

class PaymentServiceRepoImp extends PaymentServiceRepo {
  final PaymentApiService _paymentApiService;

  PaymentServiceRepoImp(this._paymentApiService);

  @override
  Future<ApiResult<HttpResponse<dynamic>>> executePayment({
    required Map<String, dynamic> paymentBody,
  }) async {
    try {
      final response = await _paymentApiService.executePayment(
         paymentBody,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<HttpResponse<dynamic>>> getAuthToken({
    required Map<String, dynamic> apiKeyBody,
  }) async {
    try {
      final response = await _paymentApiService.getAuthToken(apiKeyBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<HttpResponse<dynamic>>> getOrderId({
    required Map<String, dynamic> orderBody,
  }) async {
    try {
      final response = await _paymentApiService.createOrder(orderBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<HttpResponse<dynamic>>> getPaymentKey({
    required Map<String, dynamic> paymentKeyBody,
  }) async {
    try {
      final response = await _paymentApiService.getPaymentKey(paymentKeyBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
