import 'package:ecommerce_app/features/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                product.title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  child: _buildDetailRow(
                    context: context,
                    label: "Size",
                    value: "XL",
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInfoCard(
                  child: _buildColorRow(context, "Blue", Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: Text(product.description, style: Theme.of(context).textTheme.bodySmall
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildDetailRow({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$label: ",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall,
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildColorRow(BuildContext context, String name, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Color: ",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall,
        ),
        const Spacer(),
        Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    );
  }
}
