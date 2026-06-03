import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_api_service.g.dart';

@RestApi(baseUrl: "https://accept.paymob.com/api/")
abstract class PaymentApiService {
  factory PaymentApiService(Dio dio, {String baseUrl}) = _PaymentApiService;

  @POST("auth/tokens")
  Future<HttpResponse<dynamic>> getAuthToken(
      @Body() Map<String, dynamic> apiKeyBody,
      );

  @POST("ecommerce/orders")
  Future<HttpResponse<dynamic>> createOrder(
      @Body() Map<String, dynamic> orderBody,
      );

  @POST("acceptance/payment_keys")
  Future<HttpResponse<dynamic>> getPaymentKey(
      @Body() Map<String, dynamic> paymentKeyBody,
      );

  @POST("acceptance/payments/pay")
  Future<HttpResponse<dynamic>> executePayment(
      @Body() Map<String, dynamic> paymentBody,
      );
}