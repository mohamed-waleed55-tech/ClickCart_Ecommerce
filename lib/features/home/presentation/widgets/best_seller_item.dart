import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/images_manager.dart';
class BestSellerItem extends StatelessWidget {
  const BestSellerItem({
    super.key,
    this.width,
    this.productName = "Product Name",
    this.shopName = "Shop Name",
    this.price = "\$100",
  });

  final double? width;
  final String productName;
  final String shopName;
  final String price;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: width,
      child: Container(
        padding: REdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                color: colorScheme.secondary.withAlpha(28),
              ),
              child: Padding(
                padding: REdgeInsets.all(14),
                child: Image.asset(
                  ImagesManager.img,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              productName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              shopName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withAlpha(150),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              price,
              style: theme.textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
