import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/view_models/auth_view_model.dart';
import '../../features/main_layout/presentation/screens/main_layout.dart';
class AuthGate extends GetWidget<AuthViewModel> {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => controller.isLoggedIn
          ? const MainLayout()
          : const LoginScreen(),
    );
  }
}