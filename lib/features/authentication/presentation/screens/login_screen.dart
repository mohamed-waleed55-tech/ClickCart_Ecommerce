import 'package:ecommerce_app/features/authentication/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/app_validators/app_validators.dart';
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
              padding: REdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),

              child: Form(
                key: controller.loginFormKey,

                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ),

                  duration: const Duration(
                    milliseconds: 600,
                  ),

                  curve: Curves.easeOutCubic,

                  builder: (
                    context,
                    value,
                    child,
                  ) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        30 * (1 - value),
                      ),

                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      SizedBox(height: 20.h),


                      Row(
                        children: [
                          Text(
                            'Welcome,',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          TextButton(
                            onPressed: () {
                              Get.to(
                                () => const SignUp(),

                                transition:
                                    Transition.rightToLeftWithFade,

                                duration: const Duration(
                                  milliseconds: 350,
                                ),

                                curve: Curves.easeOutCubic,
                              );
                            },

                            child: Text(
                              'Sign Up',

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

                        onSaved: (value) {
                          controller.email =
                              value?.trim() ?? '';
                        },

                        validator: AppValidators.email,
                      ),

                      SizedBox(height: 16.h),

                  

                      CustomTextFormField(
                        hint: 'Enter your password',

                        obscureText: true,

                        prefixIcon:
                            Icons.lock_outline_rounded,

                        onSaved: (value) {
                          controller.password =
                              value ?? '';
                        },

                        validator:
                            AppValidators.loginPassword,
                      ),

                   

                      Align(
                        alignment: Alignment.centerRight,

                        child: TextButton(
                          onPressed: () {},

                          child: Text(
                            'Forgot Password?',

                            style:
                                theme.textTheme.titleSmall?.copyWith(
                              color:
                                  theme.colorScheme.primary,

                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                 

                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          height: 50.h,

                          child: ElevatedButton(
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : () {
                                        controller
                                            .loginWithEmailAndPassword();
                                      },

                            child:
                                controller.isLoading.value
                                    ? SizedBox(
                                        height: 24.h,
                                        width: 24.h,

                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth: 2.w,

                                          color: theme
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      )

                                    : Text(
                                        'Sign In',

                                        style: theme
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                          color: theme
                                              .colorScheme
                                              .onPrimary,

                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                    

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: theme.dividerColor,
                            ),
                          ),

                          Padding(
                            padding:
                                REdgeInsets.symmetric(
                              horizontal: 10,
                            ),

                            child: Text(
                              'OR',

                              style:
                                  theme.textTheme.bodySmall,
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: theme.dividerColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30.h),

                 

                      LoginWithProviders(
                        text: 'Sign in with Facebook',

                        image: ImagesManager.facebook,

                        onTap: () {},
                      ),

                      SizedBox(height: 20.h),

                  

                      Obx(
                        () => IgnorePointer(
                          ignoring:
                              controller.isLoading.value,

                          child: LoginWithProviders(
                            text: 'Sign in with Google',

                            image: ImagesManager.google,

                            onTap: () {
                              controller
                               .signInWithGoogle();
                            },
                          ),
                        ),
                      ),
                    ],
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