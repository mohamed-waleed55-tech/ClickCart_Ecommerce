import 'package:ecommerce_app/core/assets/images_manager.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../core/navigation/app_routes.dart';
import '../view_models/home_view_model.dart';

class CategoryView extends GetView<HomeViewModel> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return SizedBox(
          height: 132.h,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return SizedBox(
        height: 132.h,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 14.w),
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            final style = _getCategoryStyle(category.slug);

            return CategoryItem(
              name: category.name ?? 'Category',
              image: style.image,
              color: style.color,
              onTap: () {
                Get.toNamed(
                  AppRoutes.categoryProducts,
                  arguments: category,
                );
              },
            );
          },
        ),
      );
    });
  }

  CategoryStyle _getCategoryStyle(String? slug) {
    switch (slug) {
      // ─────────────────────────────
      // Beauty
      // ─────────────────────────────

      case 'beauty':
        return CategoryStyle(
          image: ImagesManager.beauty,
          color: const Color(0xFFE83E8C),
        );

      case 'fragrances':
        return CategoryStyle(
          image: ImagesManager.fragrances,
          color: const Color(0xFF9C5CC4),
        );

      case 'skin-care':
        return CategoryStyle(
          image: ImagesManager.skinCare,
          color: const Color(0xFF42A5F5),
        );

      // ─────────────────────────────
      // Home
      // ─────────────────────────────

      case 'furniture':
        return CategoryStyle(
          image: ImagesManager.furniture,
          color: const Color(0xFF8D6E63),
        );

      case 'groceries':
        return CategoryStyle(
          image: ImagesManager.groceries,
          color: const Color(0xFF43A047),
        );

      case 'home-decoration':
        return CategoryStyle(
          image: ImagesManager.homeDecoration,
          color: const Color(0xFFFF9800),
        );

      case 'kitchen-accessories':
        return CategoryStyle(
          image: ImagesManager.kitchenAccessories,
          color: const Color(0xFFEF5350),
        );

      // ─────────────────────────────
      // Electronics
      // ─────────────────────────────

      case 'laptops':
        return CategoryStyle(
          image: ImagesManager.laptops,
          color: const Color(0xFF536DFE),
        );

      case 'tablets':
        return CategoryStyle(
          image: ImagesManager.tablets,
          color: const Color(0xFF7E57C2),
        );

      case 'smartphones':
        return CategoryStyle(
          image: ImagesManager.smartphones,
          color: const Color(0xFF2196F3),
        );

      case 'mobile-accessories':
        return CategoryStyle(
          image: ImagesManager.mobileAccessories,
          color: const Color(0xFF00ACC1),
        );

      // ─────────────────────────────
      // Men's Fashion
      // ─────────────────────────────

      case 'mens-shirts':
        return CategoryStyle(
          image: ImagesManager.mensShirts,
          color: const Color(0xFF1976D2),
        );

      case 'mens-shoes':
        return CategoryStyle(
          image: ImagesManager.mensShoes,
          color: const Color(0xFF455A64),
        );

      case 'mens-watches':
        return CategoryStyle(
          image: ImagesManager.mensWatches,
          color: const Color(0xFF607D8B),
        );

      // ─────────────────────────────
      // Women's Fashion
      // ─────────────────────────────

      case 'womens-bags':
        return CategoryStyle(
          image: ImagesManager.womensBags,
          color: const Color(0xFFD81B60),
        );

      case 'womens-dresses':
        return CategoryStyle(
          image: ImagesManager.womensDresses,
          color: const Color(0xFFAB47BC),
        );

      case 'womens-jewellery':
        return CategoryStyle(
          image: ImagesManager.womensJewellery,
          color: const Color(0xFFFFB300),
        );

      case 'womens-shoes':
        return CategoryStyle(
          image: ImagesManager.womensShoes,
          color: const Color(0xFFFF7043),
        );

      case 'womens-watches':
        return CategoryStyle(
          image: ImagesManager.womensWatches,
          color: const Color(0xFF8E24AA),
        );

      // ─────────────────────────────
      // Accessories
      // ─────────────────────────────

      case 'tops':
        return CategoryStyle(
          image: ImagesManager.tops,
          color: const Color(0xFF00897B),
        );

      case 'sunglasses':
        return CategoryStyle(
          image: ImagesManager.sunglasses,
          color: const Color(0xFFFFB300),
        );

      case 'sports-accessories':
        return CategoryStyle(
          image: ImagesManager.sportsAccessories,
          color: const Color(0xFF2E7D32),
        );

      // ─────────────────────────────
      // Vehicles
      // ─────────────────────────────

      case 'motorcycle':
        return CategoryStyle(
          image: ImagesManager.motorcycle,
          color: const Color(0xFF424242),
        );

      case 'vehicle':
        return CategoryStyle(
          image: ImagesManager.vehicle,
          color: const Color(0xFF546E7A),
        );

      default:
        return CategoryStyle(
          image: ImagesManager.img,
          color: const Color(0xFF78909C),
        );
    }
  }
}

class CategoryStyle {
  final String image;
  final Color color;

  const CategoryStyle({
    required this.image,
    required this.color,
  });
}