import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_models/checkout_view_model.dart';

class Checkout extends GetWidget<CheckoutViewModel> {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Obx(
          () => controller.isFirstStep
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black87,
                    size: 20,
                  ),
                  onPressed: controller.previousStep,
                ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ), // قللت الـ padding ليناسب 4 عناصر بشكل مريح
              child: _buildCustomStepper(),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child:
                      controller.checkoutScreens[controller.activeStep.value],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomActionBar(context),
    );
  }

  Widget _buildCustomStepper() {
    final steps = [
      'Delivery',
      'Address',
      'Summary',
      'Payment',
    ]; // أضفنا الخطوة الرابعة هنا
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
                  width:
                      28, // صغرت الحجم قليلاً (من 32 لـ 28) لتتسع الشاشة لـ 4 خطوات بدون مشاكل overflow
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent
                        ? const Color(0xFF388E3C)
                        : isDone
                        ? const Color(0xFF388E3C).withValues(alpha: 0.15)
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
                        ? const Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: Color(0xFF388E3C),
                          )
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isCurrent
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 4),
                // اسم الخطوة
                Text(
                  steps[index],
                  style: TextStyle(
                    fontSize:
                        11, // تقليل حجم الخط ليناسب التصميم المتجاوب لـ 4 خطوات
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                    color: isCurrent
                        ? Colors.black87
                        : isDone
                        ? Colors.black87
                        : Colors.grey.shade400,
                  ),
                ),
                // الخط الفاصل
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      color: index < currentStep
                          ? const Color(0xFF388E3C)
                          : Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          );
        }),
      );
    });
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Obx(
              () => controller.isFirstStep
                  ? const SizedBox.shrink()
                  : OutlinedButton(
                      onPressed: controller.previousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),

            Obx(() => SizedBox(width: controller.isFirstStep ? 0 : 16)),

            Expanded(
              child: ElevatedButton(
                onPressed: controller.nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Obx(
                  () => Text(
                    controller.isLastStep ? 'Pay Now' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
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
