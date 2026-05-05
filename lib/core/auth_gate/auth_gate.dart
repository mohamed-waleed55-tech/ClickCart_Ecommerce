import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/view_models/auth_view_model.dart';
import '../../features/home/home.dart';

class AuthGate extends GetWidget<AuthViewModel> {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoggedIn == false) {
        return LoginScreen();
      } else {
        return Home();
      }
    });
  }

}
