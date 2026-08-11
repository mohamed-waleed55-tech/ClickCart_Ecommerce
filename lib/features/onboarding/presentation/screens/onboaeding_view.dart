import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/core/navigation/app_routes.dart';
import 'package:ecommerce_app/features/onboarding/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/images_manager.dart';
import '../../../../core/database/local_storage_service.dart';
import '../widgets/onboarding_item.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPageIndex = 0;
  final PageController controller = PageController();

  final LocalStorageService _storageService = LocalStorageService();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _completeOnboarding() async {
    await _storageService.setFirstTimeComplete();

    Get.offAllNamed(AppRoutes.authGate);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentPageIndex == OnboardingModel.onboardingItems.length - 1;
    final bool isFirstPage = currentPageIndex == 0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              margin: REdgeInsets.only(top: 8),
              child: Image.asset(ImagesManager.logo),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: OnboardingModel.onboardingItems.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingItem(
                    onboardingDm: OnboardingModel.onboardingItems[index],
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (isFirstPage) {
                        _completeOnboarding();
                      } else {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      isFirstPage ? "Skip" : "Back",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  DotsIndicator(
                    dotsCount: OnboardingModel.onboardingItems.length,
                    position: currentPageIndex.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: Theme.of(context).colorScheme.primary,
                      color: Colors.grey.shade300,
                      size: const Size.square(9),
                      activeSize: const Size(18, 9),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      if (isLastPage) {
                        _completeOnboarding();
                      } else {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      isLastPage ? "Finish" : "Next",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}