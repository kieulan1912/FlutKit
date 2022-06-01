/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for quick shortcuts
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/

/* For Android & iOS
 * Reference : https://pub.dev/packages/quick_actions
 * Nothing to config for both platforms
 */

import 'package:flutkit_feature/theme/app_theme.dart';
import 'package:flutkit_feature/theme/material_theme.dart';
import 'package:flutkit_feature/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
/*
* Make sure all steps you follow as references
* */

import 'package:video_player/video_player.dart';

import 'video_controller.dart';

class VideoScreen extends StatefulWidget {
  final String? refUrl;

  const VideoScreen({this.refUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  late ThemeData theme;
  late MaterialThemeData mTheme;

  late VideoController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.materialThemeData;
    controller = FxControllerStore.putOrFind(VideoController(this));
  }

  convertTimeToString(Duration? duration) {
    if (duration == null) return "00:00";
    int _position = duration.inSeconds;
    int hour = (_position / 3600).floor();
    int minute = ((_position - 3600 * hour) / 60).floor();
    int second = (_position - 3600 * hour - 60 * minute);
    String time = "";
    if (second < 10) {
      time += minute.toString() + ":0" + second.toString();
    } else {
      time += minute.toString() + ":" + second.toString();
    }

    return time;
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<VideoController>(
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
                    "Video Player",
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
                  child: Column(
                    children: [
                      videoWidget(),
                      FxSpacing.height(16),
                      controlWidget(),
                      FxSpacing.height(16),
                      statusWidget()
                    ],
                  ),
                ),
              ));
        });
  }

  Widget videoWidget() {
    if (controller.videoController != null &&
        controller.videoController!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: controller.videoController!.value.aspectRatio,
        child: VideoPlayer(controller.videoController!),
      );
    } else {
      return Container(
          height: 220, child: Center(child: CircularProgressIndicator()));
    }
  }

  Widget controlWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8),
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: BorderSide.none),
                    child: InkWell(
                      splashColor: theme.colorScheme.primary,
                      child: SizedBox(
                          height: 48,
                          width: 48,
                          child: Icon(
                            Icons.skip_previous_outlined,
                            color: theme.colorScheme.onBackground,
                            size: 28,
                          )),
                      onTap: () {
                        controller.previous();
                      },
                    ),
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  elevation: 5,
                  color: theme.colorScheme.primary,
                  child: InkWell(
                    splashColor: Colors.white,
                    child: IconButton(
                      iconSize: 28,
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: controller.animationController,
                        color: theme.colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        controller.togglePlaying();
                      },
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: BorderSide.none),
                    child: InkWell(
                      splashColor: theme.colorScheme.primary,
                      child: SizedBox(
                          height: 48,
                          width: 48,
                          child: Icon(
                            Icons.skip_next_outlined,
                            color: theme.colorScheme.onBackground,
                            size: 28,
                          )),
                      onTap: () {
                        controller.next();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: FxText.caption(
                      convertTimeToString(controller.duration),
                      fontWeight: 500)),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(trackHeight: 2.5),
                  child: (controller.duration != null &&
                          controller.totalDuration != null)
                      ? Slider(
                          value: controller.duration!.inSeconds.toDouble(),
                          onChanged: (value) {
                            controller.seekTo(value);
                          },
                          min: 0,
                          max: controller.totalDuration!.inSeconds.toDouble(),
                        )
                      : FxSpacing.empty(),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 16),
                  child: FxText.caption(
                      convertTimeToString(controller.totalDuration),
                      fontWeight: 500)),
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: BorderSide.none),
                  child: InkWell(
                    splashColor: theme.colorScheme.primary,
                    child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Icon(
                          controller.loop ? Icons.repeat : Icons.shuffle,
                          color: theme.colorScheme.onBackground,
                          size: 22,
                        )),
                    onTap: () {
                      controller.toggleLoop();
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget statusWidget() {
    if (controller.videoController == null) return FxSpacing.empty();
    return FxContainer.bordered(
        margin: FxSpacing.all(20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText.l1('Video Information'),
            FxSpacing.height(16),
            FxText.b3(
                'Playing - ' + (controller.playing ? "Playing" : "Paused")),
            FxSpacing.height(16),
            FxText.b3('Loop - ' + (controller.loop ? "On" : "Off")),
            FxSpacing.height(16),
            FxText.b3('Last Command - ' + (controller.lastCommand)),
          ],
        ));
  }
}
