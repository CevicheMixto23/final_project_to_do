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
    apiKey: 'AIzaSyCZNHEXOxJ_7votFapAAB7WQgSuFeYOLIQ',
    appId: '1:34022834712:web:4a860f2e7771a784b0f96d',
    messagingSenderId: '34022834712',
    projectId: 'to-do-app-19903',
    authDomain: 'to-do-app-19903.firebaseapp.com',
    storageBucket: 'to-do-app-19903.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCySSV11RmCgubh9G-4yVHLgHJ0lZgR8Ew',
    appId: '1:34022834712:android:28cd55944c450dfdb0f96d',
    messagingSenderId: '34022834712',
    projectId: 'to-do-app-19903',
    storageBucket: 'to-do-app-19903.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuM3E-rt8ENVgleCXvWD_VPKQMRJNjitE',
    appId: '1:34022834712:ios:b067f41fa0ff2c8eb0f96d',
    messagingSenderId: '34022834712',
    projectId: 'to-do-app-19903',
    storageBucket: 'to-do-app-19903.appspot.com',
    iosBundleId: 'com.example.finalProjectToDo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuM3E-rt8ENVgleCXvWD_VPKQMRJNjitE',
    appId: '1:34022834712:ios:b067f41fa0ff2c8eb0f96d',
    messagingSenderId: '34022834712',
    projectId: 'to-do-app-19903',
    storageBucket: 'to-do-app-19903.appspot.com',
    iosBundleId: 'com.example.finalProjectToDo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCZNHEXOxJ_7votFapAAB7WQgSuFeYOLIQ',
    appId: '1:34022834712:web:1ca56c0e9f96a9f2b0f96d',
    messagingSenderId: '34022834712',
    projectId: 'to-do-app-19903',
    authDomain: 'to-do-app-19903.firebaseapp.com',
    storageBucket: 'to-do-app-19903.appspot.com',
  );
}
