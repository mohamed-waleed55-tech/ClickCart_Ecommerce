
import 'package:retrofit/retrofit.dart';

import 'package:ecommerce_app/features/home/data/products_repository/api_result.dart';

abstract class PaymentServiceRepo {
  Future<ApiResult<HttpResponse<dynamic>>>getAuthToken({required Map<String, dynamic> apiKeyBody});
  Future<ApiResult<HttpResponse<dynamic>>>getOrderId({required Map<String, dynamic> orderBody});
  Future<ApiResult<HttpResponse<dynamic>>>getPaymentKey({required Map<String, dynamic> paymentKeyBody});
  Future<ApiResult<HttpResponse<dynamic>>>executePayment({required Map<String, dynamic> paymentBody}
      );

}