import 'package:ecommerce_app/core/assets/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../checkout/model/order.dart';
import '../view_model/profile_view_model.dart';

class OrdersHistory extends GetView<ProfileViewModel> {
  const OrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.orders.isEmpty) {
            return Center(
              child: SizedBox(
                height: 200.h,
                width: 200.w,
                child: ClipRRect(borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(ImagesManager.emptyOrders)),
              ),
            );
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: const Color(0xFFFAFAFA),
                elevation: 0,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
                centerTitle: true,
                title: Text(
                  "Track Order",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final order = controller.orders[index];

                    return OrderItemCard(order: order);
                  }, childCount: controller.orders.length),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final OrderModel order;

  const OrderItemCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    bool isDelivered = order.status.toLowerCase() == 'delivered';


    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              spreadRadius: 1,
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.id,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isDelivered
                        ? const Color(0xFF10B981).withOpacity(0.1)
                        : const Color(0xFFFBBF24).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      color: isDelivered ? const Color(0xFF10B981) : const Color(0xFFD97706),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Divider(height: 20.h, color: Colors.grey.shade100),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 14.sp, color: Colors.grey),
                          SizedBox(width: 6.w),
                          Text(
                            "Placed on: ${order.orderDate}",
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),

                      Row(
                        children: [
                          Icon(Icons.local_shipping_outlined, size: 14.sp, color: Colors.grey),
                          SizedBox(width: 6.w),
                          Text(
                            "Delivery: ${switch (order.deliveryOption) {
                              0 => "Standard Delivery",
                              1 => "Next Day Delivery",
                              2 => "Nominated Delivery",
                              _ => "Unknown"
                            }}",
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              "Ship to: ${order.shippingAddress['street1'] ?? ''}, ${order.shippingAddress['city'] ?? ''}",
                              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),

                      Text(
                        "\$${order.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 90.h,
                    padding: EdgeInsets.only(left: 10.w),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}