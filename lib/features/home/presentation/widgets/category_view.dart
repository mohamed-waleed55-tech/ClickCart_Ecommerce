import 'package:flutter/cupertino.dart';
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
      case 'beauty':
        return Icons.auto_awesome_outlined;
      case 'fragrances':
        return Icons.science_outlined;
      case 'skin-care':
        return Icons.water_drop_outlined;

      case 'furniture':
        return Icons.bed_outlined;
      case 'groceries':
        return Icons.shopping_basket_outlined;
      case 'home-decoration':
        return Icons.home_outlined;
      case 'kitchen-accessories':
        return Icons.restaurant_outlined;

      case 'laptops':
        return Icons.laptop_outlined;
      case 'tablets':
        return Icons.tablet_android_outlined;
      case 'smartphones':
        return Icons.smartphone_outlined;
      case 'mobile-accessories':
        return Icons.bluetooth_outlined;

      case 'mens-shirts':
        return Icons.checkroom_outlined;
      case 'mens-shoes':
        return Icons.directions_walk_outlined;
      case 'mens-watches':
        return Icons.watch_outlined;

      case 'womens-bags':
        return Icons.local_mall_outlined;
      case 'womens-dresses':
        return Icons.woman_outlined;
      case 'womens-jewellery':
        return Icons.diamond_outlined;
      case 'womens-shoes':
        return Icons.shopping_bag_outlined;
      case 'womens-watches':
        return Icons.access_time_outlined;

      case 'tops':
        return Icons.accessibility_new_outlined;
      case 'sunglasses':
        return Icons.wb_sunny_outlined;
      case 'sports-accessories':
        return Icons.sports_soccer_outlined;

      case 'motorcycle':
        return Icons.motorcycle_outlined;
      case 'vehicle':
        return Icons.directions_car_outlined;

      default:
        return Icons.apps_outlined;
    }
  }
}
