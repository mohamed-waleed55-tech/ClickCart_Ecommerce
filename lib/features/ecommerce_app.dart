import 'package:ecommerce_app/helper/binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../core/auth_gate/auth_gate.dart';
import '../core/config/theme_manager.dart';
import '../core/navigation/app_routes.dart';
import 'authentication/presentation/screens/login_screen.dart';
import 'onboarding/presentation/screens/onboaeding_view.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key, required this.showOnboarding});
  final bool showOnboarding;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBinding(),
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce App',
          theme: ThemeManager.light,
          darkTheme: ThemeManager.dark,
          themeMode: ThemeMode.system,
          getPages: AppPages.pages,
          initialRoute: showOnboarding ? AppRoutes.onboarding : AppRoutes.authGate,        );
      },
    );
  }
}
