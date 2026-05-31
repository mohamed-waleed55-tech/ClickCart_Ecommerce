import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/constant.dart'; // تأكد من وجود ألوانك (inProgressColor, todoColor) هنا
import '../view_models/checkout_view_model.dart';

class Checkout extends GetWidget<CheckoutViewModel> {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // خلفية هادئة تبرز محتوى البطاقات
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Obx(() => controller.isFirstStep
            ? const SizedBox.shrink()
            : IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: controller.previousStep,
        )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),

            // 1. الـ Custom Stepper العصري والأنيق
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildCustomStepper(),
            ),

            const SizedBox(height: 25),

            // 2. محتوى الشاشة الفرعية الحالية داخل Container ناعم
            Expanded(
              child: Obx(
                    () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: controller.checkoutScreens[controller.activeStep.value],
                ),
              ),
            ),
          ],
        ),
      ),

      // 3. عزل منطقة الأزرار في الأسفل لضمان ثباتها وجمالها عند ظهور الكيبورد
      bottomNavigationBar: _buildBottomActionBar(context),
    );
  }

  // ميثود لبناء الـ Stepper المخصص الخفيف بدلاً من الـ Package التقليدية
  Widget _buildCustomStepper() {
    final steps = ['Delivery', 'Address', 'Summary'];
    return Obx(() {
      int currentStep = controller.activeStep.value;
      return Row(
        children: List.generate(steps.length, (index) {
          bool isCurrent = index == currentStep;
          bool isDone = index < currentStep;

          return Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent
                        ? const Color(0xFF388E3C)
                        : isDone
                        ? const Color(0xFF388E3C).withOpacity(0.15)
                        : Colors.white,
                    border: Border.all(
                      color: isCurrent || isDone
                          ? const Color(0xFF388E3C)
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isDone
                        ? const Icon(Icons.check_rounded, size: 16, color: Color(0xFF388E3C))
                        : Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isCurrent ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // اسم الخطوة
                Text(
                  steps[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                    color: isCurrent
                        ? Colors.black87
                        : isDone
                        ? Colors.black87
                        : Colors.grey.shade400,
                  ),
                ),
                // الخط الفاصل (يظهر بين الخطوات فقط)
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: index < currentStep ? const Color(0xFF388E3C) : Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          );
        }),
      );
    });
  }

  // ميثود بناء منطقة الأزرار السفلية بأسلوب احترافي وعريض
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // إذا لم نكن في الخطوة الأولى، نُظهر زر رجوع نصي أنيق وواضح
            Obx(() => controller.isFirstStep
                ? const SizedBox.shrink()
                : OutlinedButton(
              onPressed: controller.previousStep,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Back',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            )),

            // مسافة ديناميكية بين الزرين
            Obx(() => SizedBox(width: controller.isFirstStep ? 0 : 16)),

            // الزر الأساسي الممتد (Next / Place Order)
            Expanded(
              child: ElevatedButton(
                onPressed: controller.nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary, // لون براند التوصيل الأخضر المريح
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Obx(
                      () => Text(
                    controller.isLastStep ? 'Place Order' : 'Next',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}