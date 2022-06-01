import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:flutkit/theme/app_theme.dart';
import 'package:flutkit/theme/constant.dart';

import '../controllers/home_controller.dart';
import '../models/car.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData theme;
  late HomeController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(HomeController());
    outlineInputBorder = OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(Constant.containerRadius.medium)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HomeController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    title(),
                    FxSpacing.height(20),
                    select(),
                    FxSpacing.height(20),
                    brand(),
                    FxSpacing.height(20),
                    categories(),
                    FxSpacing.height(20),
                    bestCars(),
                    FxSpacing.height(20),
                    cars(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget title() {
    return Padding(
      padding: FxSpacing.x(20),
      child: Row(
        children: [
          FxContainer(
            paddingAll: 8,
            borderRadiusAll: Constant.containerRadius.medium,
            child: Icon(
              FeatherIcons.mapPin,
              size: 20,
            ),
          ),
          FxSpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodySmall(
                  "Your Location",
                  xMuted: true,
                ),
                FxText.bodyMedium(
                  "Wellington, Canada",
                  fontWeight: 700,
                ),
              ],
            ),
          ),
          FxContainer.rounded(
            paddingAll: 0,
            height: 40,
            width: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/images/full_apps/rental_service/images/profile.jpg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget select() {
    return FxContainer(
      margin: FxSpacing.x(20),
      child: Column(
        children: [
          FxText.titleLarge(
            "Select or search your \nfavourite vehicle",
            fontWeight: 700,
            textAlign: TextAlign.center,
          ),
          FxSpacing.height(20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: FxTextStyle.bodyMedium(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      isDense: true,
                      filled: true,
                      prefixIcon: Icon(FeatherIcons.search),
                      hintText: "Search Here",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(xMuted: true),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.searchController,
                  cursorColor: theme.colorScheme.onBackground,
                ),
              ),
              FxSpacing.width(12),
              FxContainer(
                paddingAll: 13,
                borderRadiusAll: Constant.containerRadius.medium,
                color: theme.colorScheme.primary,
                child: Icon(
                  FeatherIcons.list,
                  size: 20,
                  color: theme.colorScheme.onPrimary,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget brand() {
    return Padding(
      padding: FxSpacing.x(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FxText.bodyMedium(
            "Top Brands",
            fontWeight: 700,
          ),
          FxText.bodySmall(
            "See All",
            xMuted: true,
          ),
        ],
      ),
    );
  }

  Widget categories() {
    List<Widget> list = [];

    list.add(
      FxSpacing.width(20),
    );
    for (int i = 0; i < controller.categories.length; i++) {
      list.add(category(controller.categories[i]));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget category(Category category) {
    return FxContainer(
      margin: FxSpacing.right(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 40,
            width: 40,
            image: AssetImage(category.image),
          ),
          FxSpacing.height(8),
          FxText.bodySmall(
            category.name,
            fontWeight: 600,
          ),
        ],
      ),
    );
  }

  Widget bestCars() {
    return Padding(
      padding: FxSpacing.x(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FxText.bodyMedium(
            "Best Cars",
            fontWeight: 700,
          ),
          FxText.bodySmall(
            "See All",
            xMuted: true,
          ),
        ],
      ),
    );
  }

  Widget cars() {
    List<Widget> list = [];

    list.add(FxSpacing.width(20));

    for (int i = 0; i < controller.cars.length; i++) {
      list.add(car(controller.cars[i]));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget car(Car car) {
    return FxContainer(
      onTap: () {
        controller.goToSingleCarScreen(car);
      },
      paddingAll: 4,
      borderRadiusAll: Constant.containerRadius.xs,
      margin: FxSpacing.right(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxContainer(
            borderRadiusAll: Constant.containerRadius.xs,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            paddingAll: 0,
            child: Image(
              width: 150,
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
                  "\$" + car.price.toString() + "/hour",
                  color: theme.colorScheme.primary,
                  fontWeight: 600,
                ),
                FxSpacing.height(4),
                Row(
                  children: [
                    Icon(
                      FeatherIcons.mapPin,
                      size: 14,
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
