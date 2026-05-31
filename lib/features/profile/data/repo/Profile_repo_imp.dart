import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/platform_interface/platform_interface_index_definitions.dart';
import 'package:ecommerce_app/features/authentication/model/user_model.dart';
import 'package:ecommerce_app/features/checkout/model/order.dart';
import 'package:ecommerce_app/features/home/data/api_error_handling/network_exceptions.dart';
import 'package:ecommerce_app/features/profile/data/repo/profile_repo.dart';
import 'package:ecommerce_app/features/profile/models/profile_result_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepoImp extends ProfileRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProfileRepoImp(this._firestore, {required FirebaseAuth auth}) : _auth = auth;

  String get userId => _auth.currentUser?.uid ?? '';

  @override
  Future<UserModel> fetchUserDataFromFirebase() async {

    final data = await _firestore.collection('users').doc(userId).get();
    return UserModel.fromJson(data.data()!);
  }

  @override
  Future<ProfileResultState<List<OrderModel>>> getOrders() async {
    try {
      final data = await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .get();
      final orders = data.docs
          .map((e) => OrderModel.fromJson(e.data()))
          .toList();
      return ProfileResultState.success(orders);
    } catch (e) {
      return ProfileResultState.error(NetworkExceptions.getDioException(e));
    }
  }
}
