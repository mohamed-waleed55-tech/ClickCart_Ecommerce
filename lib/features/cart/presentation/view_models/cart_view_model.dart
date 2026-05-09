import 'dart:ffi';

import 'package:ecommerce_app/features/cart/model/firestore_product.dart';
import 'package:get/get.dart';

import '../../../authentication/data/user_repository/user_repositroy.dart';
import '../../../home/data/products_repository/api_result.dart';
import '../../../home/data/products_repository/products_repository.dart';

class CartViewModel extends GetxController {
  final UserRepository _userRepository;
  final ProductsRepository _productsRepository;

  CartViewModel(this._userRepository, this._productsRepository);

  RxList<FirestoreProduct> cartProducts = <FirestoreProduct>[].obs;
  RxBool isLoading = false.obs;
  RxString error = "".obs;
  RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCartProducts();
    calculateTotalPrice();
    ever(cartProducts, (_) {
      calculateTotalPrice();
    });
  }


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

    // تحديث القيمة النهائية
    totalPrice.value = total;
  }

  void getCartProducts() async {
    isLoading.value = true;
    var result = await _userRepository.getCartProducts();
    result.when(
      success: (data) {
        print("////////////////////////////////////////////////");
        print("Cart Products: ${data.length}");

        cartProducts.assignAll(data);
        isLoading.value = false;
      },
      failure: (networkExceptions) {
        isLoading.value = false;
        error.value = networkExceptions.toString();
      },
    );
  }
}
