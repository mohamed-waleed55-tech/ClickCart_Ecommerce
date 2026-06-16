import 'dart:ui';

import 'package:ecommerce_app/core/networking/crashlytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'core/database/local_storage_service.dart';
import 'features/ecommerce_app.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await GetStorage.init();
    await CrashlyticsService.initialize();

    FlutterError.onError = CrashlyticsService.handleFlutterError;
    PlatformDispatcher.instance.onError = CrashlyticsService.handleAsyncError;
  } catch (e) {
    debugPrint("Firebase/Storage Init Error: $e");
  }

  bool showOnboarding = true;

  try {
    final storageService = LocalStorageService();
    showOnboarding = storageService.isFirstTime();
  } catch (e) {
    debugPrint("LocalStorage Error (After Crash): $e");
  }

  runApp(EcommerceApp(showOnboarding: showOnboarding));
}