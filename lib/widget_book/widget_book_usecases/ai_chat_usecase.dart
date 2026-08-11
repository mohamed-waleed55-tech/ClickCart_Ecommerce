
import 'package:ecommerce_app/features/ai_shopping/presentation/screen/ai_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart'
    as widgetbook;


@widgetbook.UseCase(
  name: 'Default',
  type: AiChatScreen,
)
Widget loginScreenUseCase(BuildContext context) {
  return const AiChatScreen();
}