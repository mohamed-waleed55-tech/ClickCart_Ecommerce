import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authentication/model/user_model.dart';
import 'package:ecommerce_app/features/checkout/model/order.dart';
import 'package:ecommerce_app/features/home/data/api_error_handling/network_exceptions.dart';
import 'package:ecommerce_app/features/profile/data/repo/profile_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepoImp extends ProfileRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProfileRepoImp(
    this._firestore, {
    required FirebaseAuth auth,
  }) : _auth = auth;

  String get userId => _auth.currentUser?.uid ?? '';

  // ============================================================
  // USER
  // ============================================================

  @override
  Future<UserModel> fetchUserDataFromFirebase() async {
    if (userId.isEmpty) {
      throw Exception('User is not logged in');
    }

    final data = await _firestore
        .collection('users')
        .doc(userId)
        .get();

    if (!data.exists || data.data() == null) {
      throw Exception('User data not found');
    }

    return UserModel.fromJson(data.data()!);
  }

  @override
  Future<void> updateUserDataInFirebase(UserModel user) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User is not logged in');
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .update(user.toJson());
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }


@override
Future<List<OrderModel>> getOrders() async {
  try {
    if (userId.isEmpty) {
      throw Exception('User is not logged in');
    }

    final data = await _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .get();

    final orders = data.docs
        .map(
          (doc) => OrderModel.fromJson({
            ...doc.data(),
            'id': doc.id,
          }),
        )
        .toList();

    print('Fetched ${orders.length} orders for user $userId');

    return orders;
  } catch (e) {
    print('Error fetching orders for user $userId: $e');
    throw NetworkExceptions.getDioException(e);
  }
}



  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User is not logged in');
      }

      if (orderId.isEmpty) {
        throw Exception('Order ID cannot be empty');
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }



  @override
  Future<void> cancelOrder({
    required String orderId,
  }) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User is not logged in');
      }

      if (orderId.isEmpty) {
        throw Exception('Order ID cannot be empty');
      }

      final orderRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId);

      final orderSnapshot = await orderRef.get();

      if (!orderSnapshot.exists) {
        throw Exception('Order not found');
      }

      final data = orderSnapshot.data();

      final currentStatus =
          data?['status']?.toString().toLowerCase() ?? '';

      if (currentStatus == 'delivered') {
        throw Exception(
          'Delivered orders cannot be cancelled',
        );
      }

      if (currentStatus == 'cancelled') {
        throw Exception(
          'Order is already cancelled',
        );
      }

      await orderRef.update({
        'status': 'cancelled',
        'cancelledAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
  print('❌ Cancel order error: $e');
    

  if (e is FirebaseException) {
    print('Firebase code: ${e.code}');
    print('Firebase message: ${e.message}');
  }

  rethrow;
}
  }
}