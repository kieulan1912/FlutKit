import 'package:flutkit_feature/features/firebase/controllers/user_controller.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class FirebaseUserScreen extends StatefulWidget {
  @override
  _FirebaseUserScreenState createState() => _FirebaseUserScreenState();
}

class _FirebaseUserScreenState extends State<FirebaseUserScreen> {
  late ThemeData theme;
  late MaterialThemeData mTheme;
  late UserController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;
    controller = FxControllerStore.putOrFind(UserController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<UserController>(
        controller: controller,
        builder: (controller) {
          return Theme(
              data: theme.copyWith(
                  colorScheme: theme.colorScheme
                      .copyWith(secondary: mTheme.primaryContainer)),
              child: Scaffold(
                  appBar: AppBar(
                      elevation: 0,
                      leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          FeatherIcons.chevronLeft,
                          color: theme.colorScheme.onBackground,
                          size: 24,
                        ),
                      ),
                      centerTitle: true,
                      title: FxText.t2(
                        "Firebase User",
                        fontWeight: 600,
                      )),
                  body: Container(
                      padding: FxSpacing.fromLTRB(24, 24, 24, 0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FxText(
                              controller.user == null
                                  ? "User is not Logged in"
                                  : "You are logged in with " +
                                      controller.user!.email.toString(),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                                margin: FxSpacing.top(16),
                                child: controller.user != null
                                    ? FxButton(
                                        elevation: 0,
                                        borderRadiusAll: 4,
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        onPressed: () {
                                          controller.logout();
                                        },
                                        child: FxText(
                                          "Logout",
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          FxButton(
                                            elevation: 0,
                                            borderRadiusAll: 4,
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            onPressed: () {
                                              controller.goToLogin();
                                            },
                                            child: FxText(
                                              "Login",
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                          FxSpacing.height(16),
                                          FxButton(
                                            elevation: 0,
                                            borderRadiusAll: 4,
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            onPressed: () {
                                              controller.goToRegister();
                                            },
                                            child: FxText(
                                              "Register",
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                        ],
                                      ))
                          ],
                        ),
                      ))));
        });
  }
}
