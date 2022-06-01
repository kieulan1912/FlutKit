import 'dart:developer';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutkit_feature/features/firebase/views/login_screen.dart';
import 'package:flutkit_feature/features/firebase/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class UserController extends FxController {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  UserController() {
    save = false;
    initUserData();
  }

  Future<void> initUserData() async {
    loading = true;
    update();

    user = auth.currentUser;
    update();

    loading = false;
    update();
  }

  void goToLogin() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FirebaseLoginScreen(),
      ),
    );
  }

  void goToRegister() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FirebaseRegisterScreen(),
      ),
    );
  }

  void logout() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FirebaseLoginScreen()));
  }

  @override
  String getTag() {
    return "user_controller";
  }
}
