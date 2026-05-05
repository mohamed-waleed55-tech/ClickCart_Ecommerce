import 'package:ecommerce_app/features/home/presentation/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../core/assets/svg_icons_manager.dart';
import '../../../cart/presentation/screens/cart.dart';
import '../../../profile/presentation/profile.dart';
import 'home.dart';

class MainLayout extends GetWidget<HomeViewModel> {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [Home(), Cart(), Profile()];
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: GetBuilder<HomeViewModel>(
        builder: (controller) => screens[controller.navigateIndex],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<HomeViewModel>(
      builder: (controller) => BottomNavigationBar(
        currentIndex: controller.navigateIndex,
        onTap: controller.changeNavigateIndex,
        elevation: 0,

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              SvgIconsManager.explore,
              width: 24.w,
              height: 24.h,
            ),
            label: "",
            activeIcon: Text("Explore", style: theme.textTheme.titleSmall),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              SvgIconsManager.cart,
              width: 24.sp,
              height: 24.sp,
            ),
            label: "",
            activeIcon: Text("Cart", style: theme.textTheme.titleSmall),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              SvgIconsManager.user,
              width: 24.sp,
              height: 24.sp,
            ),
            label: "",
            activeIcon: Text("Profile", style: theme.textTheme.titleSmall),
          ),
        ],
      ),
    );
  }
}
