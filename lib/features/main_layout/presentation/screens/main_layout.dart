import 'package:ecommerce_app/features/ai_shopping/presentation/screen/ai_chat_screen.dart';
import 'package:ecommerce_app/features/main_layout/presentation/screens/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/assets/svg_icons_manager.dart';
import '../../../cart/presentation/screens/cart.dart';
import '../../../home/presentation/screens/home.dart';
import '../../../profile/presentation/screens/profile.dart';
import '../view_models/control_view_model.dart';

class MainLayout extends GetWidget<ControlViewModel> {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<NavItem> navItems = [
      NavItem(
        screen: HomeView(),
        iconPath: SvgIconsManager.explore,
        label: "Explore",
      ),
      NavItem(screen: Cart(), iconPath: SvgIconsManager.cart, label: "Cart"),
      NavItem(
        screen: Profile(),
        iconPath: SvgIconsManager.user,
        label: "Profile",
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: GetBuilder<ControlViewModel>(
        builder: (controller) => navItems[controller.navigateIndex].screen,
      ),

    

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r), 
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withValues(
                alpha: .1,
              ), 
              offset: const Offset(0, 10),
            ),
          ],
        ),
        margin: REdgeInsets.only(
          left: 15.w,
          right: 15.w,
          bottom: 20.h,
        ), 
        padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: GetBuilder<ControlViewModel>(
          builder: (controller) => GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            haptic: true,
            gap: 8.w,
            tabBorderRadius: 20,
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 500),
            color: Colors.grey[600],
            activeColor: theme.colorScheme.primary,
            iconSize: 24.sp,
            tabBackgroundColor: theme.colorScheme.primary.withValues(
              alpha: 0.1,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            selectedIndex: controller.navigateIndex,
            onTabChange: controller.changeNavigateIndex,
            tabs: navItems
                .map(
                  (item) => GButton(
                    icon: Icons.circle, 
                    leading: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: SvgPicture.asset(
                        item.iconPath,
                        key: ValueKey(controller.navigateIndex),
                        width: 24.w,
                        colorFilter: ColorFilter.mode(
                          controller.navigateIndex == navItems.indexOf(item)
                              ? theme.colorScheme.primary
                              : Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    text: item.label,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
