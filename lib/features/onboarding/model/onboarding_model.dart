
import '../../../core/assets/images_manager.dart';

class OnboardingModel {
  final String title;
  final String desc;
  final String image;


  OnboardingModel({
    required this.title,
    required this.image,
    required this.desc,
  });

  static List<OnboardingModel> onboardingItems = [
    OnboardingModel(
      title: "Discover Latest Products",
      desc: "Shop from thousands of global and local favorite products all in one place at the best prices.",
      image: ImagesManager.onboarding1,
    ),
    OnboardingModel(
      title: "Secure & Easy Payment",
      desc: "We provide multiple, entirely secure payment methods, including credit card or cash on delivery.",
      image: ImagesManager.onboarding2,
    ),
    OnboardingModel(
      title: "Fast Delivery to Your Door",
      desc: "Enjoy a super-fast delivery experience with step-by-step shipment tracking until it reaches you.",
      image: ImagesManager.onboarding3,
    ),
  ];
}