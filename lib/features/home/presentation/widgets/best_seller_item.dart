import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../model/api_response/product_model.dart';

class BestSellerItem extends StatelessWidget {
  const BestSellerItem({super.key, this.width, required this.item});

  final double? width;
  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: item),
      child: Container(
        width: width,
        padding: REdgeInsets.all(8), // زيادة البادينج قليلاً لجمال التصميم
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22.r),
          // إضافة ظل خفيف يجعل الكارت يبدو احترافياً (اختياري)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // جعل المحاذاة لليسار أجمل للمتاجر
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                  color: colorScheme.secondary.withAlpha(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: Image.network(
                    item.thumbnail ?? "",
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              item.title ?? "No Title",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),

            SizedBox(height: 4.h),

            Text(
              item.description ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),

            SizedBox(height: 6.h),

            Row(
              children: [
                Text(
                  "${item.price ?? 0} \$",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                  ),
                Spacer(),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "${item.discountPercentage ?? 0} %",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    )
                  ),
                )],
            ),
          ],
        ),
      ),
    );
  }
}