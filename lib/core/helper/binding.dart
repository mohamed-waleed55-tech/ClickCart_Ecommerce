import 'package:ecommerce_app/features/home/data/category_repository/category_repository.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/authentication/presentation/view_models/auth_view_model.dart';
import '../features/authentication/data/auth_repository/auth_repositroy.dart';
import '../features/authentication/data/auth_repository/firebase_auth_repository.dart';
import '../features/authentication/data/user_repository/user_firestore_repository.dart';
import '../features/authentication/data/user_repository/user_repositroy.dart';
import '../features/home/data/category_repository/category_repository_imp.dart';
import '../features/home/data/products_repository/products_repository.dart';
import '../features/home/data/products_repository/products_repository_imp.dart';
import '../features/home/presentation/view_models/home_view_model.dart';
import '../features/main_layout/presentation/view_models/control_view_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => FirebaseAuthRepository(FirebaseAuth.instance, GoogleSignIn()),
    );

    Get.lazyPut<UserRepository>(
      () => UserFirestoreRepository(FirebaseFirestore.instance),
    );

    Get.lazyPut<ProductsRepository>(() => ProductsRepositoryImp());

    Get.lazyPut<AuthViewModel>(() => AuthViewModel(Get.find(), Get.find()));
    Get.lazyPut<ControlViewModel>(() => ControlViewModel());
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImp());

    Get.lazyPut<HomeViewModel>(() => HomeViewModel(Get.find(), Get.find()));
  }
}
