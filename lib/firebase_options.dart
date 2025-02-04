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
    apiKey: 'AIzaSyDB2BftwyuyDbbCYO5SY8dhgzirWBtmwhE',
    appId: '1:903629943765:web:507887db384da670a0435c',
    messagingSenderId: '903629943765',
    projectId: 'flutterproject-c09e2',
    authDomain: 'flutterproject-c09e2.firebaseapp.com',
    databaseURL: 'https://flutterproject-c09e2-default-rtdb.firebaseio.com',
    storageBucket: 'flutterproject-c09e2.firebasestorage.app',
    measurementId: 'G-HCNY2LWGVC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDla55omOUPWTvEBp6XGjHDhSJkp6pu08',
    appId: '1:903629943765:android:d66b110a48ab69dea0435c',
    messagingSenderId: '903629943765',
    projectId: 'flutterproject-c09e2',
    databaseURL: 'https://flutterproject-c09e2-default-rtdb.firebaseio.com',
    storageBucket: 'flutterproject-c09e2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwf0s1eFKUgEmJrGrhXkV5r1WMvjl6V_0',
    appId: '1:903629943765:ios:9cc96730a09d4587a0435c',
    messagingSenderId: '903629943765',
    projectId: 'flutterproject-c09e2',
    databaseURL: 'https://flutterproject-c09e2-default-rtdb.firebaseio.com',
    storageBucket: 'flutterproject-c09e2.firebasestorage.app',
    iosBundleId: 'com.example.flutterproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwf0s1eFKUgEmJrGrhXkV5r1WMvjl6V_0',
    appId: '1:903629943765:ios:9cc96730a09d4587a0435c',
    messagingSenderId: '903629943765',
    projectId: 'flutterproject-c09e2',
    databaseURL: 'https://flutterproject-c09e2-default-rtdb.firebaseio.com',
    storageBucket: 'flutterproject-c09e2.firebasestorage.app',
    iosBundleId: 'com.example.flutterproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDB2BftwyuyDbbCYO5SY8dhgzirWBtmwhE',
    appId: '1:903629943765:web:cc94ebd7fa6c3af9a0435c',
    messagingSenderId: '903629943765',
    projectId: 'flutterproject-c09e2',
    authDomain: 'flutterproject-c09e2.firebaseapp.com',
    databaseURL: 'https://flutterproject-c09e2-default-rtdb.firebaseio.com',
    storageBucket: 'flutterproject-c09e2.firebasestorage.app',
    measurementId: 'G-SFCDDPGV0Z',
  );
}
