import 'package:ecommerce_app/core/helper/binding.dart';
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../core/config/theme_manager.dart';
import '../core/navigation/app_routes.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key, required this.showOnboarding});
  final bool showOnboarding;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      fontSizeResolver: (fontSize, screenUtil) {
        if (kIsWeb) {
          return fontSize.toDouble();
        }
        return FontSizeResolvers.width(fontSize, screenUtil);
      },
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBinding(),
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce App',
          theme: ThemeManager.light,
          darkTheme: ThemeManager.dark,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler:
                    TextScaler.noScaling, 
              ),
              child: child!,
            );
          },
          themeMode: ThemeMode.system,
          getPages: AppPages.pages,
          initialRoute: showOnboarding
              ? AppRoutes.onboarding
              : AppRoutes.authGate,
        );
      },
    );
  }
}
