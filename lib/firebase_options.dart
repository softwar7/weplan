// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDdCO5gfLVmwMcjfvjqu_Pq4MapuSBHZQ8',
    appId: '1:816651436901:web:3edc006cac694d140e978c',
    messagingSenderId: '816651436901',
    projectId: 'weplan-fire',
    authDomain: 'weplan-fire.firebaseapp.com',
    storageBucket: 'weplan-fire.appspot.com',
    measurementId: 'G-3900Q7DTYS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIMXA-lNHuMNNTYxFY4WGUq-N-kVLiEQg',
    appId: '1:816651436901:android:394f7cda31733afd0e978c',
    messagingSenderId: '816651436901',
    projectId: 'weplan-fire',
    storageBucket: 'weplan-fire.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5jpbWqA1kMuDLcfwiMPmGZz3XKsPNc70',
    appId: '1:816651436901:ios:b63c9487474265c10e978c',
    messagingSenderId: '816651436901',
    projectId: 'weplan-fire',
    storageBucket: 'weplan-fire.appspot.com',
    iosBundleId: 'com.parkjb.weplan',
  );
}
