/*
* File : Single Grid Item
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleGridItem extends StatefulWidget {
  final String title;
  final String? icon;
  final List<SinglePageItem> items;
  final bool isComingSoon;
  final String comingSoonText;
  final String? refUrl;
  final bool colored;

  const SingleGridItem({
    required this.title,
    required this.items,
    this.icon,
    this.isComingSoon = false,
    this.comingSoonText = "",
    this.refUrl,
    this.colored = true
  });

  @override
  _SingleGridItemState createState() => _SingleGridItemState();
}

class _SingleGridItemState extends State<SingleGridItem> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    String assetName = widget.icon ?? 'assets/icons/rocket-outline.png';

    Widget iconWidget = Image.asset(
      assetName,
      color: widget.colored ? null : themeData.colorScheme.primary,
      width: 36,
      height: 36,
    );

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SinglePageHome(
                    title: widget.title,
                    items: widget.items,
                    comingSoonText: widget.comingSoonText,
                    isComingSoon: widget.isComingSoon,
                    refUrl: widget.refUrl)));
      },
      child: Container(
        decoration: new BoxDecoration(
          color: themeData.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 1.2, color: themeData.colorScheme.surface),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              iconWidget,
              Container(
                  margin: EdgeInsets.only(top: 16),
                  child: FxText(
                    widget.title,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class SinglePageItem extends StatelessWidget {
  final String title;
  final String? icon;
  final bool colored;
  final Widget navigation;

  const SinglePageItem({
    required this.title,
    required this.navigation,
    this.icon,
    this.colored = true
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    String assetName = icon ?? 'assets/icons/rocket-outline.png';

    Widget iconWidget = Image.asset(
      assetName,
      color: colored?null: themeData.colorScheme.primary,
      width: 36,
      height: 36,
    );
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => navigation));
      },
      child: Container(
        decoration: BoxDecoration(
          color: themeData.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 1.2, color: themeData.colorScheme.surface),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              iconWidget,
              Container(
                margin: EdgeInsets.only(top: 16),
                child: FxText(
                  title,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SinglePageHome extends StatefulWidget {
  final List<SinglePageItem> items;
  final String title;
  final bool isComingSoon;
  final String comingSoonText;
  final String? refUrl;

  const SinglePageHome(
      {required this.items,
      required this.title,
      this.isComingSoon = true,
      this.comingSoonText = "",
      this.refUrl});

  @override
  _SinglePageHomeState createState() => _SinglePageHomeState();
}

class _SinglePageHomeState extends State<SinglePageHome> {
  late ThemeData themeData;

  _launchURL() async {
    String? url = widget.refUrl;
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: FxText(
          widget.title,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            FeatherIcons.chevronLeft,
            color: themeData.colorScheme.onBackground,
          ),
        ),
        actions: widget.refUrl != null
            ? [
                InkWell(
                  onTap: () {
                    _launchURL();
                  },
                  child: Icon(
                    Icons.code,
                    color: themeData.colorScheme.onBackground,
                    size: 24,
                  ),
                )
              ]
            : [],
      ),
      body: Container(
        child: ListView(
          padding: FxSpacing.zero,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            GridView.count(
              crossAxisCount: 2,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              padding:
                  FxSpacing.only(top: 0, left: 20, right: 20, bottom: 20),
              mainAxisSpacing: 20,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              children: widget.items,
            ),
            widget.isComingSoon
                ? Container(
                    margin: FxSpacing.top(8),
                    child: Center(
                      child: FxText(
                        widget.comingSoonText,
                      ),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}
