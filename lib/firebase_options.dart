// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAMMqAKFECK9zOl7d8JlzvSafhkqPB-1BE',
    appId: '1:423629510566:web:2fb78aac82458d9334e167',
    messagingSenderId: '423629510566',
    projectId: 'mapg-58e95',
    authDomain: 'mapg-58e95.firebaseapp.com',
    storageBucket: 'mapg-58e95.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXkQlu_uONyfvYDUAVJop4_k559dIFWO0',
    appId: '1:423629510566:android:3569386404c4102c34e167',
    messagingSenderId: '423629510566',
    projectId: 'mapg-58e95',
    storageBucket: 'mapg-58e95.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3AMFRdf59oLjsrIMkaZ4L8SQ57GX4vDA',
    appId: '1:423629510566:ios:8e78be530e1c332234e167',
    messagingSenderId: '423629510566',
    projectId: 'mapg-58e95',
    storageBucket: 'mapg-58e95.firebasestorage.app',
    iosBundleId: 'com.example.gmap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3AMFRdf59oLjsrIMkaZ4L8SQ57GX4vDA',
    appId: '1:423629510566:ios:8e78be530e1c332234e167',
    messagingSenderId: '423629510566',
    projectId: 'mapg-58e95',
    storageBucket: 'mapg-58e95.firebasestorage.app',
    iosBundleId: 'com.example.gmap',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAMMqAKFECK9zOl7d8JlzvSafhkqPB-1BE',
    appId: '1:423629510566:web:242a469855b4524d34e167',
    messagingSenderId: '423629510566',
    projectId: 'mapg-58e95',
    authDomain: 'mapg-58e95.firebaseapp.com',
    storageBucket: 'mapg-58e95.firebasestorage.app',
  );
}
