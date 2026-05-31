import 'package:ecommerce_app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:ecommerce_app/features/profile/presentation/widgets/account_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/images_manager.dart';
import '../../../../core/navigation/app_routes.dart';

class Profile extends GetWidget<ProfileViewModel> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 30.h),

              Obx(() {
                if (controller.isLoading.value) {
                  return SizedBox(
                    height: 80.h,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.user.value == null) {
                  return SizedBox(
                    height: 80.h,
                    child: const Center(child: Text("Unable to load profile info")),
                  );
                }

                final user = controller.user.value!;
                final firstLetter = user.name.isNotEmpty
                    ? user.name.substring(0, 1).toUpperCase()
                    : '?';

                return Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Center(
                        child: Text(
                          firstLetter,
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                );
              }),

              SizedBox(height: 50.h),

              Expanded(
                child: ListView(
                  children: [
                    AccountMenuItem(
                      icon: Icons.edit,
                      title: "Edit Profile",
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    AccountMenuItem(
                      icon: Icons.location_on,
                      title: "Shipping Address",
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    AccountMenuItem(
                      icon: Icons.history,
                      title: "Order History",
                      onTap: () {
                        Get.toNamed(AppRoutes.ordersHistory);
                      },
                    ),
                    SizedBox(height: 20.h),
                    AccountMenuItem(
                      icon: Icons.credit_card,
                      title: "Cards",
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    AccountMenuItem(
                      icon: Icons.notifications,
                      title: "Notifications",
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    AccountMenuItem(
                      icon: Icons.logout,
                      title: "Log Out",
                      onTap: () {
                        controller.signOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}