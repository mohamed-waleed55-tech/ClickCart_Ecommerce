import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../checkout/presentation/view_models/checkout_view_model.dart';

class CardPaymentWebView extends StatefulWidget {
  final String url;

  const CardPaymentWebView({
    super.key,
    required this.url,
  });

  @override
  State<CardPaymentWebView> createState() => _CardPaymentWebViewState();
}

class _CardPaymentWebViewState extends State<CardPaymentWebView> {
  late final WebViewController controller;
  int progress = 0;
  bool paymentHandled = false;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) {
            setState(() {
              progress = value;
            });
          },
          onPageFinished: _handlePaymentResult,
          onWebResourceError: (error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _handlePaymentResult(String url) {
    if (paymentHandled) return;

    final uri = Uri.tryParse(url);
    if (uri == null) return;

    if (!uri.path.contains('post_pay')) return;

    paymentHandled = true;

    final success = uri.queryParameters['success'] == 'true';
    final message = uri.queryParameters['data.message'] ??
        uri.queryParameters['txn_response_code'] ??
        'Payment failed';

    if (success) {
      Get.snackbar(
        'Success',
        'Payment completed successfully',
        snackPosition: SnackPosition.TOP,
      );

      Get.find<CheckoutViewModel>().placeOrderAndClearCart();
    } else {
      Get.snackbar(
        'Payment Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Payment'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),

          if (progress < 100)
            LinearProgressIndicator(
              value: progress / 100,
            ),
        ],
      ),
    );
  }
}