import 'package:ecommerce_app/features/profile/data/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../authentication/data/auth_repository/auth_repositroy.dart';
import '../../../authentication/model/user_model.dart';
import '../../../checkout/model/order.dart';
import '../../../home/data/api_error_handling/network_exceptions.dart';

class ProfileViewModel extends GetxController {
  final AuthRepository _authRepository;
  final ProfileRepo _profileRepo;

  ProfileViewModel(
    this._authRepository,
    this._profileRepo,
  );

  // ============================================================
  // USER
  // ============================================================

  final Rxn<UserModel> user = Rxn<UserModel>();

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  // ============================================================
  // ORDERS
  // ============================================================

  final RxBool orderIsLoading = false.obs;

  final RxList<OrderModel> orders = <OrderModel>[].obs;

  /// Contains IDs of orders currently being cancelled.
  ///
  /// This is important because we DON'T want to show a global
  /// CircularProgressIndicator when cancelling one order.
  final RxSet<String> cancellingOrders = <String>{}.obs;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void onInit() {
    super.onInit();

    getUserData();
    fetchOrders();
  }

  // ============================================================
  // USER DATA
  // ============================================================

  Future<void> getUserData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userData =
          await _profileRepo.fetchUserDataFromFirebase();

      user.value = userData;
    } catch (e, stackTrace) {
      debugPrint('❌ Error fetching user data: $e');
      debugPrintStack(stackTrace: stackTrace);

      final exception =
          NetworkExceptions.getDioException(e);

      errorMessage.value =
          NetworkExceptions.getErrorMessage(exception);
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // SIGN OUT
  // ============================================================

  Future<void> signOut() async {
    try {
      isLoading.value = true;

      await _authRepository.signOut();

      Get.offAllNamed(AppRoutes.login);
    } catch (e, stackTrace) {
      debugPrint('❌ Sign out error: $e');
      debugPrintStack(stackTrace: stackTrace);

      final exception =
          NetworkExceptions.getDioException(e);

      final message =
          NetworkExceptions.getErrorMessage(exception);

      Get.snackbar(
        'Sign Out Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // FETCH ORDERS
  // ============================================================

  Future<void> fetchOrders() async {
    try {
      orderIsLoading.value = true;
      errorMessage.value = '';

      final List<OrderModel> fetchedOrders =
          await _profileRepo.getOrders();

      fetchedOrders.sort(
        (a, b) => b.orderDate.compareTo(a.orderDate),
      );

      orders.assignAll(fetchedOrders);

      debugPrint(
        '✅ Fetched ${orders.length} orders',
      );
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Error fetching orders: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      final exception =
          NetworkExceptions.getDioException(e);

      errorMessage.value =
          NetworkExceptions.getErrorMessage(exception);

      orders.clear();
    } finally {
      orderIsLoading.value = false;
    }
  }


  bool canCancelOrder(String status) {
    switch (status.trim().toLowerCase()) {
      case 'pending':
      case 'placed':
        return true;

      default:
        return false;
    }
  }

  // ============================================================
  // CHECK IF SPECIFIC ORDER IS CANCELLING
  // ============================================================

  bool isCancelling(String orderId) {
    return cancellingOrders.contains(orderId);
  }

  // ============================================================
  // CANCEL ORDER
  // ============================================================

  Future<void> cancelOrder(OrderModel order) async {
    // ----------------------------------------------------------
    // Prevent cancelling an invalid status
    // ----------------------------------------------------------

    if (!canCancelOrder(order.status)) {
      Get.snackbar(
        'Cannot Cancel',
        'This order can no longer be cancelled.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

      return;
    }

    // ----------------------------------------------------------
    // Prevent duplicate cancellation requests
    // ----------------------------------------------------------

    if (isCancelling(order.id)) {
      return;
    }

    // ----------------------------------------------------------
    // Confirmation dialog
    // ----------------------------------------------------------

    final confirmed = await _showCancelDialog();

    if (confirmed != true) {
      return;
    }

    final String orderId = order.id;

    try {
      // --------------------------------------------------------
      // Start loading ONLY for this order
      // --------------------------------------------------------

      cancellingOrders.add(orderId);

      debugPrint(
        '🔄 Cancelling order: $orderId',
      );

      // --------------------------------------------------------
      // Update Firebase
      // --------------------------------------------------------

      await _profileRepo.cancelOrder(
        orderId: orderId,
      );

      debugPrint(
        '✅ Order cancelled successfully: $orderId',
      );

      // --------------------------------------------------------
      // Update local list
      // --------------------------------------------------------

      final int index = orders.indexWhere(
        (element) => element.id == orderId,
      );

      if (index != -1) {
        final OrderModel oldOrder =
            orders[index];

        final OrderModel updatedOrder =
            OrderModel(
          id: oldOrder.id,
          orderDate: oldOrder.orderDate,
          status: 'Cancelled',
          totalAmount: oldOrder.totalAmount,
          deliveryOption: oldOrder.deliveryOption,
          shippingAddress:
              oldOrder.shippingAddress,
          items: oldOrder.items,
        );

        orders[index] = updatedOrder;

        orders.refresh();
      }

      // --------------------------------------------------------
      // Success message
      // --------------------------------------------------------

      Get.snackbar(
        'Order Cancelled',
        'Your order has been cancelled successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Error cancelling order: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      // --------------------------------------------------------
      // NetworkExceptions
      // --------------------------------------------------------

      final exception =
          NetworkExceptions.getDioException(e);

      final message =
          NetworkExceptions.getErrorMessage(exception);

      Get.snackbar(
        'Cancellation Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      // --------------------------------------------------------
      // ALWAYS remove loading for this order
      // --------------------------------------------------------

      cancellingOrders.remove(orderId);

      debugPrint(
        '🔵 Finished cancelling: $orderId',
      );
    }
  }

  // ============================================================
  // UPDATE ORDER STATUS
  // ============================================================

  Future<void> updateOrderStatus({
    required OrderModel order,
    required String status,
  }) async {
    try {
      orderIsLoading.value = true;

      await _profileRepo.updateOrderStatus(
        orderId: order.id,
        status: status,
      );

      final int index = orders.indexWhere(
        (element) => element.id == order.id,
      );

      if (index != -1) {
        final OrderModel oldOrder =
            orders[index];

        final OrderModel updatedOrder =
            OrderModel(
          id: oldOrder.id,
          orderDate: oldOrder.orderDate,
          status: status,
          totalAmount: oldOrder.totalAmount,
          deliveryOption: oldOrder.deliveryOption,
          shippingAddress:
              oldOrder.shippingAddress,
          items: oldOrder.items,
        );

        orders[index] = updatedOrder;

        orders.refresh();
      }

      Get.snackbar(
        'Order Updated',
        'Order status updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Error updating order: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      final exception =
          NetworkExceptions.getDioException(e);

      final message =
          NetworkExceptions.getErrorMessage(exception);

      Get.snackbar(
        'Update Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      orderIsLoading.value = false;
    }
  }

  // ============================================================
  // CANCEL DIALOG
  // ============================================================

  Future<bool?> _showCancelDialog() {
    return Get.dialog<bool>(
      AlertDialog(
        title: const Text(
          'Cancel Order',
        ),
        content: const Text(
          'Are you sure you want to cancel this order?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text(
              'No',
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text(
              'Yes, Cancel',
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // UPDATE PROFILE
  // ============================================================

  Future<void> updateProfile({
    required String fName,
    required String lName,
    required String phone,
  }) async {
    try {
      if (user.value == null) {
        Get.snackbar(
          'Error',
          'User information is not available.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;
      }

      isLoading.value = true;

      final UserModel updatedUser =
          user.value!.copyWith(
        fName: fName.trim(),
        lName: lName.trim(),
        phoneNumber: phone.trim(),
        name:
            '${fName.trim()} ${lName.trim()}',
      );

      await _profileRepo.updateUserDataInFirebase(
        updatedUser,
      );

      user.value = updatedUser;

      Get.back();

      Get.snackbar(
        'Success',
        'Profile updated successfully.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Error updating profile: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      final exception =
          NetworkExceptions.getDioException(e);

      final message =
          NetworkExceptions.getErrorMessage(exception);

      Get.snackbar(
        'Update Failed',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}