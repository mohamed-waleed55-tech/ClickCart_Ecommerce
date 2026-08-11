// lib/widgetbook/login_usecase.dart

import 'package:ecommerce_app/features/authentication/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart'
    as widgetbook;


@widgetbook.UseCase(
  name: 'Default',
  type: SignUp,
)
Widget loginScreenUseCase(BuildContext context) {
  return const SignUp();
}