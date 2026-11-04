import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/provider_observer.dart';
import '../../core/firebase/firebase_crashlytics_service.dart';
import '../../firebase_options.dart';
import '../care_loop_app.dart';

Future<void> bootstrap() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await FirebaseCrashlyticsService.configure();

      runApp(
        ProviderScope(
          observers: kDebugMode ? [CareLoopProviderObserver()] : const [],
          child: const CareLoopApp(),
        ),
      );
    },
    (error, stackTrace) {
      FirebaseCrashlyticsService.recordError(error, stackTrace);
    },
  )!;
}
