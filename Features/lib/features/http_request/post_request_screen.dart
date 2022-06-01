import 'package:flutkit_feature/features/http_request/post_request_controller.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class PostRequestScreen extends StatefulWidget {
  @override
  _PostRequestScreenState createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  late ThemeData theme;

  late PostRequestController controller;
  late MaterialThemeData mTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;
    controller = FxControllerStore.putOrFind(PostRequestController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<PostRequestController>(
        controller: controller,
        builder: (controller) {
          return Theme(
              data: theme.copyWith(
                  colorScheme: theme.colorScheme
                      .copyWith(secondary: mTheme.primaryContainer)),
              child: Scaffold(
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
                    "POST Request",
                  ),
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: FxSpacing.fromLTRB(24, 24, 24, 0),
                          child: FxButton(
                            backgroundColor: theme.colorScheme.primary,
                            borderRadiusAll: 4,
                            elevation: 0,
                            splashColor: Colors.white.withAlpha(100),
                            padding: FxSpacing.y(12),
                            onPressed: () {
                              if (!controller.loading) {
                                controller.postRequest();
                              }
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: FxText(
                                    "Post Request",
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                                Positioned(
                                  right: 16,
                                  child: controller.loading
                                      ? Container(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      theme.colorScheme
                                                          .onPrimary),
                                              strokeWidth: 1.4),
                                        )
                                      : ClipOval(
                                          child: Container(
                                            color: theme
                                                .colorScheme.primaryVariant,
                                            // button color
                                            child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Icon(
                                                  FeatherIcons.arrowRight,
                                                  color: theme
                                                      .colorScheme.onPrimary,
                                                  size: 18,
                                                )),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          )),
                      controller.response != null
                          ? Container(
                              margin: FxSpacing.fromLTRB(24, 24, 24, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status code - " +
                                        controller.response!.statusCode
                                            .toString(),
                                  ),
                                  Text(
                                    "Result - " + controller.response!.body,
                                  ),
                                ],
                              ),
                            )
                          : FxSpacing.empty()
                    ],
                  ),
                ),
              ));
        });
  }
}
