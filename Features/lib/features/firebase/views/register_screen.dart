import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/icons/box_icon/box_icon_data.dart';

import '../controllers/register_controller.dart';

class FirebaseRegisterScreen extends StatefulWidget {
  @override
  _FirebaseRegisterScreenState createState() => _FirebaseRegisterScreenState();
}

class _FirebaseRegisterScreenState extends State<FirebaseRegisterScreen> {
  late ThemeData theme;
  late MaterialThemeData mTheme;

  late RegisterController controller;

  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;
    controller = FxControllerStore.putOrFind(RegisterController());
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
    return FxBuilder<RegisterController>(
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
                    "Firebase Register",
                    textAlign: TextAlign.center,
                    fontWeight: 600,
                  ),
                  FxSpacing.height(24),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.b2(
                          "Email",
                          fontWeight: 600,
                        ),
                        FxSpacing.height(12),
                        TextFormField(
                          style: FxTextStyle.b2(),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              isDense: true,
                              labelStyle: FxTextStyle.b2(),
                              hintText: "Email Address",
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
                        FxSpacing.height(20),
                        FxText.b2(
                          "Password",
                          fontWeight: 600,
                        ),
                        FxSpacing.height(20),
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
                          controller: controller.passwordTE,
                          validator: controller.validatePassword,
                          cursorColor: mTheme.onPrimaryContainer,
                        ),
                        FxSpacing.height(12),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FxButton.text(
                            onPressed: () {
                              controller.goToForgotPassword();
                            },
                            padding: FxSpacing.x(0),
                            splashColor: mTheme.primaryContainer,
                            child: FxText.b2(
                              "Forgot Password?",
                              color: mTheme.primary,
                              fontWeight: 600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(8),
                  FxButton(
                    elevation: 0,
                    borderRadiusAll: mTheme.buttonRadius.small,
                    backgroundColor: mTheme.primary,
                    padding: FxSpacing.y(12),
                    splashColor: mTheme.onPrimary.withAlpha(30),
                    onPressed: () {
                      controller.register();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.loading
                            ? Container(
                                margin: FxSpacing.right(16),
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        theme.colorScheme.onPrimary),
                                    strokeWidth: 1.4),
                              )
                            : FxSpacing.empty(),
                        FxText.l1(
                          "Register",
                          color: mTheme.onPrimary,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(20),
                  Align(
                    alignment: Alignment.center,
                    child: FxText.b2(
                      "Don\'t have an account?",
                    ),
                  ),
                  FxSpacing.height(8),
                  Align(
                    alignment: Alignment.center,
                    child: FxButton.text(
                      onPressed: () {
                        controller.goToLogin();
                      },
                      splashColor: mTheme.primaryContainer,
                      child: FxText.b2(
                        "Sign In",
                        color: mTheme.primary,
                        fontWeight: 600,
                      ),
                    ),
                  ),
                  FxSpacing.height(8),
                  Divider(),
                  FxSpacing.height(20),
                  FxButton.block(
                    backgroundColor: mTheme.primaryContainer,
                    padding: FxSpacing.y(12),
                    splashColor: mTheme.primary.withAlpha(20),
                    elevation: 0,
                    borderRadiusAll: mTheme.buttonRadius.small,
                    onPressed: () {
                      controller.goToGoogleAuth();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FxBoxIcons.bxl_google,
                          color: mTheme.primary,
                          size: 20,
                        ),
                        FxSpacing.width(20),
                        FxText.b2(
                          'Log in with Google',
                          fontWeight: 600,
                          color: mTheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//
// void showSnack(String message) {
//   _scaffoldKey.currentState.showSnackBar(SnackBar(
//     content: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         message,
//         style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,color: themeData.colorScheme.onPrimary),
//       ),
//     ),
//     backgroundColor: themeData.colorScheme.primary,
//   ));
// }

}
