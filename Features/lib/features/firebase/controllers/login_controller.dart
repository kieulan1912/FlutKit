import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutkit_feature/features/firebase/views/forgot_password_screen.dart';
import 'package:flutkit_feature/features/firebase/views/register_screen.dart';
import 'package:flutkit_feature/features/firebase/views/user_screen.dart';
import 'package:flutkit_feature/features/google_auth/google_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../auth.dart';

class LoginController extends FxController {
  late TextEditingController emailTE = TextEditingController();
  late TextEditingController passwordTE = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  GlobalKey<FormState> formKey = GlobalKey();

  bool loading = false;
  bool showPassword = false;

  LoginController() {
    save = false;
    this.emailTE = TextEditingController(text: 'flutkit@coderthemes.com');
    this.passwordTE = TextEditingController(text: 'password');
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    } else if (FxStringValidator.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(
      text,
    )) {
      return "Password length must between 8 and 20";
    }
    return null;
  }

  Future<void> login() async {
    loading = true;
    update();

    if (formKey.currentState!.validate()) {
      String email = emailTE.text;
      String password = passwordTE.text;

      try {
        UserCredential result = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        if (result.user != null) {
          showSnackBar("Login is done");
          goToUser();
        } else {
          showSnackBar("Something wrong login");
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == Auth.emailAlreadyInUse) {
          showSnackBar("Email address is already in use");
        } else if (error.code == Auth.weakPassword) {
          showSnackBar("Password is weak");
        } else if (error.code == Auth.wrongPassword) {
          showSnackBar("Password is wrong");
        } else if (error.code == Auth.userNotFound) {
          showSnackBar("User is not registered");
        } else {
          showSnackBar(error.code.toString());
        }
      } catch (e) {}

      loading = false;
      update();
    }
    loading = false;
    update();
  }

  void goToUser() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FirebaseUserScreen(),
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

  void goToGoogleAuth() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GoogleAuthScreen(),
      ),
    );
  }

  void goToForgotPassword() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FirebaseForgotPasswordScreen(),
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
    return "login_controller";
  }
}
