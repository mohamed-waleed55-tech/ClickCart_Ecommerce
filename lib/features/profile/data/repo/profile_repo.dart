import 'package:ecommerce_app/features/authentication/model/user_model.dart';
import 'package:ecommerce_app/features/checkout/model/order.dart';

abstract class ProfileRepo {
  Future<UserModel> fetchUserDataFromFirebase();

  Future<List<OrderModel>> getOrders();

  Future<void> updateUserDataInFirebase(UserModel user);

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  });

  Future<void> cancelOrder({
    required String orderId,
  });
}