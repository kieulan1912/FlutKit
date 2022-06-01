import 'package:flutkit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../controllers/full_app_controller.dart';
import 'collection_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'saved_screen.dart';

class RentalServiceFullApp extends StatefulWidget {
  const RentalServiceFullApp({Key? key}) : super(key: key);

  @override
  _RentalServiceFullAppState createState() => _RentalServiceFullAppState();
}

class _RentalServiceFullAppState extends State<RentalServiceFullApp>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late FullAppController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(FullAppController(this));
  }

  List<Widget> buildTab() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller.navItems.length; i++) {
      bool selected = controller.currentIndex == i;
      tabs.add(Column(children: [
        Icon(controller.navItems[i].iconData, size: selected?18:20,
          color: selected ? theme.colorScheme.primary : theme.colorScheme
              .onBackground,),
        FxSpacing.height(selected ? 8 : 0),
        selected ? FxText.bodySmall(controller.navItems[i].title, fontSize: 10,
            color: theme.colorScheme.primary) : Container(),
      ],));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<FullAppController>(
        controller: controller, theme: theme, builder: (controller) {
      return Scaffold(body: Column(children: [
        Expanded(child: TabBarView(controller: controller.tabController,
          children: const <Widget>[
            HomeScreen(),
            CollectionScreen(),
            SavedScreen(),
            ProfileScreen(),
          ],),),
        FxContainer(
          bordered: true,
          enableBorderRadius: false,
          border: Border(top: BorderSide(
              color: theme.dividerColor, width: 1, style: BorderStyle.solid)),
          padding: FxSpacing.xy(12, 8),
          color: theme.scaffoldBackgroundColor,
          child: TabBar(
            controller: controller.tabController,
            indicator: FxTabIndicator(indicatorColor: theme.colorScheme.primary,
                indicatorHeight: 3,
                radius: 3,
                indicatorStyle: FxTabIndicatorStyle.rectangle,
                yOffset: -10),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: theme.colorScheme.primary,
            tabs: buildTab(),),)
      ],),);
    });
  }
}
