import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => macos,
      TargetPlatform.windows => windows,
      TargetPlatform.linux => linux,
      _ => throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        ),
    };
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'REPLACE_WITH_FIREBASE_WEB_API_KEY',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'careloop-placeholder',
    authDomain: 'careloop-placeholder.firebaseapp.com',
    storageBucket: 'careloop-placeholder.appspot.com',
    measurementId: 'G-REPLACEWEBID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REPLACE_WITH_FIREBASE_API_KEY',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'careloop-placeholder',
    storageBucket: 'careloop-placeholder.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_WITH_FIREBASE_IOS_API_KEY',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'careloop-placeholder',
    storageBucket: 'careloop-placeholder.appspot.com',
    iosBundleId: 'com.careloop.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'REPLACE_WITH_FIREBASE_MACOS_API_KEY',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'careloop-placeholder',
    storageBucket: 'careloop-placeholder.appspot.com',
    iosBundleId: 'com.careloop.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'REPLACE_WITH_FIREBASE_WINDOWS_API_KEY',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'careloop-placeholder',
    authDomain: 'careloop-placeholder.firebaseapp.com',
    storageBucket: 'careloop-placeholder.appspot.com',
    measurementId: 'G-REPLACEWINDOWSID',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'REPLACE_WITH_FIREBASE_LINUX_API_KEY',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'careloop-placeholder',
    authDomain: 'careloop-placeholder.firebaseapp.com',
    storageBucket: 'careloop-placeholder.appspot.com',
    measurementId: 'G-REPLACELINUXID',
  );
}
