import 'package:ecommerce_app/features/cart/model/firestore_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../view_models/cart_view_model.dart';
class CartItemWidget extends GetView<CartViewModel> {
  const CartItemWidget({super.key, required this.product});

  final FirestoreProduct product;

  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: Key(product.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        controller.removeProductFromCart(product);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
      ),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(color: Colors.grey.withValues(alpha: 0.4), blurRadius: 5, offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleAndDiscount(),
                  SizedBox(height: 8.h),
                  Text(
                    "\$${product.price}",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF00C569)),
                  ),
                  SizedBox(height: 12.h),
                  _buildQuantityAndStock(controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 90.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Image.network(
          product.image ?? "",
          fit: BoxFit.contain,
          errorBuilder: (context, error, stack) => const Icon(Icons.image_not_supported, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildTitleAndDiscount() {
    return Row(
      children: [
        Expanded(
          child: Text(
            product.title ?? "Product",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
        if (product.discountPercentage != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4.r)),
            child: Text(
              "-${product.discountPercentage}%",
              style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
          )
      ],
    );
  }

  Widget _buildQuantityAndStock(CartViewModel controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => controller.decreaseQuantity(product),
                child: const Icon(Icons.remove, size: 24),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  "${product.quantity}",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () => controller.increaseQuantity(product),
                child: const Icon(Icons.add, size: 24),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text("Stock: ", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            Text(
              "${product.stock}",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ],
        ),
      ],
    );
  }
}