import 'package:ecommerce_app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_routes.dart';

class Profile extends GetWidget<ProfileViewModel> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              
              Obx(() {
                if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
                if (controller.user.value == null) return const Center(child: Text("Unable to load profile"));

                final user = controller.user.value!;
                final firstLetter = user.name.isNotEmpty ? user.name[0].toUpperCase() : '?';

                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.green.shade100,
                        child: Text(firstLetter, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.green.shade800)),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        Text(user.email, style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp)),
                      ],
                    ),
                  ],
                );
              }),

              SizedBox(height: 40.h),

              // --- قائمة الخيارات ---
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildMenuItem(Icons.edit, "Edit Profile", () => Get.toNamed(AppRoutes.editProfile)),
                    _buildDivider(),
                    _buildMenuItem(Icons.location_on, "Shipping Address", () {}),
                    _buildDivider(),
                    _buildMenuItem(Icons.history, "Order History", () => Get.toNamed(AppRoutes.ordersHistory)),
                    _buildDivider(),
                    _buildMenuItem(Icons.notifications, "Notifications", () {}),
                    SizedBox(height: 30.h),
                    
                    // زر تسجيل الخروج بتصميم مميز
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text("Log Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      onTap: () => controller.signOut(),
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

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildDivider() => const Divider(color: Color(0xFFEEEEEE), thickness: 1);
}