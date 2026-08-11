import 'package:ecommerce_app/core/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../view_models/home_view_model.dart';
import '../widgets/ai_shopping_card.dart';
import '../widgets/best_seller_view.dart';
import '../widgets/category_view.dart';
import '../widgets/home_header.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/section_title.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final bool searching = controller.isSearching.value;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ─────────────────────────────────────────────
              // Header
              // ─────────────────────────────────────────────
              SliverPadding(
                padding: REdgeInsets.only(top: 20, left: 16, right: 16),
                sliver: const SliverToBoxAdapter(child: HomeHeader()),
              ),

              // ─────────────────────────────────────────────
              // Search Bar
              // ─────────────────────────────────────────────
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
                sliver: const SliverToBoxAdapter(child: HomeSearchBar()),
              ),

              // ─────────────────────────────────────────────
              // SEARCH MODE
              // ─────────────────────────────────────────────
              if (searching) ...[
                SliverPadding(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  sliver: SliverToBoxAdapter(
                    child: SectionTitle(
                      title:
                          "Search Results for '${controller.currentSearchQuery.value}'",
                    ),
                  ),
                ),

                SliverPadding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  sliver: const BestSellerView(),
                ),
              ]
           
              else ...[
                SliverPadding(
                  padding: REdgeInsets.only(left: 16, right: 16, bottom: 28),
                  sliver: SliverToBoxAdapter(
                    child: AiShoppingCard(
                      onTap: () {
                        Get.toNamed(AppRoutes.aiChat);
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: const SectionTitle(title: "Categories"),
                      ),

                      SizedBox(height: 14.h),

                      const CategoryView(),
                    ],
                  ),
                ),

                SliverPadding(
                  padding: REdgeInsets.only(
                    top: 24,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: SectionTitle(
                      title: "Best Sellers",
                      onTapSeeAll: () {},
                    ),
                  ),
                ),

            
                SliverPadding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  sliver: const BestSellerView(),
                ),
              ],

              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            ],
          );
        }),
      ),
    );
  }
}
