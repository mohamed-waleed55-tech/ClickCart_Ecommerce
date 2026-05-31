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
        mainAxisAlignment: MainAxisAlignment.center, // توسيط العناصر عمودياً لتبدو احترافية
        crossAxisAlignment: CrossAxisAlignment.start, // توسيط العناصر أفقياً
        children: [
          Expanded(
            flex: 5, // تاخد المساحة الأكبر من الشاشة للرسمة التوضيحية
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                height: 300.h,
                onboardingDm.image,
                fit: BoxFit.cover, // يحافظ على أبعاد الصورة بدون مط أو تشويه
              ),
            ),
          ),

          SizedBox(height: 16.h), // مساحة مرنة متناسقة مع الشاشات

          // 2️⃣ عنوان الشاشة الترحيبية
          Text(
            onboardingDm.title,
            textAlign: TextAlign.start, // محاذاة في المنتصف
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp// إبراز العنوان
            ),
          ),

          SizedBox(height: 16.h),

          // 3️⃣ الوصف التفصيلي
          Text(
            onboardingDm.desc,
            textAlign: TextAlign.start, // محاذاة في المنتصف لجعل النص مريح للقراءة
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 16.sp,
              color: Colors.grey.shade600, // لون رمادي هادئ للوصف
              height: 1.5, // مسافة بين السطور (Line Height) تعطي راحة للعين
            ),
          ),

          const Spacer(flex: 1), // يدفع المكونات لأعلى قليلاً لترك مساحة مريحة للـ Buttons بالأسفل
        ],
      ),
    );
  }
}