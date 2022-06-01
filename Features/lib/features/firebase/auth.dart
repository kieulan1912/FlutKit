/*
*  (I am already added dummy google-services file but if you use in production
*  than create your project in firebase and get it from there.
* */

/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for firebase
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/

/* For Android
 * Reference : https://firebase.google.com/docs/flutter/setup?platform=android
 * Add google-services.json
 */

/* For iOS
 * Reference : https://firebase.google.com/docs/flutter/setup?platform=ios
 * Add GoogleService-Info.plist
 */

/*
* Make sure all steps you follow as references
* Then enable email/password authentication in your project at https://console.firebase.google.com/
* */

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final String emailAlreadyInUse = "email-already-in-use";
  static final String weakPassword = "weak-password";
  static final String wrongPassword = "wrong-password";
  static final String invalidEmail = "invalid-email";
  static final String userNotFound = "user-not-found";
}
