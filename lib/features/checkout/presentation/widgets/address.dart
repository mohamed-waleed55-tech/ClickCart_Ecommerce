import 'package:ecommerce_app/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../view_models/checkout_view_model.dart';

class AddressWidget extends GetWidget<CheckoutViewModel> {
  const AddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () => controller.billingSameAsDelivery.toggle(),
          child: Row(
            children: [
              Obx(
                () => Icon(
                  controller.billingSameAsDelivery.value
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "Billing address is the same as delivery address",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        _buildInputField("Street 1", controller.street1Controller),
        SizedBox(height: 24.h),

        _buildInputField("Street 2", controller.street2Controller),
        SizedBox(height: 24.h),

        _buildInputField("City", controller.cityController),
        SizedBox(height: 24.h),


        Row(
          children: [
            Expanded(child: _buildInputField("State", controller.stateController)),
            SizedBox(width: 16.w),
            Expanded(child: _buildInputField("Country", controller.countryController)),
          ],
        ),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: REdgeInsets.only(bottom: 20.0),
      child: CustomTextFormField(
        hint: label,
        prefixIcon: Icons.location_on,
        controller: controller,
      ),
    );
  }
}
