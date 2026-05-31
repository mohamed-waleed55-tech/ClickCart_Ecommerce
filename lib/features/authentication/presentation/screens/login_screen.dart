import 'package:ecommerce_app/features/authentication/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../core/assets/images_manager.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/login_with_providers.dart';
import '../widgets/waves_background.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
  const LoginScreen({super.key});

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
      ),
      body: Stack(
        children: [
          const WaveBackground(),

          SafeArea(
            child: SingleChildScrollView(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text('Welcome,',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Get.to(const SignUp()),
                          child: Text('Sign Up',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Sign in to continue',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white.withAlpha(200),
                      ),
                    ),

                    SizedBox(height: 80.h),

                    CustomTextFormField(
                      hint: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      onSaved: (value) => controller.email = value!,
                      validator: (value) => (value == null || value.isEmpty) ? 'Please enter your email' : null,
                    ),

                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      hint: 'Enter your password',
                      obscureText: true,
                      prefixIcon: Icons.lock_outline_rounded,
                      onSaved: (value) => controller.password = value!,
                      validator: (value) => (value == null || value.isEmpty) ? 'Please enter your password' : null,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password?',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            controller.loginWithEmailAndPassword();
                          }
                        },
                        child: Text('Sign In',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    Row(
                      children: [
                        Expanded(child: Divider(color: theme.dividerColor)),
                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR', style: theme.textTheme.bodySmall),
                        ),
                        Expanded(child: Divider(color: theme.dividerColor)),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    LoginWithProviders(
                      text: 'Sign in with Facebook',
                      image: ImagesManager.facebook,
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    LoginWithProviders(
                      text: 'Sign in with Google',
                      image: ImagesManager.google,
                      onTap: () => controller.signInWithGoogle(),
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