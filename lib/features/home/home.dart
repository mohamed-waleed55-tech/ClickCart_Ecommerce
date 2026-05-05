import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../authentication/presentation/view_models/auth_view_model.dart';

class Home extends GetWidget<AuthViewModel> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: TextButton(
            onPressed: () {
              controller.authRepo.signOut();
            },
            child: Text("Logout"),
          ),
        ),
      ),
    );
  }
}
