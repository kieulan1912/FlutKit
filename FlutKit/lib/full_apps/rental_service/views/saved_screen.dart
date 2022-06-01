import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/extensions/extensions.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/constant.dart';

import '../controllers/saved_controller.dart';
import '../models/car.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late ThemeData theme;
  late SavedController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(SavedController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SavedController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 20, 20, 00),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(child: FxText.titleMedium("My Collections", fontWeight: 600,)),
                    FxSpacing.height(20),
                    cars(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget cars() {
    return GridView.builder(
        padding: FxSpacing.zero,
        shrinkWrap: true,
        itemCount: controller.cars.length,
        physics: ClampingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: controller.findAspectRatio(),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return car(controller.cars[index]);
        });
  }

  Widget car(Car car) {
    return FxContainer(
      onTap: () {
        controller.goToSingleCarScreen(car);
      },
      padding: FxSpacing.nBottom(4),
      borderRadiusAll: Constant.containerRadius.xs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FxContainer(
            borderRadiusAll: Constant.containerRadius.xs,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            paddingAll: 0,
            child: Image(
              height: 100,
              fit: BoxFit.cover,

              image: AssetImage(car.image),
            ),
          ),
          Container(
            padding: FxSpacing.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodyMedium(
                  car.name,
                  fontWeight: 700,
                ),
                FxSpacing.height(4),
                FxText.bodyMedium(
                  "\$" + car.price.precise.toString() + "/hour",
                  color: theme.colorScheme.primary,
                  fontWeight: 600,
                ),
                FxSpacing.height(4),
                Row(
                  children: [
                    Icon(
                      FeatherIcons.mapPin,
                      size: 12,
                    ),
                    FxSpacing.width(4),
                    FxText.bodySmall(
                      car.location,
                      xMuted: true,
                    ),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
