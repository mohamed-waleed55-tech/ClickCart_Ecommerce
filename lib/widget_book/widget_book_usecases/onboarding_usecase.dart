// lib/widgetbook/login_usecase.dart

import 'package:ecommerce_app/features/onboarding/presentation/screens/onboaeding_view.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart'
    as widgetbook;


@widgetbook.UseCase(
  name: 'Default',
  type: Onboarding,
)
Widget loginScreenUseCase(BuildContext context) {
  return const Onboarding();
}
