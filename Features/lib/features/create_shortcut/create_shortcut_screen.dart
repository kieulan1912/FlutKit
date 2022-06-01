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

import 'package:flutkit_feature/features/create_shortcut/create_shortcut_controller.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class CreateShortcutScreen extends StatefulWidget {
  final String? refUrl;

  const CreateShortcutScreen({this.refUrl});

  @override
  _CreateShortcutScreenState createState() => _CreateShortcutScreenState();
}

class _CreateShortcutScreenState extends State<CreateShortcutScreen> {
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
                      Text(
                          "When shortcut is created then go to app icon and hold to see all shortcuts."),
                      Container(
                        margin: FxSpacing.top(24),
                        child: FxButton(
                          elevation: 0,
                          borderRadiusAll: 4,
                          backgroundColor: theme.colorScheme.primary,
                          child: FxText(
                            'Create Shortcut',
                            color: theme.colorScheme.onPrimary,
                          ),
                          onPressed: controller.createShortcuts,
                        ),
                      ),
                      Container(
                        margin: FxSpacing.top(16),
                        child: FxButton(
                          elevation: 0,
                          borderRadiusAll: 4,
                          backgroundColor: theme.colorScheme.primary,
                          child: FxText(
                            'Delete Shortcut',
                            color: theme.colorScheme.onPrimary,
                          ),
                          onPressed: controller.deleteShortcuts,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
