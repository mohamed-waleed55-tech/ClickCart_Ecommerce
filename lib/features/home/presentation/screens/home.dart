import 'package:ecommerce_app/features/home/model/category_model.dart';
import 'package:ecommerce_app/features/home/presentation/view_models/home_view_model.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/best_seller_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class Home extends GetWidget<HomeViewModel> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildHeader(context),
              SizedBox(height: 24.h),
              _buildSearchField(context),
              SizedBox(height: 24.h),
              _buildSectionTitle(context, "Categories"),
              SizedBox(height: 14.h),
              _buildCategories(context),
              SizedBox(height: 20.h),
              _buildBestSellerHeader(context),
              SizedBox(height: 16.h),
              _buildBestSellerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Find your favorite products",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 44.r,
          height: 44.r,
          decoration: BoxDecoration(
            color: colorScheme.secondary.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.notifications_none_rounded, size: 24.sp),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 54.h,
      alignment: Alignment.center,
      padding: REdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: colorScheme.secondary.withAlpha(28),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search products",
          prefixIcon: Icon(Icons.search_rounded, size: 24.sp),
          suffixIcon: Icon(Icons.tune_rounded, size: 22.sp),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return GetBuilder(
      init: HomeViewModel(Get.find(), Get.find()),
      builder: (controller) => SizedBox(
        height: 96.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 14.w),
          itemBuilder: (context, index) {
            final item = controller.categories[index];
            return _buildCategoryItem(context, index, item);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    int index,
    CategoryModel item,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 76.w,
      child: Column(
        children: [
          Container(
            width: 62.r,
            height: 62.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: colorScheme.primary.withAlpha(index == 0 ? 35 : 18),
            ),
            child: Padding(
              padding: REdgeInsets.all(12),
              child: Image.asset(item.image),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            item.categoryName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellerHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          "Best Sellers",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        Text(
          "See All",
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildBestSellerList() {
    return GetX<HomeViewModel>(
      init: HomeViewModel(Get.find(), Get.find()),
      builder: (controller) => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemSpacing = 8.w;
                  final itemWidth = (constraints.maxWidth - itemSpacing) / 2;

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.products.length,
                    separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
                    itemBuilder: (context, index) {
                      final item = controller.products[index];
                      return BestSellerItem(width: itemWidth, item: item);
                    },
                  );
                },
              ),
            ),
    );
  }
}
