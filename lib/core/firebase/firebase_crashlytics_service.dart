import 'dart:async';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract final class FirebaseCrashlyticsService {
  static Future<void> configure() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      kReleaseMode,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      recordError(error, stackTrace, fatal: true);
      return true;
    };
  }

  static void recordError(
    Object error,
    StackTrace stackTrace, {
    bool fatal = false,
  }) {
    if (kReleaseMode) {
      unawaited(
        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          fatal: fatal,
        ),
      );
    } else {
      debugPrint('Unhandled error: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}
