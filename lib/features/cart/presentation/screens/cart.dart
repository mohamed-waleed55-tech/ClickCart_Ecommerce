import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/images_manager.dart';
import '../../../../core/navigation/app_routes.dart';
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
      ),
      body: Obx(() {
        if (controller.cartProducts.isEmpty) {
          return Center(
            child: Image(image: AssetImage(ImagesManager.emptyCart), width: 200.w, height: 200.h),
          );
        }
        
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                itemCount: controller.cartProducts.length,
                itemBuilder: (context, index) => CartItemWidget(product: controller.cartProducts[index]),
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
              ),
            ),
            
            _buildCheckoutBottomBar(context),
            
            SizedBox(height: 70.h), 
          ],
        );
      }),
    );
  }

  Widget _buildCheckoutBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, -4)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("TOTAL", style: TextStyle(color: Colors.grey, fontSize: 11.sp, letterSpacing: 1.2)),
                Obx(() => Text(
                  "\$${controller.totalPrice.value.toStringAsFixed(3)}",
                  style: const TextStyle(color: Color(0xFF388E3C), fontSize: 16, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.checkout),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF388E3C),
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: const Text("CHECKOUT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}