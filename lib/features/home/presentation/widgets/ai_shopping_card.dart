import 'package:ecommerce_app/core/assets/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiShoppingCard extends StatelessWidget {
  final VoidCallback? onTap;

  const AiShoppingCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150.h,
        padding: EdgeInsets.only(left: 18.w, top: 16.h, bottom: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D9488), Color(0xFF14B8A6), Color(0xFF5EEAD4)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0D9488).withValues(alpha: 0.20),
              blurRadius: 15,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              right: -30.w,
              top: -35.h,
              child: Container(
                width: 110.w,
                height: 110.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),

            Positioned(
              right: 70.w,
              bottom: -45.h,
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text section
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Smart Shopping',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),

                      SizedBox(height: 2.h),

                      Text(
                        'with AI Assistant',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 13.h),

                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 7.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Shop Now',
                                style: TextStyle(
                                  color: const Color(0xFF0D9488),
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 14.sp,
                                color: const Color(0xFF0D9488),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex:6 ,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      ImagesManager.aiRobot,
                      height: 125.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.smart_toy_rounded,
                          color: Colors.white,
                          size: 80.sp,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Sparkles
            Positioned(
              right: 105.w,
              top: 15.h,
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white.withValues(alpha: 0.8),
                size: 15.sp,
              ),
            ),

            Positioned(
              right: 125.w,
              bottom: 28.h,
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white.withValues(alpha: 0.6),
                size: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
