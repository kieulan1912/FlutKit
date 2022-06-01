/*
*  (I am already added dummy payment but if you use in production
*  than create token at https://razorpay.com/   [ Razorpay Dashboard ].
* */

/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for razorpay_flutter(https://pub.dev/packages/razorpay_flutter)
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/

/* For Android
 * Reference : https://pub.dev/packages/razorpay_flutter
 */

/* For iOS
 * Reference : https://pub.dev/packages/razorpay_flutter
 * There is no config required
 */

import 'package:flutkit_feature/features/razorpay/razorpay_payment_controller.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class RazorpayPaymentScreen extends StatefulWidget {
  final String? refUrl;

  const RazorpayPaymentScreen({this.refUrl});

  @override
  _RazorpayPaymentScreenState createState() => _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {
  late ThemeData theme;
  late MaterialThemeData mTheme;

  late RazorpayPaymentController controller;

  @override
  initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;
    controller = FxControllerStore.putOrFind(RazorpayPaymentController());
  }



  @override
  Widget build(BuildContext context) {
    return FxBuilder<RazorpayPaymentController>(
        controller: controller,
        builder: (controller) {
          return Theme(
              data: theme.copyWith(
                  colorScheme: theme.colorScheme
                      .copyWith(secondary: mTheme.primaryContainer)),
              child:  Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        FeatherIcons.chevronLeft,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    centerTitle: true,
                    title: FxText.sh1("Razorpay", fontWeight: 600),
                  ),
                  body: ListView(
                    padding: FxSpacing.nTop(20),
                    children: <Widget>[
                      FxContainer.bordered(
                        borderRadiusAll: 4,
                        color: Colors.transparent,
                        padding: FxSpacing.fromLTRB(20, 32, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    FeatherIcons.clock,
                                    size: 22,
                                    color: theme.colorScheme.primary,
                                  ),
                                  FxSpacing.width(8),
                                  FxText.caption("2-3 Days", fontWeight: 600, muted: true)
                                ],
                              ),
                            ),
                            FxSpacing.height(32),
                            FxText.sh1("Toffee Bakery",
                                fontWeight: 600, letterSpacing: 0.3),
                            FxSpacing.height(20),
                            FxContainer(
                              borderRadiusAll: 4,
                              onTap: () {

                              },
                              paddingAll: 20,
                              child: Container(
                                height: 64,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FxText.sh1("West Drive", fontWeight: 600),
                                    FxText.caption(
                                      "14, 921 Section",
                                      xMuted: true,
                                    ),
                                    FxSpacing.height(4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(
                                          FeatherIcons.info,
                                          color: FxAppTheme
                                              .theme.colorScheme.onBackground
                                              .withAlpha(200),
                                          size: 10,
                                        ),
                                        FxSpacing.width(4),
                                        FxText.caption(
                                          "Tap to change",
                                          fontSize: 9,
                                          fontWeight: 400,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      FxSpacing.height(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FxText.b1("Order", fontWeight: 600),
                          FxText.caption(
                            " - 2 Item",
                            xMuted: true,
                          ),
                        ],
                      ),
                      FxSpacing.height(20),
                      FxContainer.bordered(
                        borderRadiusAll: 4,
                        color: Colors.transparent,
                        paddingAll: 20,
                        child: Column(
                          children: <Widget>[
                            FxContainer.bordered(
                              borderRadiusAll: 4,
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FxText.b1("Yellow Cake",
                                        letterSpacing: 0, fontWeight: 600),
                                  ),
                                  FxText.sh2("\$12.99",
                                      color: theme.colorScheme.primary, fontWeight: 600)
                                ],
                              ),
                            ),
                            FxSpacing.height(8),
                            FxContainer.bordered(
                              borderRadiusAll: 4,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FxText.b1("Colorful Sandal",
                                        letterSpacing: 0, fontWeight: 600),
                                  ),
                                  FxText.sh2("\$29.99", fontWeight: 600)
                                ],
                              ),
                            ),
                            FxSpacing.height(20),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        FxText.b2(
                                          "FLAT40",
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 600,
                                        ),
                                        FxText.caption("- 40% at max 100\$",
                                            fontSize: 12,
                                            fontWeight: 400,
                                            letterSpacing: -0.2)
                                      ],
                                    ),
                                    FxButton.text(
                                      padding: FxSpacing.zero,
                                      onPressed: () {

                                      },
                                      child: FxText.b2(
                                        "Change coupon",
                                        letterSpacing: 0,
                                        fontWeight: 600,
                                        color: theme.colorScheme.primary,
                                      ),
                                    )
                                  ],
                                ),
                                FxSpacing.height(8),
                                Container(
                                  margin: FxSpacing.top(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FxText.b2("Charges",
                                          muted: true, letterSpacing: 0, fontWeight: 600),
                                      FxText.sh2("\$ 4.00",
                                          letterSpacing: 0, muted: true, fontWeight: 600),
                                    ],
                                  ),
                                ),
                                FxSpacing.height(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FxText.b1("Total", letterSpacing: 0, fontWeight: 700),
                                    FxText.b1("\$ 43.99",
                                        letterSpacing: 0, fontWeight: 700),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      FxSpacing.height(24),
                      FxButton(
                        elevation: 0,
                        padding: FxSpacing.y(12),
                        borderRadiusAll: 4,
                        onPressed: () {
                            controller.pay();
                        },
                        child: FxText.caption(
                          "Pay via Razorpay".toUpperCase(),
                          letterSpacing: 0.6,
                          fontWeight: 600,
                          color: theme.colorScheme.onPrimary,
                        ),
                        backgroundColor: theme.colorScheme.primary,
                      )
                    ],
                  )));
        });
  }
}
