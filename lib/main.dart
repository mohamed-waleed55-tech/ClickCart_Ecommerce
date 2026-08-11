import 'dart:ui';

import 'package:device_frame/device_frame.dart'; 
import 'package:ecommerce_app/core/networking/crashlytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

import 'core/database/local_storage_service.dart';
import 'features/ecommerce_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
    fileName: ".env",
  );
   print(dotenv.env['GEMINI_API_KEY']);



  if (!kIsWeb) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await CrashlyticsService.initialize();
      FlutterError.onError = CrashlyticsService.handleFlutterError;
      PlatformDispatcher.instance.onError = CrashlyticsService.handleAsyncError;
    } catch (e) {
      debugPrint("Firebase/Storage Init Error: $e");
    }
  }

  try {
    await GetStorage.init();
  } catch (e) {
    debugPrint("GetStorage Init Error: $e");
  }

  bool showOnboarding = true;
  try {
    final storageService = LocalStorageService();
    showOnboarding = storageService.isFirstTime();
  } catch (e) {
    debugPrint("LocalStorage Error: $e");
  }

  final Widget mainApp = EcommerceApp(showOnboarding: showOnboarding);

  if (kIsWeb) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF1E1E2C),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: DeviceFrame(
                  device: Devices.ios.iPhone13ProMax,
                  isFrameVisible: true,
                  orientation: Orientation.portrait,
                  screen: mainApp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  } else {
    runApp(mainApp);
  }
}
