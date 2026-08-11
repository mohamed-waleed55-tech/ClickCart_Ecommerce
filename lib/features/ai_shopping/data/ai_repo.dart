import 'package:ecommerce_app/features/ai_shopping/data/ai_shopping_response.dart';

abstract class AiAssistantRepository {
  Future<AiShoppingResponse> getShoppingIntent(String userMessage);
}