import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/app_validators/app_validators.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/waves_background.dart';

class SignUp extends GetWidget<AuthViewModel> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: WaveBackground(),
          ),

          SafeArea(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  8.h,
                  16.w,
                  24.h,
                ),
                child: Form(
                  key: controller.signUpFormKey,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        Text(
                          'Sign Up',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        Text(
                          'Create a new account to start shopping',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.white.withAlpha(200),
                          ),
                        ),

                        SizedBox(height: 70.h),

                        CustomTextFormField(
                          hint: 'First name',
                          prefixIcon: Icons.person_outline,
                          onSaved: (value) => controller.fName = value?.trim() ?? '',
                          validator: AppValidators.firstName,
                        ),

                        SizedBox(height: 16.h),

                        CustomTextFormField(
                          hint: 'Last name',
                          prefixIcon: Icons.person_outline,
                          onSaved: (value) => controller.lName = value?.trim() ?? '',
                          validator: AppValidators.lastName,
                        ),

                        SizedBox(height: 16.h),

                        CustomTextFormField(
                          hint: 'Phone number',
                          prefixIcon: Icons.phone_outlined,
                          onSaved: (value) =>
                              controller.phoneNumber = value?.trim() ?? '',
                          validator: AppValidators.phoneNumber,
                        ),

                        SizedBox(height: 16.h),

                        CustomTextFormField(
                          hint: 'Enter your email',
                          prefixIcon: Icons.email_outlined,
                          onSaved: (value) => controller.email = value?.trim() ?? '',
                          validator: AppValidators.email,
                        ),

                        SizedBox(height: 16.h),

                        CustomTextFormField(
                          controller: controller.passwordController,
                          hint: 'Enter your password',
                          obscureText: true,
                          prefixIcon: Icons.lock_outline_rounded,
                          onSaved: (value) => controller.password = value ?? '',
                          validator: AppValidators.password,
                        ),

                        SizedBox(height: 16.h),

                        CustomTextFormField(
                          hint: 'Confirm your password',
                          obscureText: true,
                          prefixIcon: Icons.lock_outline_rounded,
                          validator: (value) {
                            return AppValidators.confirmPassword(
                              value,
                              controller.passwordController.text,
                            );
                          },
                        ),

                        SizedBox(height: 40.h),

                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () => controller.signUpWithEmail(),
                              child: controller.isLoading.value
                                  ? SizedBox(
                                      height: 24.h,
                                      width: 24.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.w,
                                        color: theme.colorScheme.onPrimary,
                                      ),
                                    )
                                  : Text(
                                      'Sign Up',
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        color: theme.colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: theme.textTheme.bodySmall,
                            ),
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                'Sign In',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}