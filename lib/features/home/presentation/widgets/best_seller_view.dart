import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../view_models/home_view_model.dart';
import 'best_seller_item.dart';

class BestSellerView extends GetView<HomeViewModel> {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final displayList = controller.isSearching.value
          ? controller.filteredProducts
          : controller.products;

      if (controller.isLoading.value && displayList.isEmpty) {
        return const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (displayList.isEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: Text(
              controller.isSearching.value
                  ? "No results found for your search"
                  : "No products available",
            ),
          ),
        );
      }

      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return BestSellerItem(item: displayList[index]);
          },
          childCount: displayList.length,
        ),
      );
    });
  }
}