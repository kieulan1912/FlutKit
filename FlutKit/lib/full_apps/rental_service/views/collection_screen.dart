import 'package:flutkit/theme/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/extensions/extensions.dart';
import 'package:flutkit/theme/app_theme.dart';

import '../controllers/collection_controller.dart';
import '../models/car.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late ThemeData theme;
  late CollectionController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(CollectionController());
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<CollectionController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 20, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    search(),
                    FxSpacing.height(20),
                    cars(),
                    FxSpacing.height(20),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget search() {
    return TextField(
      style: FxTextStyle.bodyMedium(),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          prefixIcon: Icon(
            FeatherIcons.search,
          ),
          hintText: "Search your favorite car",
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          contentPadding: FxSpacing.all(16),
          hintStyle: FxTextStyle.bodyMedium(
              xMuted: true, color: theme.colorScheme.onPrimaryContainer),
          isCollapsed: true),
      maxLines: 1,
      controller: controller.searchController,
      cursorColor: theme.colorScheme.onBackground,
    );
  }

  Widget cars() {
    List<Widget> list = [];
    for (int i = 0; i < controller.cars.length; i++) {
      list.add(car(controller.cars[i]));
    }
    return Column(
      children: list,
    );
  }

  Widget car(Car car) {
    return FxContainer(
      onTap: () {
        controller.goToSingleCarScreen(car);
      },
      margin: FxSpacing.bottom(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FxText.bodyLarge(
            car.name,
            fontWeight: 700,
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
          FxSpacing.height(20),
          FxContainer(
            paddingAll: 0,
            height: 150,
            borderRadiusAll: Constant.containerRadius.xs,

            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              image: AssetImage(car.image),
              fit: BoxFit.cover,
            ),
          ),
          FxSpacing.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  FxSpacing.width(4),
                  FxText.bodySmall(
                    car.passengers.toString() + " Passengers",
                    fontWeight: 600,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.settings,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  FxSpacing.width(4),
                  FxText.bodySmall(
                    car.type,
                    fontWeight: 600,
                  ),
                ],
              ),
              FxText.bodySmall("\$" + car.price.precise.toString() + "/hour"),
            ],
          ),
        ],
      ),
    );
  }
}
