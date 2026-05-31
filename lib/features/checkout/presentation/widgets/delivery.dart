import 'package:ecommerce_app/features/checkout/presentation/view_models/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryWidget extends GetWidget<CheckoutViewModel> {
  const DeliveryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        _buildDeliveryOption(
          controller,
          index: 0,
          title: "Standard Delivery",
          subtitle: "Order will be delivered between 3 - 5 business days",
          context: context,
        ),
        const SizedBox(height: 24),
        _buildDeliveryOption(
          controller,
          index: 1,
          title: "Next Day Delivery",
          subtitle:
              "Place your order before 6pm and your items will be delivered the next day",
          context: context,
        ),
        const SizedBox(height: 24),
        _buildDeliveryOption(
          controller,
          index: 2,
          title: "Nominated Delivery",
          subtitle:
              "Pick a particular date from the calendar and order will be delivered on selected date",
          context: context,
        ),
      ],
    );
  }

  Widget _buildDeliveryOption(
    CheckoutViewModel controller, {
    required int index,
    required String title,
    required String subtitle,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => controller.selectedDeliveryOption.value = index,
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Obx(() {
              bool isSelected =
                  controller.selectedDeliveryOption.value == index;
              return Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade300,
                    width: isSelected
                        ? 6
                        : 2,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
