import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/assets/images_manager.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/login_with_providers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Welcome,', style: theme.textTheme.titleLarge),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text('Sign Up', style: theme.textTheme.titleSmall),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                'Sign in to continue',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 28.h),

              CustomTextFormField(
                hint: 'Enter your email',
                label: 'Email',
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(height: 16.h),

              CustomTextFormField(
                hint: 'Enter your password',
                label: 'Password',
                obscureText: true,
                prefixIcon: Icons.lock_outline_rounded,
              ),
              SizedBox(height: 8.h),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Sign In',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(child: Divider(color: theme.dividerColor)),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'OR',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: theme.dividerColor)),
                ],
              ),

              SizedBox(height: 40.h),

              LoginWithProviders(
                text: 'Sign in with Facebook',
                image: ImagesManager.facebook,
              ),
              SizedBox(height: 14.h),
              LoginWithProviders(
                text: 'Sign in with Google',
                image: ImagesManager.google,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
