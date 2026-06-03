import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_models/checkout_view_model.dart';

class PaymentMethod extends GetView<CheckoutViewModel> {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Obx(
            () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            _buildPaymentOption(
              id: 'card',
              title: 'Credit / Debit Card',
              subtitle: 'Visa, Mastercard, Meeza',
              icon: Icons.credit_card_rounded,
            ),

            const SizedBox(height: 16),

            _buildPaymentOption(
              id: 'kiosk',
              title: 'Kiosk Payment (Paymob)',
              subtitle: 'Pay via Aman, Masary, etc.',
              icon: Icons.storefront_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool isSelected = controller.selectedPaymentMethod.value == id;

    return GestureDetector(
      onTap: () {
        controller.selectedPaymentMethod.value = id;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF388E3C) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.05 : 0.01),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF388E3C).withOpacity(0.1)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF388E3C)
                    : Colors.grey.shade600,
                size: 24,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

            Radio<String>(
              value: id,
              groupValue: controller.selectedPaymentMethod.value,
              activeColor: const Color(0xFF388E3C),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedPaymentMethod.value = value;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}