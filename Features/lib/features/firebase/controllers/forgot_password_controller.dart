import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutkit_feature/features/firebase/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class ForgotPasswordController extends FxController {
  late TextEditingController emailTE;
  GlobalKey<FormState> formKey = GlobalKey();

  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    this.emailTE = TextEditingController(text: 'flutkit@coderthemes.com');
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    } else if (FxStringValidator.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  Future<void> forgotPassword() async {
    loading = true;
    update();

    if (formKey.currentState!.validate()) {
      String email = emailTE.text;

      try {
        await auth.sendPasswordResetEmail(email: email);
        showSnackBar("Check Email. We sent you reset password link");
        Navigator.pop(context);
      } catch (e) {
        log(e.toString());
      }

      loading = false;
      update();
    }
    loading = false;
    update();
  }

  void goToRegisterScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FirebaseRegisterScreen(),
      ),
    );
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  String getTag() {
    return "forgot_password_controller";
  }
}
