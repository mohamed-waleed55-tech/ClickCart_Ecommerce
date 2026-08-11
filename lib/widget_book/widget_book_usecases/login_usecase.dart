// lib/widgetbook/login_usecase.dart

import 'package:ecommerce_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart'
    as widgetbook;


@widgetbook.UseCase(
  name: 'Default',
  type: LoginScreen,
)
Widget loginScreenUseCase(BuildContext context) {
  return const LoginScreen();
}