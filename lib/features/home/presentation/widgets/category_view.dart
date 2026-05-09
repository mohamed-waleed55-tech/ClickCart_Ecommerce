import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../core/navigation/app_routes.dart';
import '../view_models/home_view_model.dart';
class CategoryView extends GetView<HomeViewModel> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
          () => SizedBox(
        height: 110.h,
        child: controller.categories.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
          padding: REdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 20.w),
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            return GestureDetector(
              onTap: () {

                Get.toNamed(
                  AppRoutes.categoryProducts,
                  arguments: category,
                );
              },
              child: SizedBox(
                width: 75.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 68.r,
                      height: 68.r,
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                      child: Center(
                        child: Icon(
                          _getCategoryIcon(category.slug),
                          color: theme.primaryColor,
                          size: 28.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      category.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  IconData _getCategoryIcon(String? slug) {
    switch (slug) {
      case 'beauty': return Ionicons.sparkles_outline;
      case 'fragrances': return Ionicons.flask_outline;
      case 'skin-care': return Ionicons.water_outline;

      case 'furniture': return Ionicons.bed_outline;
      case 'groceries': return Ionicons.basket_outline;
      case 'home-decoration': return Ionicons.home_outline;
      case 'kitchen-accessories': return Ionicons.restaurant_outline;

      case 'laptops': return Ionicons.laptop_outline;
      case 'tablets': return Ionicons.tablet_landscape_outline;
      case 'smartphones': return Ionicons.phone_portrait_outline;
      case 'mobile-accessories': return Ionicons.bluetooth_outline;

      case 'mens-shirts': return Ionicons.shirt_outline;
      case 'mens-shoes': return Ionicons.walk_outline;
      case 'mens-watches': return Ionicons.watch_outline;

      case 'womens-bags': return Ionicons.bag_handle_outline;
      case 'womens-dresses': return Ionicons.woman_outline;
      case 'womens-jewellery': return Ionicons.diamond_outline;
      case 'womens-shoes': return Ionicons.footsteps_outline;
      case 'womens-watches': return Ionicons.time_outline;

      case 'tops': return Ionicons.body_outline;
      case 'sunglasses': return Ionicons.glasses_outline;
      case 'sports-accessories': return Ionicons.football_outline;

      case 'motorcycle': return Ionicons.bicycle_outline;
      case 'vehicle': return Ionicons.car_sport_outline;

      default: return Ionicons.apps_outline;
    }
  }}