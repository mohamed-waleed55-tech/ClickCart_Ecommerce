import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/database/database_helper.dart';
import 'package:ecommerce_app/features/cart/data/cart_repository/cart_repository.dart';
import 'package:ecommerce_app/features/cart/data/cart_repository/cart_repository_imp.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/local_data_source/cart_local_data_source_imp.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/remote_data_source/cart_remote_data_source_imp.dart';
import 'package:ecommerce_app/features/cart/presentation/view_models/cart_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../features/authentication/data/auth_repository/auth_repositroy.dart';
import '../features/authentication/data/auth_repository/firebase_auth_repository.dart';
import '../features/authentication/data/user_repository/user_firestore_repository.dart';
import '../features/authentication/data/user_repository/user_repositroy.dart';
import '../features/authentication/presentation/view_models/auth_view_model.dart';
import '../features/cart/data/data_sources/local_data_source/cart_local_data_source.dart';
import '../features/home/data/category_repository/category_repository.dart';
import '../features/home/data/category_repository/category_repository_imp.dart';
import '../features/home/data/products_repository/products_repository.dart';
import '../features/home/data/products_repository/products_repository_imp.dart';
import '../features/home/data/products_repository/web_service/products_api.dart';
import '../features/home/presentation/view_models/category_products_view_model.dart';
import '../features/home/presentation/view_models/home_view_model.dart';
import '../features/main_layout/presentation/view_models/control_view_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => createAndSetupDio());

    Get.lazyPut<ProductsApi>(() => ProductsApi(Get.find<Dio>()));

    Get.lazyPut<ProductsRepository>(
      () => ProductsRepositoryImp(Get.find<ProductsApi>()),
    );
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImp());

    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImp());
    Get.lazyPut<CartRepositoryImp>(
      () => CartRepositoryImp(Get.find(), Get.find()),
    );
    Get.lazyPut<CartRepository>(
      () => CartRepositoryImp(Get.find(), Get.find()),
    );

    Get.lazyPut<AuthRepository>(
      () => FirebaseAuthRepository(FirebaseAuth.instance, GoogleSignIn()),
    );
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper.instance);
    Get.lazyPut<CartRemoteDataSource>(() => CartRemoteDataSourceImp());

    Get.lazyPut<CartLocalDataSource>(() => CartLocalDataSourceImp(Get.find()));

    Get.lazyPut<UserRepository>(
      () => UserFirestoreRepository(FirebaseFirestore.instance),
    );
    Get.lazyPut<CartRepository>(
      () => CartRepositoryImp(Get.find(), Get.find()),
      fenix: true,
    );

    Get.lazyPut<AuthViewModel>(() => AuthViewModel(Get.find(), Get.find()));
    Get.lazyPut<ControlViewModel>(() => ControlViewModel());
    Get.lazyPut<HomeViewModel>(() => HomeViewModel(Get.find()));
    Get.lazyPut<CategoryProductsViewModel>(
      () => CategoryProductsViewModel(Get.find()),
      fenix: true,
    );
    Get.lazyPut<CartViewModel>(() => CartViewModel(Get.find()), fenix: true);
  }

  Dio createAndSetupDio() {
    Dio dio = Dio();

    dio.options
      ..connectTimeout = const Duration(seconds: 20)
      ..receiveTimeout = const Duration(seconds: 20);

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: true,
        requestBody: true,
      ),
    );

    return dio;
  }
}
