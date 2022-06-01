import 'package:flutkit/theme/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/theme/app_theme.dart';

import '../controllers/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late ThemeData theme;
  late RegisterController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(RegisterController());
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<RegisterController>(
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
                    FxText.headlineLarge(
                      "Create account",
                      fontWeight: 700,
                    ),
                    FxText.bodyLarge(
                      "Sign up to new account",
                      fontWeight: 600,
                    ),
                    FxSpacing.height(40),
                    registerForm(),
                    FxSpacing.height(20),
                    registerBtn(),
                    FxSpacing.height(20),
                    loginBtn(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget registerForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameField(),
          FxSpacing.height(20),
          emailField(),
          FxSpacing.height(20),
          passwordField(),
        ],
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      style: FxTextStyle.bodyMedium(),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          hintText: "Full Name",
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          prefixIcon: Icon(Icons.person),
          contentPadding: FxSpacing.all(16),
          hintStyle: FxTextStyle.bodyMedium(xMuted: true),
          isCollapsed: true),
      maxLines: 1,
      controller: controller.nameController,
      validator: controller.validateName,
      cursorColor: theme.colorScheme.onBackground,
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

  Widget registerBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.headlineLarge(
          "Create",
          fontWeight: 700,
        ),
        FxSpacing.width(20),
        FxButton(
          onPressed: () {
            controller.register();
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

  Widget loginBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.bodySmall(
          "Already have an account?",
        ),
        FxButton.text(
          onPressed: () {
            controller.goToLoginScreen();
          },
          padding: FxSpacing.y(8),
          child: FxText.bodySmall(
            "Sign In",
            color: theme.colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
