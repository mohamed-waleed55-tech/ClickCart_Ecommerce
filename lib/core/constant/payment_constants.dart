import 'package:firebase_auth/firebase_auth.dart';

const String apiKey =
    "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRFM01UY3pNeXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5IQVJoSzdRcmJNWjhPYURzd1U4eFBHeWFGMjBXQTFHTm9fOHBJS3RqencwcFZ1N0JUQ0VxbHBROU1hSjY3STJrM0Z0ZnFTMG9OZWVZdGZzZkpDSVNSZw==";
String authToken = "";
Map<String, dynamic> authTokenBody = {"api_key": apiKey};

String orderId = "";
Map<String, dynamic> orderBody = {
  "auth_token": authToken,
  "delivery_needed": "false",
  "amount_cents": "10000",
  "currency": "EGP",
  "items": [],
};


String cardPaymentToken = "";

Map<String, dynamic> cardPaymentKeyBody = {
  "auth_token": authToken,
  "amount_cents": "120000",
  "expiration": 3600,
  "order_id": "537910943",
  "billing_data": {
    "apartment": "NA",
    "email": "${FirebaseAuth.instance.currentUser!.email}",
    "floor": "NA",
    "first_name": "${FirebaseAuth.instance.currentUser!.displayName}",
    "street": "NA",
    "building": "NA",
    "phone_number": "+201025748598",
    "shipping_method": "NA",
    "postal_code": "NA",
    "city": "Cairo",
    "country": "EGY",
    "last_name": "Waleed",
    "state": "NA",
  },
  "currency": "EGP",
  "integration_id": "5698953",
  "lock_order_when_paid": "false",
};
String cardIntegrationId = "5693940";
String cardIFrameId = "1048800";
String cardIFrameUrl =
    "https://accept.paymob.com/api/acceptance/iframes/$cardIFrameId?payment_token=$cardPaymentToken";

String kioskIntegrationId = "5698953";
String kioskPaymentToken = "";
String kioskPaymentRef = "";

Map<String, dynamic> kioskPaymentBody = {
  "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
  "payment_token": kioskPaymentToken
};
