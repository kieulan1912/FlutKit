/*
* This Plugin is still in developer preview.
* */

/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for admob_flutter
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
 *
 * Add this line to starting point of your app ../lib/main.dart

Admob.initialize();
// Admob.initialize(testDeviceIds: ['YOUR DEVICE ID']);

*/

/* For Android
 * There is no any configuration
 * Reference : https://pub.dev/packages/admob_flutter
 * Add this line to ../main/AndroidManifest.xml
 *

<manifest>
  <application>
    <meta-data
      android:name="com.google.android.gms.ads.APPLICATION_ID"
      android:value="ca-app-pub-3940256099942544~3347511713"/>
  </application>
</manifest>

 *
*/

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import 'admob_controller.dart';

class InterstitialAds extends StatefulWidget {
  final String? refUrl;

  const InterstitialAds({this.refUrl});

  @override
  _InterstitialAdsState createState() => _InterstitialAdsState();
}

class _InterstitialAdsState extends State<InterstitialAds> {
  late ThemeData themeData;

  late AdmobController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeData = AppTheme.theme;
    controller = FxControllerStore.putOrFind<AdmobController>(
        AdmobController(AdType.INTERSTITIAL));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<AdmobController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return Scaffold(
      key: controller.scaffoldKey,
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
        title: FxText(
          "Admob Interstitial",
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
      body: Container(
        child: Center(
          child: FxButton(
            elevation: 0,
            splashColor: themeData.colorScheme.onPrimary.withAlpha(40),
            backgroundColor: themeData.colorScheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: FxText(
              "Show Interstitial",
              color: themeData.colorScheme.onPrimary,
            ),
            onPressed: () async {
              controller.showInterstitialAd();
            },
          ),
        ),
      ),
    );
  }
}
