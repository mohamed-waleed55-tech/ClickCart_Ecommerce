import 'package:ecommerce_app/features/ai_shopping/presentation/widgets/product_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/features/ai_shopping/presentation/view_model/ai_chat_controller.dart';
import 'package:ecommerce_app/features/ai_shopping/presentation/widgets/chat_bubble.dart';
import 'package:ecommerce_app/features/ai_shopping/presentation/widgets/chat_input.dart';

class AiChatScreen extends GetView<AiChatController> {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(backgroundColor: Colors.white, title: const Text("Shopping AI")),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) => ChatBubble(message: controller.messages[index]),
            )
            ),
          ),
          Obx(() => controller.searchResults.isNotEmpty 
              ? ProductCarousel() 
              : const SizedBox.shrink()),
              
          ChatInput(
            controller: textController,
            onSend: () {
              controller.sendMessage(textController.text);
              textController.clear();
            },
          ),
          
        ],
      ),
    );
  }
}