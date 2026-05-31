import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/features/cart/model/firestore_product.dart';
import 'package:get/get.dart';

import '../../../home/data/api_error_handling/network_exceptions.dart';
import '../../../home/model/api_response/product_model.dart';
import '../../data/cart_repository/cart_repository.dart';
import 'package:ecommerce_app/features/cart/model/firestore_result.dart';

import '../../data/sync_manager/sync_manager.dart';

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

      // 1. Snappy UI: Update the local reactive state immediately
      cartProducts[index] = cartProducts[index]..quantity = newQuantity;
      cartProducts.refresh(); // Tells Obx widgets to redraw right now

      // 2. Persist to local database and mark as un-synced (isSynced = 0)
      await _cartRepository.updateCartItemQuantity(product.id!, newQuantity);

      // 3. Sync immediately to Firestore if online
      _triggerRemoteSyncIfOnline();
    }
  }

  void decreaseQuantity(FirestoreProduct product) async {
    final index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      int currentQuantity = cartProducts[index].quantity ?? 1;
      if (currentQuantity > 1) {
        int newQuantity = currentQuantity - 1;

        // 1. Snappy UI Update
        cartProducts[index] = cartProducts[index]..quantity = newQuantity;
        cartProducts.refresh();

        // 2. Persist locally
        await _cartRepository.updateCartItemQuantity(product.id!, newQuantity);

        // 3. Sync if online
        _triggerRemoteSyncIfOnline();
      } else {
        removeProductFromCart(product);
      }
    }
  }

  void removeProductFromCart(FirestoreProduct product) async {
    // 1. Instant UI update
    cartProducts.removeWhere((element) => element.id == product.id);

    // 2. Update local database (Delete local row or mark as deleted if tracking offline deletions)
    await _cartRepository.removeProductFromCart(product.id!);

    // 3. Attempt remote removal if online
    _triggerRemoteSyncIfOnline();
  }

  void _triggerRemoteSyncIfOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool isOnline = connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);

    if (isOnline) {
      // invoke its synchronization routine immediately.
      if (Get.isRegistered<CartSyncManager>()) {
        Get.find<CartSyncManager>().syncLocalCartToFirestore();
      }
    }
    // Note: If offline, we safely do nothing.
    // The CartSyncManager's listener will catch it the second they get network back.
  }

  void addProductToCart(ProductModel product) async {
    FirestoreProduct firestoreProduct = FirestoreProduct(
      id: product.id,
      title: product.title,
      price: product.price,
      stock: product.stock,
      image: product.thumbnail,
      discountPercentage: product.discountPercentage,
      quantity: 1,
    );

    final index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      int newQty = (cartProducts[index].quantity ?? 1) + 1;
      cartProducts[index] = cartProducts[index]..quantity = newQty;
      cartProducts.refresh();
    } else {
      cartProducts.add(firestoreProduct);
    }

    try {
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