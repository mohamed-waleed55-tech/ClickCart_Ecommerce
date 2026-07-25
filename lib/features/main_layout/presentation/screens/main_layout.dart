import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// 1. Import the library

import '../../../../core/assets/svg_icons_manager.dart';
import '../../../cart/presentation/screens/cart.dart';
import '../../../profile/presentation/screens/profile.dart';
import '../../../home/presentation/screens/home.dart';
import '../view_models/control_view_model.dart';

class MainLayout extends GetWidget<ControlViewModel> {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [HomeView(), Cart(), Profile()];
    final theme = Theme.of(context);

    final Color primaryColor = theme.colorScheme.primary;

    final Color activeIconColor = theme.colorScheme.onPrimary;

    return Scaffold(
      extendBody: true,
      body: GetBuilder<ControlViewModel>(
        builder: (controller) => screens[controller.navigateIndex],
      ),
      bottomNavigationBar: GetBuilder<ControlViewModel>(
        builder: (controller) =>
            CurvedNavigationBar(
              index: controller.navigateIndex,
              height: 60.h,
              backgroundColor: Colors.transparent,
              color: primaryColor,
              buttonBackgroundColor: primaryColor,
              animationDuration: const Duration(milliseconds: 750),
              animationCurve: Curves.easeInOutCubic,
              onTap: controller.changeNavigateIndex,

              items: <Widget>[
                _buildNavItem(
                  iconPath: SvgIconsManager.explore,
                  label: "Explore",
                  isSelected: controller.navigateIndex == 0,
                  activeIconColor: activeIconColor,
                  primaryColor: primaryColor,
                  textTheme: theme.textTheme,
                ),
                _buildNavItem(
                  iconPath: SvgIconsManager.cart,
                  label: "Cart",
                  isSelected: controller.navigateIndex == 1,
                  activeIconColor: activeIconColor,
                  primaryColor: primaryColor,
                  textTheme: theme.textTheme,
                ),
                _buildNavItem(
                  iconPath: SvgIconsManager.user,
                  label: "Profile",
                  isSelected: controller.navigateIndex == 2,
                  activeIconColor: activeIconColor,
                  primaryColor: primaryColor,
                  textTheme: theme.textTheme,
                ),
              ],
            ),
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required String label,
    required bool isSelected,
    required Color activeIconColor,
    required Color primaryColor,
    required TextTheme textTheme,
  }) {
    final Color iconColor = isSelected ? activeIconColor : Colors.white;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w ),
      alignment: Alignment.center,
      child: Column(

        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isSelected) ...[ SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          ],

          if (isSelected) ...[
            SizedBox(height: 4.h),
            Padding(
              padding:  REdgeInsets.all(8.0),
              child: Text(
                label,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: activeIconColor,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}