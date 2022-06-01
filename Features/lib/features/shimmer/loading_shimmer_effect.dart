/*
* This Plugin is Third Party.
* */

/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for shimmer
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/

/* For Android
 *
 * Reference : https://pub.dev/packages/shimmer
 */

/* For iOS
 * Reference : https://pub.dev/packages/shimmer


*
* Make sure all steps you follow as references
* */

import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmerEffect extends StatefulWidget {
  final String? refUrl;

  LoadingShimmerEffect({this.refUrl});

  @override
  _LoadingShimmerEffectState createState() => _LoadingShimmerEffectState();
}

class _LoadingShimmerEffectState extends State<LoadingShimmerEffect> {
  late ThemeData theme;
  late MaterialThemeData mTheme;

  bool enabled = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          "Loading Shimmer Effect",
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
        width: double.infinity,
        padding: FxSpacing.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: mTheme.shimmerBaseColor,
                highlightColor: mTheme.shimmerHighlightColor,
                enabled: enabled,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding: FxSpacing.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: FxSpacing.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: FxSpacing.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: FxSpacing.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 40.0,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: 6,
                ),
              ),
            ),
            Padding(
                padding: FxSpacing.symmetric(vertical: 8.0),
                child: FxButton(
                  elevation: 0,
                  borderRadiusAll: 4,
                  padding: FxSpacing.x(24),
                  backgroundColor: theme.colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      enabled = !enabled;
                    });
                  },
                  child: FxText(
                    enabled ? 'Stop' : 'Play',
                    color: theme.colorScheme.onPrimary,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
