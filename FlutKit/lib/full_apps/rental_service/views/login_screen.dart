import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/constant.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ThemeData theme;
  late LoginController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(LoginController());
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<LoginController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FxText.displayLarge(
                      "Hello",
                      fontWeight: 700,
                    ),
                    FxText.bodyLarge(
                      "Sign in to your account",
                      fontWeight: 600,
                    ),
                    FxSpacing.height(40),
                    loginForm(),
                    FxSpacing.height(12),
                    forgotPassword(),
                    FxSpacing.height(20),
                    loginButton(),
                    FxSpacing.height(20),
                    registerBtn(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget loginForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          emailField(),
          FxSpacing.height(20),
          passwordField(),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      style: FxTextStyle.bodyMedium(),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          hintText: "Email Address",
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          prefixIcon: Icon(Icons.person),
          contentPadding: FxSpacing.all(16),
          hintStyle: FxTextStyle.bodyMedium(xMuted: true),
          isCollapsed: true),
      maxLines: 1,
      controller: controller.emailController,
      validator: controller.validateEmail,
      cursorColor: theme.colorScheme.onBackground,
    );
  }

  Widget passwordField() {
    return TextFormField(
      style: FxTextStyle.bodyMedium(),
      keyboardType: TextInputType.text,
      obscureText: controller.enable ? false : true,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          hintText: "Password",
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: InkWell(
              onTap: () {
                controller.toggle();
              },
              child: Icon(
                  controller.enable ? Icons.visibility_off : Icons.visibility)),
          contentPadding: FxSpacing.all(16),
          hintStyle: FxTextStyle.bodyMedium(xMuted: true),
          isCollapsed: true),
      maxLines: 1,
      controller: controller.passwordController,
      validator: controller.validatePassword,
      cursorColor: theme.colorScheme.onBackground,
    );
  }

  Widget loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.headlineLarge(
          "Sign In",
          fontWeight: 700,
        ),
        FxSpacing.width(20),
        FxButton(
          onPressed: () {
            controller.login();
          },
          elevation: 0,
          borderRadiusAll: Constant.buttonRadius.xs,
          child: Icon(
            Icons.keyboard_arrow_right,

            color: theme.colorScheme.onPrimary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: FxButton.text(
        onPressed: () {
          controller.goToForgotPasswordScreen();
        },
        elevation: 0,
        padding: FxSpacing.y(4),
        borderRadiusAll: Constant.buttonRadius.small,
        child: FxText.bodySmall(
          "Forgot your Password?",
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget registerBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.bodySmall(
          "Don't have an account?",
        ),
        FxButton.text(
          onPressed: () {
            controller.goToRegisterScreen();
          },
          padding: FxSpacing.y(8),
          child: FxText.bodySmall(
            "Create",
            color: theme.colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

}
