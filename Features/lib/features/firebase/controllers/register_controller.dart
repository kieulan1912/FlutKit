import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutkit_feature/features/firebase/views/forgot_password_screen.dart';
import 'package:flutkit_feature/features/firebase/views/login_screen.dart';
import 'package:flutkit_feature/features/firebase/views/user_screen.dart';
import 'package:flutkit_feature/features/google_auth/google_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../auth.dart';

class RegisterController extends FxController {
  late TextEditingController emailTE = TextEditingController();
  late TextEditingController passwordTE = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  GlobalKey<FormState> formKey = GlobalKey();

  bool loading = false;
  bool showPassword = false;

  RegisterController() {
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

  Future<void> register() async {
    String email = emailTE.text;
    String password = passwordTE.text;
    if (formKey.currentState!.validate()) {
      loading = true;
      update();
      try {
        UserCredential result = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (result.user != null) {
          showSnackBar("Registration is done");

          goToUser();
        } else {
          showSnackBar("Something wrong registration");
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == Auth.emailAlreadyInUse) {
          showSnackBar("Email address is already in use");
        } else if (error.code == Auth.weakPassword) {
          showSnackBar("Password is weak");
        } else {
          showSnackBar(error.code.toString());
        }
      } catch (e) {}

      loading = false;
      update();
    }
  }

  void goToUser() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FirebaseUserScreen(),
      ),
    );
  }

  void goToLogin() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FirebaseLoginScreen(),
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
    return "register_controller";
  }
}
