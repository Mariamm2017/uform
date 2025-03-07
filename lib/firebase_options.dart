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
    apiKey: 'AIzaSyAzfpUPT1UfFvCyRId0GCZsdu_AY66DLvs',
    appId: '1:892785645735:web:e814868e442159be9c2382',
    messagingSenderId: '892785645735',
    projectId: 'userform-41560',
    authDomain: 'userform-41560.firebaseapp.com',
    databaseURL: 'https://userform-41560-default-rtdb.firebaseio.com',
    storageBucket: 'userform-41560.firebasestorage.app',
    measurementId: 'G-0RZZQQ3Z2W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBI997UAsEaEexxCsNTqQ4sfOrP3Nnoi6I',
    appId: '1:892785645735:android:e8a90fbb8dfd25719c2382',
    messagingSenderId: '892785645735',
    projectId: 'userform-41560',
    databaseURL: 'https://userform-41560-default-rtdb.firebaseio.com',
    storageBucket: 'userform-41560.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0xOee_iDzqS_ShEZMnC4SPtbdBos-K4w',
    appId: '1:892785645735:ios:a901d24942904d4f9c2382',
    messagingSenderId: '892785645735',
    projectId: 'userform-41560',
    databaseURL: 'https://userform-41560-default-rtdb.firebaseio.com',
    storageBucket: 'userform-41560.firebasestorage.app',
    iosBundleId: 'com.example.uForm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0xOee_iDzqS_ShEZMnC4SPtbdBos-K4w',
    appId: '1:892785645735:ios:a901d24942904d4f9c2382',
    messagingSenderId: '892785645735',
    projectId: 'userform-41560',
    databaseURL: 'https://userform-41560-default-rtdb.firebaseio.com',
    storageBucket: 'userform-41560.firebasestorage.app',
    iosBundleId: 'com.example.uForm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAzfpUPT1UfFvCyRId0GCZsdu_AY66DLvs',
    appId: '1:892785645735:web:7c41edea37a730ed9c2382',
    messagingSenderId: '892785645735',
    projectId: 'userform-41560',
    authDomain: 'userform-41560.firebaseapp.com',
    databaseURL: 'https://userform-41560-default-rtdb.firebaseio.com',
    storageBucket: 'userform-41560.firebasestorage.app',
    measurementId: 'G-4H1BXM13BR',
  );
}
