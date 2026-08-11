import 'package:ecommerce_app/features/cart/model/firestore_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../cart/data/cart_repository/cart_repository.dart';
import '../../../cart/model/firestore_result.dart';
import '../../../home/data/api_error_handling/network_exceptions.dart';
import '../../../payment/presentation/view_models/payment_view_model.dart';
import '../../data/data_source/order_remote_data_source_imp.dart';
import '../widgets/address.dart';
import '../widgets/delivery.dart';
import '../widgets/payment_method.dart';
import '../widgets/summary.dart';

class CheckoutViewModel extends GetxController {
  final CartRepository _cartRepository;
  final OrdersRemoteDataSourceImp _ordersRemoteDataSource;

  CheckoutViewModel(this._cartRepository, this._ordersRemoteDataSource);

  @override
  void onInit() {
    super.onInit();
    getLocalCarts();
  }

  var activeStep = 0.obs;
  var totalPrice = 0.0.obs;
  var isSubmitting = false.obs;
  var selectedDeliveryOption = 0.obs;
  var errorMessage = ''.obs;
  var billingSameAsDelivery = true.obs;
  var selectedPaymentMethod = 'card'.obs;
  bool get isCard => selectedPaymentMethod.value == 'card';

  // 1. متغير جديد لتتبع وسيلة الدفع المختارة (card أو kiosk)

  RxList<FirestoreProduct> cartProducts = <FirestoreProduct>[].obs;

  TextEditingController street1Controller = TextEditingController();
  TextEditingController street2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  bool get isLastStep => activeStep.value == checkoutScreens.length - 1;
  bool get isFirstStep => activeStep.value == 0;

  List<Widget> get checkoutScreens => [
    const DeliveryWidget(),
    const AddressWidget(),
    const SummaryWidget(),
    const PaymentMethod(), 
  ];

  void calculateTotalPrice() {
    double total = 0.0;
    for (var product in cartProducts) {
      double price = 0.0;
      if (product.price is num) {
        price = (product.price as num).toDouble();
      } else {
        price = double.tryParse(product.price.toString()) ?? 0.0;
      }
      int quantity = product.quantity ?? 1;
      total += price * quantity;
    }
    totalPrice.value = total;
  }

  void updateStep(int index) => activeStep.value = index;

  void previousStep() {
    if (activeStep.value > 0) activeStep.value--;
  }
  void nextStep() {
    if (!isLastStep) {
      activeStep.value++;
    } else {
      startPaymentProcess();
    }
  }

  void startPaymentProcess() {
    if (cartProducts.isEmpty) {
      Get.snackbar('Error', 'Your cart is empty');
      return;
    }

    final paymentController = Get.find<PaymentController>();

    int amountInCents = (totalPrice.value * 100).toInt();
    bool isCard = selectedPaymentMethod.value == 'card';

    paymentController.startPaymentFlow(
      amountCents: amountInCents.toString(),
      isCardPayment: isCard,
    ).then((_) {
      
    });
  }

  Future<void> placeOrderAndClearCart() async {
    isSubmitting.value = true;

    final orderData = {
      'orderId': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      'orderDate': DateTime.now().toIso8601String(),
      'status': 'Pending',
      'totalAmount': totalPrice.value,
      'deliveryOption': selectedDeliveryOption.value,
      'paymentMethod': selectedPaymentMethod.value, // حفظ طريقة الدفع في الأوردر
      'shippingAddress': {
        'street1': street1Controller.text.trim(),
        'city': cityController.text.trim(),
        'country': countryController.text.trim(),
      }
    };

    try {
      await _ordersRemoteDataSource.processCheckout(
          orderData: orderData,
          products: cartProducts,
          clearCartCallback: (batch) {
            _cartRepository.clearRemoteCartBeforeCommit(batch);
          }
      );
      await _cartRepository.clearLocalCartAfterCheckout();

      cartProducts.clear();
      totalPrice.value = 0.0;
      activeStep.value = 0;

      Get.snackbar(
        'Success',
        'Order Placed Successfully & Cart Cleared! 🎉',
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(15),
      );

      Get.offAllNamed(AppRoutes.profile);

    } catch (e) {
      Get.snackbar('Error', 'Failed to complete order: $e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }
  Future<void> getLocalCarts() async {
    final result = await _cartRepository.getLocalCarts();
    result.when(
        success: (data) {
          cartProducts.value = data;
          calculateTotalPrice();
        },
        failure: (error) {
          errorMessage.value = NetworkExceptions.getErrorMessage(error);
        });
  }

  @override
  void onClose() {
    street1Controller.dispose();
    street2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.onClose();
  }
}