import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/category_products.dart';
import '../../features/home/presentation/screens/details.dart';
import '../../features/main_layout/presentation/screens/main_layout.dart';
import '../auth_gate/auth_gate.dart';

abstract final class AppRoutes {
  static const authGate = "/";
  static const login = "/login";
  static const productDetails = "/product-details";
  static const mainLayout = "/main-layout";
  static const signUp = "/sign-up";
  static const categoryProducts = "/category-products";

}
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.productDetails,
      page: () => const ProductDetails(),
    ),
    GetPage(
      name: AppRoutes.authGate,
      page: () => const AuthGate(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.mainLayout,
      page: () => MainLayout(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.categoryProducts,
      page: () => const CategoryProductsView(),
    ),
  ];
}


