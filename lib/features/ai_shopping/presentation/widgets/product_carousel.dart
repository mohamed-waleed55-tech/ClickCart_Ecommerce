import 'package:ecommerce_app/features/ai_shopping/presentation/view_model/ai_chat_controller.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/best_seller_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ProductCarousel extends GetView<AiChatController> {
  const ProductCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final products = controller.searchResults;
    
    if (products.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 240.h, 
      margin:  REdgeInsets.only(bottom: 10),
      child: ListView.separated(
        padding:  REdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          
          return SizedBox(
            width: 160.w,
            child: BestSellerItem(
              item: product, 
            ),
          );
        },
      ),
    );
  }
}