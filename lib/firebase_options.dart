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
    apiKey: 'AIzaSyCxplFFXEGOwDhtcfKdrvZx3Idj8WSUzLY',
    appId: '1:894211483765:web:d925e2b47c257cb016b03c',
    messagingSenderId: '894211483765',
    projectId: 'cardsparty-dev',
    authDomain: 'cardsparty-dev.firebaseapp.com',
    databaseURL: 'https://cardsparty-dev.firebaseio.com',
    storageBucket: 'cardsparty-dev.appspot.com',
    measurementId: 'G-MPFFYW9TBC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS5vzJvT9SK0ALgaI6AdhK-jSYD0_B0xY',
    appId: '1:894211483765:android:8c0b46f54bc1a3d016b03c',
    messagingSenderId: '894211483765',
    projectId: 'cardsparty-dev',
    databaseURL: 'https://cardsparty-dev.firebaseio.com',
    storageBucket: 'cardsparty-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcV5SQPDVx3XSua1t9VxiZHCAmoggTyjM',
    appId: '1:894211483765:ios:30bea1e0dd4489a616b03c',
    messagingSenderId: '894211483765',
    projectId: 'cardsparty-dev',
    databaseURL: 'https://cardsparty-dev.firebaseio.com',
    storageBucket: 'cardsparty-dev.appspot.com',
    iosClientId: '894211483765-h5ovd4h9holkir0u60lj969su88h54pe.apps.googleusercontent.com',
    iosBundleId: 'com.example.verygoodcore.cards-party',
  );
}
