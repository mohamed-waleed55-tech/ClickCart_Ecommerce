import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://generativelanguage.googleapis.com/v1beta/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("models/gemini-3.6-flash:generateContent")
  Future<HttpResponse<dynamic>> parseUserIntent(
    @Query("key") String apiKey,
    @Body() Map<String, dynamic> body,
  );
}