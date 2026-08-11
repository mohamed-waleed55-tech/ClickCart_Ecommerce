import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductImageSlider extends StatelessWidget {
  final List<String> images;
  final RxInt _currentPage = 0.obs; // تتبع الصورة الحالية باستخدام GetX

  ProductImageSlider({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. معرض الصور (Slider)
        PageView.builder(
          onPageChanged: (index) => _currentPage.value = index,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              padding: REdgeInsets.all(40),
              child: Image.network(
                images[index],
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
              ),
            );
          },
        ),

        // 2. مؤشر الصور (Indicators)
        Positioned(
          bottom: 20.h,
          left: 0,
          right: 0,
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: _currentPage.value == index ? 24.w : 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: _currentPage.value == index ? Colors.blue : Colors.grey.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          )),
        ),
      ],
    );
  }
}