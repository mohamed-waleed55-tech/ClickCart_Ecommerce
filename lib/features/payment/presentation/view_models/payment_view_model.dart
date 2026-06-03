import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authentication/model/user_model.dart';
import 'package:ecommerce_app/features/payment/data/payment_repository/payment_service_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/constant/payment_constants.dart';
import '../../../home/data/products_repository/api_result.dart';
import '../screens/card_payment_webview.dart';
import '../screens/kiosk_payment_view.dart';

class PaymentController extends GetxController {
  final PaymentServiceRepo _paymentServiceRepo;
  final FirebaseFirestore _firestore;

  PaymentController(this._paymentServiceRepo, this._firestore);

  var isLoading = false.obs;

  String authToken = "";
  String orderId = "";
  String cardPaymentToken = "";
  String kioskPaymentToken = "";
  String kioskPaymentRef = "";

  String get cardIFrameUrl =>
      "https://accept.paymob.com/api/acceptance/iframes/$cardIFrameId?payment_token=$cardPaymentToken";

  Future<Map<String, dynamic>> getUserBillingData(String userId) async {
    try {
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        final userModel =
        UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

        return {
          "apartment": "NA",
          "email": userModel.email.isNotEmpty
              ? userModel.email
              : (FirebaseAuth.instance.currentUser?.email ?? "test@example.com"),
          "floor": "NA",
          "first_name": userModel.fName.isNotEmpty
              ? userModel.fName
              : userModel.name.split(" ").first,
          "street": "NA",
          "building": "NA",
          "phone_number": userModel.phoneNumber.isNotEmpty
              ? userModel.phoneNumber
              : "+201025748598",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "Cairo",
          "country": "EGY",
          "last_name": userModel.lName.isNotEmpty ? userModel.lName : "User",
          "state": "NA",
        };
      }
    } catch (e) {
      print("Error fetching Firestore user data: $e");
    }

    return {
      "apartment": "NA",
      "email": FirebaseAuth.instance.currentUser?.email ?? "test@example.com",
      "floor": "NA",
      "first_name": "Customer",
      "street": "NA",
      "building": "NA",
      "phone_number": "+201025748598",
      "shipping_method": "NA",
      "postal_code": "NA",
      "city": "Cairo",
      "country": "EGY",
      "last_name": "User",
      "state": "NA",
    };
  }

  Future<void> startPaymentFlow({
    required String amountCents,
    required bool isCardPayment,
  }) async {
    try {
      isLoading.value = true;

      final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
      final billingData = await getUserBillingData(currentUserId);

      final authResult = await _paymentServiceRepo.getAuthToken(
        apiKeyBody: authTokenBody,
      );

      authResult.when(
        success: (response) {
          authToken = response.data?['token'] ?? "";
        },
        failure: (error) {
          throw Exception("The error in getting Auth Token$error");
        },
      );

      if (authToken.isEmpty) return;

      final dynamicOrderBody = {
        "auth_token": authToken,
        "delivery_needed": "false",
        "amount_cents": amountCents,
        "currency": "EGP",
        "items": [],
      };

      final orderResult = await _paymentServiceRepo.getOrderId(
        orderBody: dynamicOrderBody,
      );

      orderResult.when(
        success: (response) {
          orderId = response.data?['id'].toString() ?? "";
        },
        failure: (error) {
          throw Exception(" Error in getting Order ID: $error");
        },
      );

      if (orderId.isEmpty) return;

      final targetIntegrationId =
      isCardPayment ? cardIntegrationId : kioskIntegrationId;

      final dynamicPaymentKeyBody = {
        "auth_token": authToken,
        "amount_cents": amountCents,
        "expiration": 3600,
        "order_id": orderId,
        "billing_data": billingData,
        "currency": "EGP",
        "integration_id": targetIntegrationId,
        "lock_order_when_paid": "false",
      };

      final paymentKeyResult = await _paymentServiceRepo.getPaymentKey(
        paymentKeyBody: dynamicPaymentKeyBody,
      );

      paymentKeyResult.when(
        success: (response) {
          if (isCardPayment) {
            cardPaymentToken = response.data?['token'] ?? "";
          } else {
            kioskPaymentToken = response.data?['token'] ?? "";
          }
        },
        failure: (error) {
          throw Exception("Error in getting Payment Key : $error");
        },
      );

      if (isCardPayment && cardPaymentToken.isNotEmpty) {
        Get.to(
              () => CardPaymentWebView(
            url: cardIFrameUrl,
          ),
        );
      } else if (!isCardPayment && kioskPaymentToken.isNotEmpty) {
        final dynamicKioskBody = {
          "source": {
            "identifier": "AGGREGATOR",
            "subtype": "AGGREGATOR",
          },
          "payment_token": kioskPaymentToken,
        };

        final kioskResult = await _paymentServiceRepo.executePayment(
          paymentBody: dynamicKioskBody,
        );

        kioskResult.when(
          success: (response) {
            final data = response.data ?? {};

            kioskPaymentRef =
                data['data']?['bill_reference']?.toString() ??
                    data['id']?.toString() ??
                    "";

            if (kioskPaymentRef.isEmpty) {
              throw Exception("Error in getting Kiosk Payment Reference");
            }

            Get.to(
                  () => KioskPaymentView(
                referenceCode: kioskPaymentRef,
              ),
            );
          },
          failure: (error) {
            throw Exception(" Error in executing Payment: $error");
          },
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception:", ""),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}