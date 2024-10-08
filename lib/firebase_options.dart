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
    apiKey: 'AIzaSyAVCBPJY8SzNw4QzXt_XZLNicaz73j9qAE',
    appId: '1:417056880358:web:b91396bbe6148476176d27',
    messagingSenderId: '417056880358',
    projectId: 'chatapp-547a7',
    authDomain: 'chatapp-547a7.firebaseapp.com',
    storageBucket: 'chatapp-547a7.appspot.com',
    measurementId: 'G-F7H3KEWVTN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyvfqlz_74eE4dG5f1aiMaupZfB6kRIFs',
    appId: '1:417056880358:android:08133d9457e7d9ca176d27',
    messagingSenderId: '417056880358',
    projectId: 'chatapp-547a7',
    storageBucket: 'chatapp-547a7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByGY7bOIouU8tlgkqdh4OwgqgMbYiwosM',
    appId: '1:417056880358:ios:cbf21d39e1a19699176d27',
    messagingSenderId: '417056880358',
    projectId: 'chatapp-547a7',
    storageBucket: 'chatapp-547a7.appspot.com',
    iosBundleId: 'com.example.talkTn',
  );
}
