/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for google signin
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/ /*


*/
/*
* Make sure you have already created firebase project and add files as google-services files into projects.
* */ /*


*/
/* For Android
 * Reference : https://pub.dev/packages/google_sign_in
 * You need google-services.json file
 */ /*


*/
/* For iOS
 * Reference : https://pub.dev/packages/google_sign_in
 * You need GoogleService-Info.plist file
 * There is some code add into ../ios/Runner/Info.plist file
 */ /*


*/
/*
* Make sure all steps you follow as references
* */

import 'package:flutkit_feature/features/google_auth/google_auth_controller.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthScreen extends StatefulWidget {
  final String? refUrl;

  const GoogleAuthScreen({this.refUrl});

  @override
  _GoogleAuthScreenState createState() => _GoogleAuthScreenState();
}

class _GoogleAuthScreenState extends State<GoogleAuthScreen> {
  late ThemeData themeData;
  late GoogleAuthController controller;

  @override
  void initState() {
    super.initState();
    themeData = AppTheme.theme;
    controller = FxControllerStore.putOrFind<GoogleAuthController>(
        GoogleAuthController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<GoogleAuthController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  FeatherIcons.chevronLeft,
                  color: themeData.colorScheme.onBackground,
                  size: 24,
                ),
              ),
              centerTitle: true,
              title: FxText.t2(
                "Google Auth",
                fontWeight: 600,
              ),
              actions: widget.refUrl != null
                  ? [
                      InkWell(
                        onTap: () {
                          Generator.launchUrl(widget.refUrl);
                        },
                        child: Container(
                          margin: FxSpacing.right(16),
                          child: Icon(
                            Icons.link,
                            color: themeData.colorScheme.onBackground,
                            size: 24,
                          ),
                        ),
                      )
                    ]
                  : [],
            ),
            body: _buildBody(),
          );
        });
  }

  Widget _buildBody() {
    if (controller.currentUser != null) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: GoogleUserCircleAvatar(
                identity: controller.currentUser!,
              ),
              title: Text(controller.currentUser!.displayName ?? ''),
              subtitle: Text(controller.currentUser!.email),
            ),
            FxSpacing.height(20),
            FxText(
              "Signed in successfully.",
            ),
            FxSpacing.height(20),
            FxButton(
              borderRadiusAll: 4,
              elevation: 0,
              backgroundColor: themeData.colorScheme.primary,
              child: FxText(
                'SIGN OUT',
                color: themeData.colorScheme.onPrimary,
              ),
              onPressed: controller.handleSignOut,
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FxText(
              "You are not currently signed in",
              textAlign: TextAlign.center,
            ),
            FxSpacing.height(20),
            FxButton(
              borderRadiusAll: 4,
              elevation: 0,
              backgroundColor: themeData.colorScheme.primary,
              child: FxText(
                'SIGN IN',
                color: themeData.colorScheme.onPrimary,
              ),
              onPressed: controller.handleSignIn,
            ),
          ],
        ),
      );
    }
  }
}
