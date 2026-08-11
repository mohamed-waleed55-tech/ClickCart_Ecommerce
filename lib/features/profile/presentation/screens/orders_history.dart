import 'package:ecommerce_app/core/assets/images_manager.dart';
import 'package:ecommerce_app/features/profile/presentation/widgets/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../view_model/profile_view_model.dart';

class OrdersHistory extends GetView<ProfileViewModel> {
  const OrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Obx(
          () {
            // ============================================================
            // INITIAL ORDERS LOADING
            // ============================================================
            //
            // Only show the full-screen loader when:
            // 1. Orders are loading
            // 2. There are currently no orders
            //
            // This is important because cancelling an order must NOT
            // replace the whole screen with CircularProgressIndicator.
            //
            if (controller.orderIsLoading.value &&
                controller.orders.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // ============================================================
            // EMPTY ORDERS
            // ============================================================

            if (controller.orders.isEmpty) {
              return _buildEmptyOrders();
            }

            // ============================================================
            // ORDERS LIST
            // ============================================================

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ========================================================
                // APP BAR
                // ========================================================

                SliverAppBar(
                  backgroundColor: const Color(0xFFFAFAFA),
                  elevation: 0,
                  pinned: true,

                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),

                  centerTitle: true,

                  title: Text(
                    'Track Order',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // ========================================================
                // ORDER LIST
                // ========================================================

                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final order = controller.orders[index];

                        // Is THIS specific order being cancelled?
                        final bool isCancelling =
                            controller.isCancelling(order.id);

                        return OrderItemCard(
                          order: order,

                          // ==================================================
                          // CANCEL BUTTON
                          // ==================================================

                          onCancel:
                              controller.canCancelOrder(order.status) &&
                                      !isCancelling
                                  ? () {
                                      controller.cancelOrder(order);
                                    }
                                  : null,

                          // If your OrderItemCard has an isLoading property,
                          // uncomment this:
                          //
                          // isLoading: isCancelling,
                        );
                      },
                      childCount: controller.orders.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY ORDERS
  // ============================================================

  Widget _buildEmptyOrders() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ==========================================================
          // IMAGE
          // ==========================================================

          SizedBox(
            height: 180.h,
            width: 180.w,
            child: Image.asset(
              ImagesManager.emptyOrders,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: 20.h),

          // ==========================================================
          // TITLE
          // ==========================================================

          Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 8.h),

          // ==========================================================
          // DESCRIPTION
          // ==========================================================

          Text(
            'Your order history will appear here.',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}