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
    apiKey: 'AIzaSyCpW3uBvemSwJ1uMjIF6uik2JCErXxrCsg',
    appId: '1:590621437679:web:3c4d2b0bbcb44534fb751a',
    messagingSenderId: '590621437679',
    projectId: 'trilo-18d4c',
    authDomain: 'trilo-18d4c.firebaseapp.com',
    storageBucket: 'trilo-18d4c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnmCH40wgmf6HNnnygczHhyc60UCf9Ir8',
    appId: '1:590621437679:android:1e5ce76bd8e9f835fb751a',
    messagingSenderId: '590621437679',
    projectId: 'trilo-18d4c',
    storageBucket: 'trilo-18d4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBI2uAqX7k-VeY4Dk0SOHka7Z6qDDzPpig',
    appId: '1:590621437679:ios:9113a6b5a359dd99fb751a',
    messagingSenderId: '590621437679',
    projectId: 'trilo-18d4c',
    storageBucket: 'trilo-18d4c.appspot.com',
    androidClientId: '590621437679-jvu70dch52bpo866flqtopdqedaimvsd.apps.googleusercontent.com',
    iosClientId: '590621437679-12pau5fts2jb7gg4vt1jl4sphhj5k8sf.apps.googleusercontent.com',
    iosBundleId: 'com.markappghana.triloAdmin',
  );
}
