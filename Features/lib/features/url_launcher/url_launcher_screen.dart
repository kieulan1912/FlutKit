/*
*  (This is Official Flutter plugin).
* */

/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for Url Laucher
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/

/* For Android & iOS
 * Reference : https://pub.dev/packages/url_launcher
 * There is no config required
 */

/*
* Make sure all steps you follow as references
* */

import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherScreen extends StatefulWidget {
  final String? refUrl;

  const UrlLauncherScreen({this.refUrl});

  @override
  _UrlLauncherScreenState createState() => _UrlLauncherScreenState();
}

class _UrlLauncherScreenState extends State<UrlLauncherScreen> {
  late ThemeData theme;

  String url = "https://flutter.dev";
  String mailUrl =
      "mailto:mail@example.org?subject=Email Test&body=From,\nFlutKit";
  String callUrl = "tel:+1 555 010 999";
  String smsUrl = "sms:5550101234";
  String youtubeUrl = "https://www.youtube.com";

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
  }

  goToUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: FxText(
          "URL Launcher",
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
                      color: theme.colorScheme.onBackground,
                      size: 24,
                    ),
                  ),
                )
              ]
            : [],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: FxSpacing.top(16),
                child: FxButton(
                  padding: FxSpacing.fromLTRB(16, 12, 16, 12),
                  backgroundColor: theme.colorScheme.primary,
                  borderRadiusAll: 4,
                  elevation: 0,
                  splashColor: theme.colorScheme.onPrimary.withAlpha(100),
                  onPressed: () {
                    goToUrl(url);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.link,
                        color: theme.colorScheme.onPrimary,
                      ),
                      Container(
                          margin: FxSpacing.left(16),
                          child: FxText("Go To URL",
                              color: theme.colorScheme.onPrimary)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: FxSpacing.top(16),
                child: FxButton(
                  padding: FxSpacing.fromLTRB(16, 12, 16, 12),
                  backgroundColor: theme.colorScheme.primary,
                  borderRadiusAll: 4,
                  elevation: 0,
                  splashColor: theme.colorScheme.onPrimary.withAlpha(100),
                  onPressed: () {
                    goToUrl(mailUrl);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FeatherIcons.mail,
                        color: theme.colorScheme.onPrimary,
                      ),
                      Container(
                        margin: FxSpacing.left(16),
                        child: FxText(
                          "Mail Me",
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: FxSpacing.top(16),
                child: FxButton(
                  padding: FxSpacing.fromLTRB(16, 12, 16, 12),
                  backgroundColor: theme.colorScheme.primary,
                  elevation: 0,
                  borderRadiusAll: 4,
                  splashColor: theme.colorScheme.onPrimary.withAlpha(100),
                  onPressed: () {
                    goToUrl(callUrl);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FeatherIcons.phone,
                        color: theme.colorScheme.onPrimary,
                      ),
                      Container(
                        margin: FxSpacing.left(16),
                        child: FxText(
                          "Call Me",
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: FxSpacing.top(16),
                child: FxButton(
                  padding: FxSpacing.fromLTRB(16, 12, 16, 12),
                  backgroundColor: theme.colorScheme.primary,
                  elevation: 0,
                  borderRadiusAll: 4,
                  splashColor: theme.colorScheme.onPrimary.withAlpha(100),
                  onPressed: () {
                    goToUrl(smsUrl);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FeatherIcons.messageSquare,
                        color: theme.colorScheme.onPrimary,
                      ),
                      Container(
                        margin: FxSpacing.left(16),
                        child: FxText(
                          "SMS Me",
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: FxSpacing.top(16),
                child: FxButton(
                  padding: FxSpacing.fromLTRB(16, 12, 16, 12),
                  backgroundColor: theme.colorScheme.primary,
                  borderRadiusAll: 4,
                  elevation: 0,
                  splashColor: theme.colorScheme.onPrimary.withAlpha(100),
                  onPressed: () {
                    goToUrl(youtubeUrl);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FeatherIcons.youtube,
                        color: theme.colorScheme.onPrimary,
                      ),
                      Container(
                        margin: FxSpacing.left(16),
                        child: FxText(
                          "Open Youtube",
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
