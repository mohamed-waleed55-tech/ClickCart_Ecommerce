import 'package:ecommerce_app/features/onboarding/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.onboardingDm,
  });

  final OnboardingModel onboardingDm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                height: 300.h,
                onboardingDm.image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            onboardingDm.title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            onboardingDm.desc,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),

          const Spacer(flex: 1),
        ],
      ),
    );
  }
}