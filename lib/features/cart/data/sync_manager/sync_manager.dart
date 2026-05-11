import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../core/database/database_helper.dart';
import '../../model/firestore_product.dart';

class CartSyncManager extends GetxService {
  final DatabaseHelper _dbHelper;
  final FirebaseFirestore _firestore;

  CartSyncManager(this._dbHelper, this._firestore);
  @override
  void onInit() {
    super.onInit();
    startMonitoring();
  }


  void startMonitoring() {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.mobile)) {
        syncLocalCartToFirestore();
      }
    });
  }

  Future<void> syncLocalCartToFirestore() async {
    try {
      List<FirestoreProduct> unSyncedItems = await _dbHelper
          .getUnSyncedProducts();

      if (unSyncedItems.isEmpty) {
        print("السلة نظيفة ومتزامنة ومفيش حاجة تترفع.");
        return;
      }

      String userId = FirebaseAuth.instance.currentUser!.uid;
      final userCartRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('cart');

      for (var item in unSyncedItems) {
        if (item.id == null) continue;

        await userCartRef.doc(item.id.toString()).set(item.toJson());

        await _dbHelper.updateIsSynced(item.id!);
        print("تمت مزامنة المنتج [${item.title}] وحفظه في السيرفر!");

      }
    } catch (e) {
      print("حصل مشكلة وأنا برفع الداتا: $e");
    }
  }
}
