/*
*  (This is third party plugin).
* */

/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for Image Picker as well Image Cropper
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/

/* For Android
 * Reference : https://pub.dev/packages/image_cropper
 * See this reference there is some android config required
 */

/* For iOS
 * Reference : https://pub.dev/packages/image_cropper
 * There is no config required
 */

import 'package:flutkit_feature/features/image_cropper/image_cropper_controller.dart';
import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class ImageCropperScreen extends StatefulWidget {
  final String? refUrl;

  const ImageCropperScreen({this.refUrl});

  @override
  _ImageCropperScreenState createState() => _ImageCropperScreenState();
}

class _ImageCropperScreenState extends State<ImageCropperScreen> {
  late ThemeData theme;
  late MaterialThemeData mTheme;

  late ImageCropperController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;

    controller = FxControllerStore.putOrFind(ImageCropperController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ImageCropperController>(
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
                  "Image Cropper",
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
                              color: theme.colorScheme.onBackground,
                              size: 24,
                            ),
                          ),
                        )
                      ]
                    : [],
              ),
              body: Center(
                child: InkWell(
                  onTap: () {
                    if (controller.state == AppState.free)
                      controller.pickImage();
                  },
                  child: Container(
                    child: controller.imageFile != null
                        ? Image.file(controller.imageFile!)
                        : Container(
                            height: 250,
                            width: 250,
                            child: Center(
                                child: FxText(
                              "Select image to crop",
                            )),
                          ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: mTheme.primary,
                onPressed: () {
                  if (controller.state == AppState.free)
                    controller.pickImage();
                  else if (controller.state == AppState.picked)
                    controller.cropImage();
                  else if (controller.state == AppState.cropped)
                    controller.clearImage();
                },
                child: _buildButtonIcon(),
              ),
            ),
          );
        });
  }

  Widget _buildButtonIcon() {
    if (controller.state == AppState.free)
      return Icon(
        Icons.add,
        color: mTheme.onPrimary,
      );
    else if (controller.state == AppState.picked)
      return Icon(
        Icons.crop,
        color: mTheme.onPrimary,
      );
    else if (controller.state == AppState.cropped)
      return Icon(
        Icons.clear,
        color: mTheme.onPrimary,
      );
    else
      return Container();
  }
}
