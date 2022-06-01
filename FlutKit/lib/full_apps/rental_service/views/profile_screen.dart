import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/constant.dart';

import '../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ThemeData theme;
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ProfileController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
              child: Column(
                children: [
                  profile(),
                  FxSpacing.height(20),
                  statistics(),
                  FxSpacing.height(32),
                  singleRow(FeatherIcons.clock, "Rides history"),
                  singleRow(FeatherIcons.creditCard, "Payment Methods"),
                  singleRow(FeatherIcons.helpCircle, "FAQ"),
                  singleRow(
                      FeatherIcons.bookOpen, "Terms and Conditions"),
                  singleRow(FeatherIcons.settings, "App Settings"),
                  singleRow(FeatherIcons.smile, "Support Center"),
                  logout(),
                ],
              ),
            ),
          );
        });
  }

  Widget profile() {
    return Row(
      children: [
        FxContainer.rounded(
          height: 80,
          paddingAll: 0,
          child: Image(
            image: AssetImage(
                "assets/images/full_apps/rental_service/images/profile.jpg"),
          ),
        ),
        FxSpacing.width(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText.titleMedium(
              "Smith Williams",
              fontWeight: 700,
            ),
            FxSpacing.height(4),
            FxText.bodySmall(
              "smithwilliams@gmail.com",
              xMuted: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget statistics() {
    return Row(
      children: [
        Expanded(
          child: FxContainer(
            padding: FxSpacing.xy(24, 16),
            color: theme.colorScheme.primaryContainer,
            borderRadiusAll: Constant.containerRadius.small,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.drive_eta_outlined,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                FxSpacing.height(8),
                FxText.headlineSmall(
                  "2451",
                  fontWeight: 700,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                FxText.bodySmall(
                  "Total km",
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
        FxSpacing.width(20),
        Expanded(
          child: FxContainer(
            padding: FxSpacing.xy(24, 16),
            color: theme.colorScheme.primaryContainer,
            borderRadiusAll: Constant.containerRadius.small,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.directions_bike_outlined,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                FxSpacing.height(8),
                FxText.headlineSmall(
                  "15",
                  fontWeight: 700,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                FxText.bodySmall(
                  "Total rides",
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget singleRow(IconData icon, String title) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
            ),
            FxSpacing.width(16),
            FxText.bodyMedium(
              title,
              fontWeight: 600,
            ),
          ],
        ),
        FxSpacing.height(6),
        Divider(),
        FxSpacing.height(4),
      ],
    );
  }

  Widget logout() {
    return FxButton.small(
        padding: FxSpacing.xy(16, 8),
        elevation: 0,
        onPressed: () {
          controller.goBack();
        },
        child: FxText.labelLarge(
          "Logout",
          fontWeight: 700,
          color: theme.colorScheme.onPrimary,
        ));
  }
}
