import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../view_models/cart_view_model.dart';
import '../widgets/cart_item.dart';
class Cart extends GetView<CartViewModel> {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cart", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.cartProducts.isEmpty) {
          return const Center(child: Text("Your cart is empty"));
        }
        return ListView.builder( // استخدام ListView أبسط وأضمن في القيود من CustomScrollView هنا
          padding: EdgeInsets.only(bottom: 120.h, left: 20.w, right: 20.w),
          itemCount: controller.cartProducts.length,
          itemBuilder: (context, index) {
            return CartItemWidget(product: controller.cartProducts[index]);
          },
        );
      }),
      bottomNavigationBar: _buildCheckoutBottomBar(),
    );
  }

  Widget _buildCheckoutBottomBar() {
    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TOTAL",
                style: TextStyle(color: Colors.grey, fontSize: 12.sp, letterSpacing: 1.2),
              ),
              Obx(() => Text(
                "\$${controller.totalPrice.value}",
                style: TextStyle(
                  color: const Color(0xFF00C569),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          ),
          SizedBox(
            width: 160.w,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                // Checkout Logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C569),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "CHECKOUT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}