import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:video_player/video_player.dart';

class VideoController extends FxController {
  VideoPlayerController? videoController;

  List<String> videoList = [
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
  ];

  late AnimationController animationController;
  String lastCommand = "Init Video Player";
  Duration? totalDuration, duration;

  int currentPlaying = 0;
  bool playing = false, loop = true;
  final TickerProvider tickerProvider;

  Timer? _timer;

  VideoController(this.tickerProvider) {
    save = false;
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: 400));

    initVideo(videoList[currentPlaying]);
  }

  initVideo(String link) async {
    duration = Duration.zero;
    totalDuration = Duration(seconds: 1);
    update();
    await videoController?.dispose();
    videoController = VideoPlayerController.network(link);

    await videoController?.initialize();
    lastCommand = "New video started";
    update();

    videoController?.setLooping(loop);
    play();
    totalDuration = videoController?.value.duration;

    update();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (_timer != null) _timer?.cancel();
    _timer = Timer.periodic(oneSec, (Timer timer) => {updateTime()});
  }

  updateTime() async {
    if (videoController != null) {
      duration = await videoController?.position;
      update();
      if (!loop && !videoController!.value.isPlaying && playing) next();
    }
  }

  play() async {
    playing = true;
    await videoController?.play();
    lastCommand = "Start playing";
    update();
    animationController.forward();
  }

  pause() async {
    playing = false;
    await videoController?.pause();
    lastCommand = "Paused";
    update();
    animationController.reverse();
  }

  previous() {
    if (currentPlaying > 0) {
      currentPlaying--;
    } else {
      currentPlaying = videoList.length - 1;
    }
    lastCommand = "Previous video";
    update();
    String link = videoList[currentPlaying];
    initVideo(link);
  }

  next() async {
    if (currentPlaying < videoList.length - 1) {
      currentPlaying++;
    } else {
      currentPlaying = 0;
    }
    lastCommand = "Next video";
    update();
    String link = videoList[currentPlaying];
    initVideo(link);
  }

  Future<void> seekTo(double value) async {
    if (videoController != null) {
      Duration newDuration = Duration(seconds: value.toInt());
      await videoController?.seekTo(newDuration);
      duration = newDuration;
      update();
    }
  }

  togglePlaying() {
    if (playing) {
      pause();
    } else {
      play();
    }
  }

  void toggleLoop() {
    loop = !loop;
    videoController?.setLooping(loop);
    lastCommand = "Change loop";
    update();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    videoController?.dispose();
  }

  @override
  String getTag() {
    return "video_controller";
  }
}
