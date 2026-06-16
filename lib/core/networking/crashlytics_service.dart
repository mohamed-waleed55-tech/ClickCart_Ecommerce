import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static Future<void> initialize() async {
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }

  static void handleFlutterError(FlutterErrorDetails errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  }

  static bool handleAsyncError(Object error, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  }
}