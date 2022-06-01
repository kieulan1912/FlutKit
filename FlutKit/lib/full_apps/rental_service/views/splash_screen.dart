import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/constant.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ThemeData theme;
  late SplashController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(SplashController());
    outlineInputBorder = OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(Constant.containerRadius.medium)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SplashController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image(),
                  FxSpacing.height(32),
                  FxText.headlineSmall(
                    "Book Car in Easy Steps",
                    fontWeight: 700,
                  ),
                  FxSpacing.height(12),
                  FxText.bodySmall(
                    "Renting a car brings you freedom, and we'll help you find the best car for you at a great price.",
                  ),
                  FxSpacing.height(12),
                  stars(),
                  FxSpacing.height(12),
                  Expanded(
                    child: FxText.bodySmall(
                      "Trust by 10 million customers.",
                      xMuted: true,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FxButton.outlined(
                          borderColor: theme.dividerColor,
                          borderRadiusAll: Constant.buttonRadius.small,
                          onPressed: () {
                            controller.goToLoginScreen();
                          },
                          child: FxText.labelLarge(
                            "Sign In",
                          ),
                        ),
                      ),
                      FxSpacing.width(20),
                      Expanded(
                        child: FxButton.small(
                          padding: FxSpacing.all(16),
                          borderRadiusAll: Constant.buttonRadius.small,
                          onPressed: () {
                            controller.goToRegisterScreen();
                          },
                          elevation: 0,
                          child: FxText.labelLarge(
                            "Register",
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget image() {
    return FxContainer(
      paddingAll: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadiusAll: Constant.containerRadius.large,
      child: Image(
        height: 400,
        fit: BoxFit.cover,
        image: AssetImage(
            "assets/images/full_apps/rental_service/images/splash.jpg"),
      ),
    );
  }

  Widget stars() {
    List<Widget> list = [];

    for (int i = 0; i < 5; i++) {
      list.add(
        FxContainer(
          paddingAll: 4,
          margin: FxSpacing.right(8),
          color: theme.colorScheme.primary,
          borderRadiusAll: Constant.containerRadius.small,
          child: Icon(
            Icons.star,
            size: 16,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      );
    }

    return Row(
      children: list,
    );
  }
}
