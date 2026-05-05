import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/product_model.dart';

class BestSellerItem extends StatelessWidget {
  const BestSellerItem({super.key, this.width, required this.item});

  final double? width;
  final ProductModel item;

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
                child: Image.asset(item.image, fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              item.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withAlpha(150),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "${item.price} \$",
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
