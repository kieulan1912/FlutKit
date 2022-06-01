import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/extensions/extensions.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/constant.dart';

import '../controllers/single_car_controller.dart';
import '../models/car.dart';

class SingleCarScreen extends StatefulWidget {
  final Car car;

  const SingleCarScreen({Key? key, required this.car}) : super(key: key);

  @override
  _SingleCarScreenState createState() => _SingleCarScreenState();
}

class _SingleCarScreenState extends State<SingleCarScreen> {
  late ThemeData theme;
  late SingleCarController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(SingleCarController(widget.car));
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SingleCarController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  controller.goBack();
                },
                child: Icon(
                  FeatherIcons.chevronLeft,
                ),
              ),
              title: FxText.titleMedium(
                "Details",
                fontWeight: 700,
              ),
              elevation: 0,
              centerTitle: true,
              actions: [
                InkWell(
                    onTap: () {
                      controller.toggleFav();
                    },
                    child: Icon(
                      controller.fav ? Icons.favorite : Icons.favorite_outline,
                      color: theme.colorScheme.secondary,
                    )),
                FxSpacing.width(20),
              ],
            ),
            body: Padding(
              padding: FxSpacing.x(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image(),
                        FxSpacing.height(20),
                        FxText.titleMedium(
                          controller.car.name,
                          fontWeight: 700,
                        ),
                        FxSpacing.height(4),
                        location(),
                        FxSpacing.height(4),
                        FxText.titleSmall("\$" +
                            controller.car.price.precise.toString() +
                            " /hour"),
                        FxSpacing.height(20),
                        carSpecsTitle(),
                        FxSpacing.height(20),
                        carSpecs(),
                        FxSpacing.height(20),
                        FxText.bodyMedium(
                          "Car Info",
                          fontWeight: 700,
                        ),
                        FxSpacing.height(20),
                        carInfo(),
                      ],
                    ),
                  ),
                  FxButton.block(
                    onPressed: () {
                      controller.goToPaymentScreen();
                    },
                    elevation: 0,
                    borderRadiusAll: Constant.buttonRadius.small,
                    child: FxText.labelLarge(
                      "Book Now",
                      fontWeight: 700,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  FxSpacing.height(20),
                ],
              ),
            ),
          );
        });
  }

  Widget image() {
    return FxContainer(
      paddingAll: 0,
      borderRadiusAll: Constant.containerRadius.xs,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image(
        image: AssetImage(controller.car.image),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget location() {
    return Row(
      children: [
        Icon(
          FeatherIcons.mapPin,
          size: 12,
        ),
        FxSpacing.width(8),
        FxText.bodyMedium(
          controller.car.location,
          xMuted: true,
        ),
      ],
    );
  }

  Widget carSpecsTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FxText.bodyMedium(
          "Car Specs",
          fontWeight: 700,
        ),
        FxText.bodySmall(
          "See More",
          fontWeight: 600,
          color: theme.colorScheme.primary,
        ),
      ],
    );
  }

  Widget carSpecs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FxContainer.bordered(
            color: theme.scaffoldBackgroundColor,
            borderRadiusAll: Constant.containerRadius.small,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodySmall(
                  "Max Power",
                  xMuted: true,
                  fontWeight: 600,
                ),
                FxSpacing.height(8),
                FxText.bodyMedium(
                  controller.car.power.precise.toString(),
                  fontWeight: 700,
                ),
                // FxSpacing.height(4),
                FxText.bodySmall(
                  "hp",
                  muted: true,
                  fontWeight: 600,
                ),
              ],
            ),
          ),
        ),
        FxSpacing.width(20),
        Expanded(
          child: FxContainer.bordered(
            color: theme.scaffoldBackgroundColor,
            borderRadiusAll: Constant.containerRadius.small,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodySmall(
                  "0-60 mph",
                  xMuted: true,
                  fontWeight: 600,
                ),
                FxSpacing.height(8),
                FxText.bodyMedium(
                  controller.car.time.toString(),
                  fontWeight: 700,
                ),
                // FxSpacing.height(4),
                FxText.bodySmall(
                  "sec",
                  muted: true,
                  fontWeight: 600,
                ),
              ],
            ),
          ),
        ),
        FxSpacing.width(20),
        Expanded(
          child: FxContainer.bordered(
            color: theme.scaffoldBackgroundColor,
            borderRadiusAll: Constant.containerRadius.small,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodySmall(
                  "Top Speed",
                  xMuted: true,
                  fontWeight: 600,
                ),
                FxSpacing.height(8),
                FxText.bodyMedium(
                  controller.car.speed.toString(),
                  fontWeight: 700,
                ),
                // FxSpacing.height(4),
                FxText.bodySmall(
                  "mph",
                  muted: true,
                  fontWeight: 600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget carInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                FxSpacing.width(8),
                FxText.bodySmall(
                  controller.car.passengers.toString() + " Passengers",
                  fontWeight: 600,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              children: [
                Icon(
                  Icons.ac_unit,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                FxSpacing.width(8),
                FxText.bodySmall(
                  "Air Conditioning",
                  fontWeight: 600,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              children: [
                Icon(
                  Icons.speed,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                FxSpacing.width(8),
                FxText.bodySmall(
                  "Unlimited Milieage",
                  fontWeight: 600,
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.sensor_door,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                FxSpacing.width(8),
                FxText.bodySmall(
                  controller.car.doors.toString() + " Doors",
                  fontWeight: 600,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                FxSpacing.width(8),
                FxText.bodySmall(
                  controller.car.type,
                  fontWeight: 600,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              children: [
                Icon(
                  Icons.speed,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                FxSpacing.width(8),
                FxText.bodySmall(
                  "Fuel: full to full",
                  fontWeight: 600,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
