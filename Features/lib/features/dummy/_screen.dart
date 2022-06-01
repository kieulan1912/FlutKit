/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for quick shortcuts
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/

/* For Android & iOS
 * Reference : https://pub.dev/packages/quick_actions
 * Nothing to config for both platforms
 */

/*
* Make sure all steps you follow as references
* */

import '_controller.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class Screen extends StatefulWidget {
  final String? refUrl;

  const Screen({this.refUrl});

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late ThemeData theme;
  late MaterialThemeData mTheme;

  late Controller controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;
    controller = FxControllerStore.putOrFind(Controller());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<Controller>(
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
                  title: FxText(
                    "Quick Actions",
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
                  margin: FxSpacing.all(24),
                  child: Column(
                    children: [

                    ],
                  ),
                ),
              ));
        });
  }
}
