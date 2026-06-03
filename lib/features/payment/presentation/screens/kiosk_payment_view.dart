import 'package:flutter/material.dart';

class KioskPaymentView extends StatelessWidget {
  final String referenceCode;

  const KioskPaymentView({
    super.key,
    required this.referenceCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiosk Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.storefront_rounded,
              size: 70,
              color: Color(0xFF388E3C),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your reference code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SelectableText(
              referenceCode,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Color(0xFF388E3C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Use this code to pay through Aman, Masary, or any supported kiosk provider.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}