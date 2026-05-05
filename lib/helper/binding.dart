import 'package:ecommerce_app/features/home/presentation/view_models/home_view_model.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/authentication/presentation/view_models/auth_view_model.dart';
import '../features/authentication/data/auth_repository/auth_repositroy.dart';
import '../features/authentication/data/auth_repository/firebase_auth_repository.dart';
import '../features/authentication/data/user_repository/user_firestore_repository.dart';
import '../features/authentication/data/user_repository/user_repositroy.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => FirebaseAuthRepository(FirebaseAuth.instance, GoogleSignIn()),
    );

    Get.lazyPut<UserRepository>(
      () => UserFirestoreRepository(FirebaseFirestore.instance),
    );

    Get.lazyPut<AuthViewModel>(() => AuthViewModel(Get.find(), Get.find()));
    Get.lazyPut<HomeViewModel>(()=>HomeViewModel());
  }
}
