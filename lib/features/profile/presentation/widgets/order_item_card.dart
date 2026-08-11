import 'package:ecommerce_app/features/checkout/model/order.dart';
import 'package:ecommerce_app/features/profile/presentation/widgets/order_road_line.dart';
import 'package:ecommerce_app/features/profile/presentation/widgets/order_road_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onCancel;

  const OrderItemCard({
    super.key,
    required this.order,
    this.onCancel,
  });

  // ============================================================
  // ORDER STATUS -> TRACKING STEP
  // ============================================================

  int _getCurrentStep(String status) {
    switch (status.trim().toLowerCase()) {
      case 'pending':
      case 'placed':
        return 0;

      case 'processing':
      case 'preparing':
        return 1;

      case 'shipped':
      case 'out for delivery':
        return 2;

      case 'delivered':
        return 3;

      case 'cancelled':
      case 'canceled':
        return -1;

      default:
        return 0;
    }
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _buildStatusBadge() {
    final status = order.status.trim().toLowerCase();

    late final Color backgroundColor;
    late final Color textColor;

    if (status == 'cancelled' || status == 'canceled') {
      backgroundColor = Colors.red.withValues(alpha: 0.10);
      textColor = Colors.red;
    } else if (status == 'delivered') {
      backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.10);
      textColor = const Color(0xFF10B981);
    } else if (status == 'shipped' ||
        status == 'out for delivery') {
      backgroundColor = Colors.blue.withValues(alpha: 0.10);
      textColor = Colors.blue;
    } else if (status == 'processing' ||
        status == 'preparing') {
      backgroundColor = Colors.orange.withValues(alpha: 0.10);
      textColor = Colors.orange.shade800;
    } else {
      backgroundColor = const Color(0xFFFBBF24).withValues(alpha: 0.10);
      textColor = const Color(0xFFD97706);
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        order.status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // CANCELLED MESSAGE
  // ============================================================

  Widget _buildCancelledMessage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_rounded,
              color: Colors.red,
              size: 18.sp,
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Cancelled',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),

                SizedBox(height: 2.h),

                Text(
                  'This order has been cancelled.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TRACKING
  // ============================================================

  Widget _buildTracking(int currentStep) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      duration: const Duration(
        milliseconds: 800,
      ),
      curve: Curves.easeOut,
      builder: (
        context,
        value,
        child,
      ) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              0,
              10 * (1 - value),
            ),
            child: child,
          ),
        );
      },
      child: Row(
        children: [
          OrderRoadNode(
            title: 'Placed',
            index: 0,
            currentIndex: currentStep,
          ),

          OrderRoadLine(
            index: 0,
            currentIndex: currentStep,
          ),

          OrderRoadNode(
            title: 'Processed',
            index: 1,
            currentIndex: currentStep,
          ),

          OrderRoadLine(
            index: 1,
            currentIndex: currentStep,
          ),

          OrderRoadNode(
            title: 'Shipped',
            index: 2,
            currentIndex: currentStep,
          ),

          OrderRoadLine(
            index: 2,
            currentIndex: currentStep,
          ),

          OrderRoadNode(
            title: 'Delivered',
            index: 3,
            currentIndex: currentStep,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SHIPPING ADDRESS
  // ============================================================

  Widget _buildShippingAddress() {
    final street =
        order.shippingAddress['street1']?.toString() ?? '';

    final city =
        order.shippingAddress['city']?.toString() ?? '';

    final address = [
      street,
      city,
    ].where((value) => value.isNotEmpty).join(', ');

    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 14.sp,
          color: Colors.grey,
        ),

        SizedBox(width: 6.w),

        Expanded(
          child: Text(
            address.isEmpty
                ? 'Shipping address unavailable'
                : 'Ship to: $address',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final currentStep = _getCurrentStep(order.status);

    final normalizedStatus =
        order.status.trim().toLowerCase();

    final isCancelled =
        normalizedStatus == 'cancelled' ||
        normalizedStatus == 'canceled';

    final isDelivered =
        normalizedStatus == 'delivered';

    return Container(
      margin: EdgeInsets.only(
        bottom: 16.h,
      ),
      padding: EdgeInsets.all(
        16.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16.r,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====================================================
          // HEADER
          // ====================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  order.id,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              _buildStatusBadge(),
            ],
          ),

          Divider(
            height: 20.h,
            color: Colors.grey.shade100,
          ),

          // ====================================================
          // DATE + PRICE
          // ====================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.sp,
                    color: Colors.grey,
                  ),

                  SizedBox(width: 6.w),

                  Text(
                    order.orderDate,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),

              Text(
                '\$${order.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),

          // ====================================================
          // NORMAL ORDER
          // ====================================================

          if (!isCancelled) ...[
            SizedBox(height: 20.h),

            // ==================================================
            // TRACKING
            // ==================================================

            _buildTracking(currentStep),

            // ==================================================
            // CANCEL BUTTON
            // ==================================================

            if (onCancel != null && !isDelivered) ...[
              SizedBox(height: 18.h),

              SizedBox(
                width: double.infinity,
                height: 42.h,
                child: OutlinedButton.icon(
                  onPressed: onCancel,

                  icon: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                  ),

                  label: Text(
                    'Cancel Order',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: BorderSide(
                      color: Colors.red.withValues(
                        alpha: 0.25,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ],
          ],

          // ====================================================
          // CANCELLED ORDER
          // ====================================================

          if (isCancelled) ...[
            SizedBox(height: 18.h),

            _buildCancelledMessage(),
          ],

          // ====================================================
          // DIVIDER
          // ====================================================

          SizedBox(height: 18.h),

          Divider(
            height: 1,
            color: Colors.grey.shade100,
          ),

          SizedBox(height: 14.h),

          // ====================================================
          // SHIPPING ADDRESS
          // ====================================================

          _buildShippingAddress(),
        ],
      ),
    );
  }
}