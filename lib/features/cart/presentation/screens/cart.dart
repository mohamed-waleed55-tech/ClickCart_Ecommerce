import 'package:ecommerce_app/core/assets/svg_icons_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../view_models/cart_view_model.dart';
import '../widgets/cart_item.dart';

class Cart extends GetView<CartViewModel> {
  Cart({super.key});

  final RxBool isCheckoutVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
            "Cart",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.cartProducts.isEmpty) {
              return const Center(child: Text("Your cart is empty"));
            }
            return ListView.separated(
              padding: EdgeInsets.only(bottom: 160.h, left: 20.w, right: 20.w),
              itemCount: controller.cartProducts.length,
              itemBuilder: (context, index) {
                return CartItemWidget(product: controller.cartProducts[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16.h);
              },
            );
          }),

          Obx(() => AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            bottom: isCheckoutVisible.value ? 85.h : -130.h,
            left: 20.w,
            right: 20.w,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isCheckoutVisible.value ? 1.0 : 0.0,
              child: _buildCheckoutBottomBar(context),
            ),
          )),

          Obx(() => AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: isCheckoutVisible.value ? -70.h : 95.h,
            right: 20.w,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: isCheckoutVisible.value ? 0.0 : 1.0,
              child: FloatingActionButton(
                onPressed: () {
                  isCheckoutVisible.value = true;
                },
                backgroundColor: const Color(0xFF388E3C),
                elevation: 6,
                shape: const CircleBorder(),
                child: SvgPicture.asset(SvgIconsManager.cart, color: Colors.white, width: 24.w, height: 24.h)
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCheckoutBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TOTAL",
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp, letterSpacing: 1.2),
                ),
                SizedBox(height: 4.h),
                Obx(() => Text(
                  "\$${controller.totalPrice.value.toStringAsFixed(3)}",
                  style: const TextStyle(
                    color: Color(0xFF388E3C),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ),

          Expanded(
            flex: 4,
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  // Checkout Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF388E3C),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "CHECKOUT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          GestureDetector(
            onTap: () {
              isCheckoutVisible.value = false;
            },
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: const BoxDecoration(
                color: Color(0xFF388E3C),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}