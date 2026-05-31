import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authentication/model/user_model.dart';
import 'package:ecommerce_app/features/checkout/model/order.dart';

import '../../models/profile_result_state.dart';

abstract class ProfileRepo{
  Future<ProfileResultState<List<OrderModel>>>getOrders();
  Future<UserModel>fetchUserDataFromFirebase();
}

