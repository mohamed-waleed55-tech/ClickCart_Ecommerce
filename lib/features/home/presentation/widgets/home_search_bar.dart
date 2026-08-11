import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../view_models/home_view_model.dart';

class HomeSearchBar extends GetView<HomeViewModel> {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextField(
        onChanged: (value) {
          controller.searchProducts(value);
        },
        controller: controller.searchController,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: "Search products...",
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey,
            size: 22.sp,
          ),
          suffixIcon: Obx(
            () => controller.isSearching.value
                ? IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.grey),
                    onPressed: () =>
                        controller.clearSearch(),
                  )
                : Container(
                    margin: REdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
