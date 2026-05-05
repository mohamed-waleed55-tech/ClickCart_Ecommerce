import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../view_models/auth_view_model.dart';
import '../widgets/custom_text_form_field.dart';
import 'login_screen.dart';

class SignUp extends GetWidget<AuthViewModel> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.off(LoginScreen());
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text('Sign Up', style: theme.textTheme.titleLarge),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  hint: 'Enter your name',
                  label: 'Name',
                  prefixIcon: Icons.person_outline,
                  onSaved: (value) {
                    controller.name = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30.h),

                CustomTextFormField(
                  hint: 'Enter your email',
                  label: 'Email',
                  prefixIcon: Icons.email_outlined,
                  onSaved: (value) {
                    controller.email = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30.h),

                CustomTextFormField(
                  hint: 'Enter your password',
                  label: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline_rounded,
                  onSaved: (value) {
                    controller.password = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                CustomTextFormField(
                  hint: 'Confirm your password',
                  label: 'Confirm Password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline_rounded,
                  onSaved: (value) {
                    controller.password = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50.h),

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
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
