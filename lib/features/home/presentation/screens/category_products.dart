import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../model/categorey/category_model.dart';
import '../view_models/category_products_view_model.dart';
import '../widgets/best_seller_item.dart';

class CategoryProductsView extends GetView<CategoryProductsViewModel> {
  const CategoryProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final category = Get.arguments as CategoryModel;

    return Scaffold(
      appBar: AppBar(title: Text(category.name ?? "Products")),
      body: Column(
        children: [
          Padding(
            padding: REdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    "${controller.products.length} Items found",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.products.isEmpty) {
              return _buildEmptyState();
            }

            return Expanded(
              child: GridView.builder(
                padding: REdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.72,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return BestSellerItem(item: controller.products[index]);
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80.sp, color: Colors.grey),
          SizedBox(height: 16.h),
          const Text("No products in this category yet."),
        ],
      ),
    );
  }
}
