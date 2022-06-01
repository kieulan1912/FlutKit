import 'package:flutkit_feature/features/firebase/controllers/forgot_password_controller.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class FirebaseForgotPasswordScreen extends StatefulWidget {
  const FirebaseForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _FirebaseForgotPasswordScreenState createState() =>
      _FirebaseForgotPasswordScreenState();
}

class _FirebaseForgotPasswordScreenState
    extends State<FirebaseForgotPasswordScreen> {
  late ThemeData theme;
  late MaterialThemeData mTheme;
  late ForgotPasswordController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;
    controller = FxControllerStore.putOrFind(ForgotPasswordController());
    outlineInputBorder = OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(mTheme.textFieldRadius.small)),
      borderSide: BorderSide(
        color: theme.dividerColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ForgotPasswordController>(
        controller: controller,
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme
                    .copyWith(secondary: mTheme.primaryContainer)),
            child: Scaffold(
              body: ListView(
                padding: FxSpacing.fromLTRB(
                    20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
                children: [
                  FxText.t1(
                    "Forgot Password",
                    fontWeight: 600,
                    textAlign: TextAlign.center,
                  ),
                  FxSpacing.height(20),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: FxTextStyle.b2(),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              isDense: true,
                              labelStyle: FxTextStyle.b2(),
                              hintText: "Password",
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder,
                              border: outlineInputBorder,
                              contentPadding: FxSpacing.all(16),
                              hintStyle: FxTextStyle.b2(xMuted: true),
                              isCollapsed: true),
                          maxLines: 1,
                          controller: controller.emailTE,
                          validator: controller.validateEmail,
                          cursorColor: mTheme.onPrimaryContainer,
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(20),
                  FxButton.block(
                    borderRadiusAll: mTheme.buttonRadius.small,
                    onPressed: () {
                      controller.forgotPassword();
                    },
                    elevation: 0,
                    backgroundColor: mTheme.primary,
                    splashColor: mTheme.primaryContainer.withAlpha(30),
                    child: FxText.l1(
                      "Forgot Password",
                      color: mTheme.onPrimary,
                    ),
                  ),
                  FxSpacing.height(16),
                  Align(
                    alignment: Alignment.center,
                    child: FxButton.text(
                      onPressed: () {
                        controller.goToRegisterScreen();
                      },
                      splashColor: mTheme.primaryContainer,
                      child: FxText.b3("I haven\'t an account",
                          decoration: TextDecoration.underline,
                          color: mTheme.primary),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
