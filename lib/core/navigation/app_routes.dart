import 'package:ecommerce_app/features/profile/presentation/screens/profile.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/checkout/presentation/screens/checkout.dart';
import '../../features/home/presentation/screens/category_products.dart';
import '../../features/home/presentation/screens/details.dart';
import '../../features/main_layout/presentation/screens/main_layout.dart';
import '../../features/onboarding/presentation/screens/onboaeding_view.dart';
import '../../features/profile/presentation/screens/orders_history.dart';
import '../auth_gate/auth_gate.dart';

abstract final class AppRoutes {
  static const authGate = "/";
  static const login = "/login";
  static const productDetails = "/product-details";
  static const mainLayout = "/main-layout";
  static const signUp = "/sign-up";
  static const categoryProducts = "/category-products";
  static const checkout = "/checkout";
  static const profile = "/profile";
  static const ordersHistory = "/orders-history";
  static const onboarding = "/onboarding";

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
    GetPage(
      name: AppRoutes.checkout,
      page: () => Checkout(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => Profile(),
    ),
    GetPage(
      name: AppRoutes.ordersHistory,
      page: () => OrdersHistory(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const Onboarding(),
    ),
  ];
}


