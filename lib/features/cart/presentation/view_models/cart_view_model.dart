import 'package:ecommerce_app/features/cart/model/firestore_product.dart';
import 'package:get/get.dart';

import '../../../home/data/api_error_handling/network_exceptions.dart';
import '../../../home/model/api_response/product_model.dart';
import '../../data/cart_repository/cart_repository.dart';
import 'package:ecommerce_app/features/cart/model/firestore_result.dart';

class CartViewModel extends GetxController {
  final CartRepository _cartRepository;

  CartViewModel(this._cartRepository);

  RxList<FirestoreProduct> cartProducts = <FirestoreProduct>[].obs;
  RxBool isLoading = false.obs;
  RxString error = "".obs;
  RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCartProducts();

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
    totalPrice.value = total;
  }

  void getCartProducts() async {
    if (cartProducts.isEmpty) {
      isLoading.value = true;
    }

    final localResult = await _cartRepository.getLocalCarts();

    localResult.when(
      success: (data) {
        cartProducts.assignAll(data);
        isLoading.value = false;

        _syncRemoteToLocalInBackground();
      },
      failure: (networkExceptions) {
        isLoading.value = false;
        error.value = networkExceptions.toString();
      },
    );
  }

  Future<void> _syncRemoteToLocalInBackground() async {
    final remoteResult = await _cartRepository.getRemoteCarts();

    remoteResult.when(
      success: (remoteProducts) async {
        if (remoteProducts.isNotEmpty) {
          for (var product in remoteProducts) {
            product.isSynced = 1;
            await _cartRepository.insertOrUpdateProduct(product);
          }

          final updatedLocal = await _cartRepository.getLocalCarts();
          updatedLocal.when(
            success: (newData) {
              cartProducts.assignAll(newData);
            },
            failure: (_) {},
          );
        }
      },
      failure: (networkExceptions) {
        print("📡 [Background Sync Info]: تعذر تحديث السلة من السيرفر حالياً (أوفلاين).");
      },
    );
  }

  void increaseQuantity(FirestoreProduct product) async {
    final index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      int newQuantity = (cartProducts[index].quantity ?? 1) + 1;
      cartProducts[index] = cartProducts[index]..quantity = newQuantity;
      cartProducts.refresh();
      await _cartRepository.updateCartItemQuantity(product.id!, newQuantity);
    }
  }

  void decreaseQuantity(FirestoreProduct product) async {
    final index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      int currentQuantity = cartProducts[index].quantity ?? 1;
      if (currentQuantity > 1) {
        int newQuantity = currentQuantity - 1;
        cartProducts[index] = cartProducts[index]..quantity = newQuantity;
        cartProducts.refresh();
        await _cartRepository.updateCartItemQuantity(product.id!, newQuantity);
      } else {
        removeProductFromCart(product);
      }
    }
  }

  void removeProductFromCart(FirestoreProduct product) async {
    cartProducts.removeWhere((element) => element.id == product.id);
    await _cartRepository.removeProductFromCart(product.id!);
  }

  // ✅ الدالة المحدثة والمثالية للإضافة الفورية وتحديث الـ UI
  void addProductToCart(ProductModel product) async {
    FirestoreProduct firestoreProduct = FirestoreProduct(
      id: product.id,
      title: product.title,
      price: product.price.toString(),
      stock: product.stock.toString(),
      image: product.thumbnail,
      discountPercentage: product.discountPercentage,
      quantity: 1,
    );

    final index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      int newQty = (cartProducts[index].quantity ?? 1) + 1;
      cartProducts[index] = cartProducts[index]..quantity = newQty;
      cartProducts.refresh(); // إجبار الـ RxList على تحديث الـ UI
    } else {
      // منتج جديد، نضيفه مباشرة إلى القائمة الـ Reactive
      cartProducts.add(firestoreProduct);
    }

    try {
      // 2️⃣ إرسال الطلب وحفظه في الـ Database والسيرفر في الخلفية
      await _cartRepository.addProductToCart(firestoreProduct);
      Get.snackbar("Success", "Product added to cart successfully!");
    } catch (e, stackTrace) {
      print("🔴 Error in addProductToCart: $e");
      print("📌 StackTrace: $stackTrace");

      getCartProducts();

      final exception = NetworkExceptions.getDioException(e);
      final errorMessage = NetworkExceptions.getErrorMessage(exception);
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}