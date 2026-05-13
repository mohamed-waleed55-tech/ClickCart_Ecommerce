import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../cart/presentation/view_models/cart_view_model.dart';
import '../../model/api_response/product_model.dart';

class ProductDetails extends GetView<CartViewModel> {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 380.h,
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.white,
                    padding: REdgeInsets.all(40),
                    child: Image.network(
                      product.thumbnail ?? "",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                  ),
                  child: Padding(
                    padding: REdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildBrandTag(product.brand, colorScheme),
                            _buildStockStatus(product.availabilityStatus),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          product.title ?? "",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildPriceSection(product, theme, colorScheme),
                        const Divider(height: 32),
                        _buildSectionTitle("Description"),
                        Text(
                          product.description ?? "",
                          style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                        ),
                        SizedBox(height: 24.h),
                        _buildSpecificationsGrid(product),
                        SizedBox(height: 24.h),
                        _buildPolicyCard(product),
                        SizedBox(height: 24.h),
                        _buildReviewHeader(product),
                        _buildReviewsList(product.reviews),
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildFloatingTopButtons(),
        ],
      ),
      bottomSheet: _buildEnhancedBottomBar(colorScheme),
    );
  }


  Widget _buildBrandTag(String? brand, ColorScheme colorScheme) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        brand?.toUpperCase() ?? "GENERIC",
        style: TextStyle(color: colorScheme.primary, fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStockStatus(String? status) {
    bool isAvailable = status?.toLowerCase().contains("stock") ?? false;
    return Row(
      children: [
        CircleAvatar(radius: 4.r, backgroundColor: isAvailable ? Colors.green : Colors.red),
        SizedBox(width: 6.w),
        Text(status ?? "Unknown", style: TextStyle(color: isAvailable ? Colors.green : Colors.red, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildPriceSection(ProductModel product, ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Text("\$${product.price}", style: theme.textTheme.headlineSmall?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w900)),
        if (product.discountPercentage! > 0) ...[
          SizedBox(width: 10.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6.r)),
            child: Text("-${product.discountPercentage}%", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSpecificationsGrid(ProductModel product) {
    return Column(
      children: [
        _buildDetailRow("Weight", "${product.weight} kg"),
        _buildDetailRow("Dimensions", "${product.dimensions?.width}x${product.dimensions?.height} cm"),
        _buildDetailRow("SKU", product.sku),
      ],
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value ?? "N/A", style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(ProductModel product) {
    return Container(
      padding: REdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15.r)),
      child: Text(product.warrantyInformation ?? "No warranty info"),
    );
  }

  Widget _buildReviewHeader(ProductModel product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionTitle("Reviews"),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            Text(" ${product.rating} (${product.reviews?.length})", style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewsList(List<dynamic>? reviews) {
    if (reviews == null || reviews.isEmpty) return const Text("No reviews yet");
    return Column(
      children: reviews.map((r) => ListTile(
        title: Text(r.reviewerName ?? "User"),
        subtitle: Text(r.comment ?? ""),
        trailing: Text("${r.rating} ⭐"),
      )).toList(),
    );
  }

  Widget _buildFloatingTopButtons() {
    return SafeArea(
      child: Padding(
        padding: REdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(backgroundColor: Colors.white, child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back())),
            const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.favorite_border, color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedBottomBar(ColorScheme colorScheme) {
    return Container(
      padding: REdgeInsets.all(20),
      height: 100.h,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {

          controller.addProductToCart(Get.arguments);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        ),
        child: const Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}