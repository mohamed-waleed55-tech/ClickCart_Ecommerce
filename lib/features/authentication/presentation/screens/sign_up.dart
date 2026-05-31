import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../view_models/auth_view_model.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/waves_background.dart';
import 'login_screen.dart';


class SignUp extends GetWidget<AuthViewModel> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => const LoginScreen());
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
           WaveBackground(),

          SafeArea(
            child: SingleChildScrollView(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: formKey,
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
                      hint: 'Enter your name',
                      prefixIcon: Icons.person_outline,
                      onSaved: (value) => controller.name = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      hint: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      onSaved: (value) => controller.email = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      hint: 'Enter your password',
                      obscureText: true,
                      prefixIcon: Icons.lock_outline_rounded,
                      onSaved: (value) => controller.password = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      hint: 'Confirm your password',
                      obscureText: true,
                      prefixIcon: Icons.lock_outline_rounded,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                         if (value != controller.password) return 'Passwords do not match';
                        return null;
                      },
                    ),

                    SizedBox(height: 40.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            controller.signUpWithEmail();
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?", style: theme.textTheme.bodySmall),
                        TextButton(
                          onPressed: () => Get.off(() => const LoginScreen()),
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
        ],
      ),
    );
  }
}