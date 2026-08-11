import 'package:ecommerce_app/features/ai_shopping/data/ai_repo.dart';
import 'package:ecommerce_app/features/ai_shopping/model/chat_message.dart';
import 'package:ecommerce_app/features/home/data/products_repository/api_result.dart';
import 'package:ecommerce_app/features/home/data/products_repository/products_repository.dart';
import 'package:ecommerce_app/features/home/model/api_response/product_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AiChatController extends GetxController {
  final AiAssistantRepository repository;
  final ProductsRepository productsRepository; // تأكد من استخدام هذا المتغير

  AiChatController({
    required this.repository,
    required this.productsRepository,
  });

  final messages = <ChatMessage>[].obs;
  final isLoading = false.obs;
  final searchResults = <ProductModel>[].obs; // أضف هذه القائمة لعرض النتائج في الواجهة

Future<void> sendMessage(String text) async {
  if (text.trim().isEmpty) return;

  messages.add(ChatMessage(text: text, type: MessageType.user, time: DateTime.now()));
  isLoading.value = true;
  searchResults.clear();

  try {
    final aiResponse = await repository.getShoppingIntent(text);
    
    // إضافة رد الـ AI في الشات
    messages.add(ChatMessage(text: aiResponse.replyText, type: MessageType.assistant, time: DateTime.now()));

    // 1. منطق التوجيه: التصنيفات
    if (aiResponse.category != null) {
      final result = await productsRepository.getProductsByCategory(aiResponse.category!);
      result.when(
        success: (products) => searchResults.assignAll(products),
        failure: (error) => messages.add(ChatMessage(text: "عذراً، تعذر جلب منتجات هذا التصنيف.", type: MessageType.assistant, time: DateTime.now())),
      );
    } 
    // 2. منطق التوجيه: البحث
    else if (aiResponse.searchQuery != null) {
      final result = await productsRepository.searchProducts(aiResponse.searchQuery!);
      result.when(
        success: (products) => searchResults.assignAll(products),
        failure: (error) => messages.add(ChatMessage(text: "عذراً، لم أجد نتائج لهذا البحث.", type: MessageType.assistant, time: DateTime.now())),
      );
    } 
    else {
      final result = await productsRepository.getProductsFromApi();
      result.when(
        success: (products) => searchResults.assignAll(products),
        failure: (error) => messages.add(ChatMessage(text: "عذراً، حدث خطأ في جلب المنتجات.", type: MessageType.assistant, time: DateTime.now())),
      );
    }
  } catch (e) {
    print("Error in Controller: $e");
    messages.add(ChatMessage(text: "عذراً، حدث خطأ غير متوقع.", type: MessageType.assistant, time: DateTime.now()));
  } finally {
    isLoading.value = false;
  }
}
}