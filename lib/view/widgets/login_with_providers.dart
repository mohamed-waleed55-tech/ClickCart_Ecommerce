import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/assets/images_manager.dart';

class LoginWithProviders extends StatelessWidget {
  const LoginWithProviders({super.key, required this.text, required this.image});
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(10.0),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 30.w, height: 30.h),
            SizedBox(width: 20.w),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
    );
  }
}
