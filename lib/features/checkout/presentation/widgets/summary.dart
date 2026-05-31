import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_models/checkout_view_model.dart';

class SummaryWidget extends GetWidget<CheckoutViewModel> {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    final String fullAddress = [
      controller.street1Controller.text,
      controller.street2Controller.text,
      controller.cityController.text,
      controller.stateController.text,
      controller.countryController.text,
    ].where((element) => element.isNotEmpty).join(', ');

    String getDeliveryMethodName() {
      switch (controller.selectedDeliveryOption.value) {
        case 1:
          return "Next Day Delivery (Next business day)";
        case 2:
          return "Nominated Delivery (Selected Date)";
        case 0:
        default:
          return "Standard Delivery (3 - 5 business days)";
      }
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const Text(
          "Items",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 175,
          child: Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.cartProducts.length,
            itemBuilder: (context, index) {
              final product = controller.cartProducts[index];
              return Container(
                width: 110,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: product.image != null && product.image!.isNotEmpty
                          ? Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => const Icon(Icons.image_outlined, color: Colors.grey),
                      )
                          : const Icon(Icons.image_outlined, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          )),
        ),

        const Divider(height: 32, thickness: 1),

        _buildSectionHeader("Shipping Address", () => controller.updateStep(1)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 10)],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on_outlined, color: primaryColor, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  fullAddress.isEmpty ? "No address provided yet." : fullAddress,
                  style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 32, thickness: 1),

        _buildSectionHeader("Delivery Method", () => controller.updateStep(0)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 10)],
          ),
          child: Row(
            children: [
              Icon(Icons.local_shipping_outlined, color: primaryColor, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() => Text(
                  getDeliveryMethodName(),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                )),
              ),
            ],
          ),
        ),

        const Divider(height: 32, thickness: 1),

        const Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            children: [
              _buildPriceRow("Subtotal", "\$${controller.totalPrice.value}"),
              const SizedBox(height: 12),
              _buildPriceRow("Shipping Fees", "Free"),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(height: 1),
              ),
              _buildPriceRow("Total", "\$${controller.totalPrice.value}", isTotal: true),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onEditTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        GestureDetector(
          onTap: onEditTap,
          child: const Text(
            "Change",
            style: TextStyle(color: Color(0xFF00C569), fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
            color: isTotal ? Colors.black87 : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFF00C569) : Colors.black87,
          ),
        ),
      ],
    );
  }
}