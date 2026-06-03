import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/database/database_helper.dart';
import 'package:ecommerce_app/core/networking/payment_api_service.dart';
import 'package:ecommerce_app/features/cart/data/cart_repository/cart_repository.dart';
import 'package:ecommerce_app/features/cart/data/cart_repository/cart_repository_imp.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/local_data_source/cart_local_data_source_imp.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/remote_data_source/cart_remote_data_source_imp.dart';
import 'package:ecommerce_app/features/cart/presentation/view_models/cart_view_model.dart';
import 'package:ecommerce_app/features/payment/data/payment_repository/payment_service_repo_imp.dart';
import 'package:ecommerce_app/features/payment/presentation/view_models/payment_view_model.dart';
import 'package:ecommerce_app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../features/cart/data/sync_manager/sync_manager.dart';
import '../features/authentication/data/auth_repository/auth_repositroy.dart';
import '../features/authentication/data/auth_repository/firebase_auth_repository.dart';
import '../features/authentication/data/user_repository/user_firestore_repository.dart';
import '../features/authentication/data/user_repository/user_repositroy.dart';
import '../features/authentication/presentation/view_models/auth_view_model.dart';
import '../features/cart/data/data_sources/local_data_source/cart_local_data_source.dart';
import '../features/checkout/data/data_source/order_remote_data_source_imp.dart';
import '../features/checkout/presentation/view_models/checkout_view_model.dart';
import '../features/home/data/category_repository/category_repository.dart';
import '../features/home/data/category_repository/category_repository_imp.dart';
import '../features/home/data/products_repository/products_repository.dart';
import '../features/home/data/products_repository/products_repository_imp.dart';
import '../features/home/data/products_repository/web_service/products_api.dart';
import '../features/home/presentation/view_models/category_products_view_model.dart';
import '../features/home/presentation/view_models/home_view_model.dart';
import '../features/main_layout/presentation/view_models/control_view_model.dart';
import '../features/payment/data/payment_repository/payment_service_repo.dart';
import '../features/profile/data/repo/Profile_repo_imp.dart';
import '../features/profile/data/repo/profile_repo.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    //  CORE DEPENDENCIES
    Get.lazyPut<Dio>(() => createAndSetupDio());
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper.instance);
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance);

    //  DATA SOURCES
    Get.lazyPut<CartRemoteDataSource>(
      () => CartRemoteDataSourceImp(),
      fenix: true,
    );
    Get.lazyPut<CartLocalDataSource>(
      () => CartLocalDataSourceImp(Get.find<DatabaseHelper>()),
      fenix: true,
    );
    Get.lazyPut<OrdersRemoteDataSourceImp>(() => OrdersRemoteDataSourceImp());
    Get.lazyPut<ProductsApi>(() => ProductsApi(Get.find<Dio>()));

    //  REPOSITORIES
    Get.lazyPut<UserRepository>(
      () => UserFirestoreRepository(Get.find<FirebaseFirestore>()),
      fenix: true,
    );
    Get.lazyPut<ProductsRepository>(
      () => ProductsRepositoryImp(Get.find<ProductsApi>()),
      fenix: true,
    );
    Get.lazyPut<PaymentServiceRepo>(
      () => PaymentServiceRepoImp
        (Get.find<PaymentApiService>()),
    );Get.lazyPut<PaymentServiceRepo>(
      () => PaymentServiceRepoImp(Get.find<PaymentApiService>()),
    );
    Get.lazyPut<PaymentApiService>(
      () => PaymentApiService(Get.find<Dio>()),
    );

    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImp());
    Get.lazyPut<UserRepository>(
      () => UserFirestoreRepository(Get.find<FirebaseFirestore>()),
    );
    Get.lazyPut<ProfileRepo>(
      () => ProfileRepoImp(
        Get.find<FirebaseFirestore>(),
        auth: FirebaseAuth.instance,
      ),
    );
    Get.lazyPut<CartRepository>(
      () => CartRepositoryImp(
        Get.find<CartLocalDataSource>(),
        Get.find<CartRemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => FirebaseAuthRepository(FirebaseAuth.instance, GoogleSignIn()),
      fenix: true,
    );
    Get.lazyPut<ProfileRepo>(
      () => ProfileRepoImp(
        Get.find<FirebaseFirestore>(),
        auth: FirebaseAuth.instance,
      ),
    );

    // BACKGROUND SERVICES
    Get.putAsync<CartSyncManager>(() async {
      return CartSyncManager(
        Get.find<DatabaseHelper>(),
        Get.find<FirebaseFirestore>(),
      );
    }, permanent: true);

    // VIEW MODELS
    Get.lazyPut<PaymentController>(
      () => PaymentController(
        Get.find<PaymentServiceRepo>(),
        Get.find<FirebaseFirestore>(),
      ),
      fenix: true,
    );
    Get.lazyPut<ControlViewModel>(() => ControlViewModel(), fenix: true);
    Get.lazyPut<AuthViewModel>(
      () =>
          AuthViewModel(Get.find<AuthRepository>(), Get.find<UserRepository>()),
      fenix: true,
    );
    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(Get.find<ProductsRepository>()),
      fenix: true,
    );
    Get.lazyPut<CategoryProductsViewModel>(
      () => CategoryProductsViewModel(Get.find<ProductsRepository>()),
      fenix: true,
    );
    Get.lazyPut<CartViewModel>(
      () => CartViewModel(Get.find<CartRepository>()),
      fenix: true,
    );
    Get.lazyPut<CheckoutViewModel>(
      () => CheckoutViewModel(
        Get.find<CartRepository>(),
        Get.find<OrdersRemoteDataSourceImp>(),
      ),
      fenix: true,
    );
    Get.lazyPut<ProfileViewModel>(
      () =>
          ProfileViewModel(Get.find<AuthRepository>(), Get.find<ProfileRepo>()),
      fenix: true,
    );
  }

  //  NETWORKING DIO SETUP
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
