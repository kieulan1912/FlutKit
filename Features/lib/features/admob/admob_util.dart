import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class AdmobUtil {
  //If you using in production you generate Admob IDs

  static String iosAppId = "ca-app-pub-3940256099942544~1458002511";
  static String androidAppId = "ca-app-pub-3940256099942544~3347511713";

  static String iosInterstitialId = "ca-app-pub-3940256099942544/4411468910";
  static String androidInterstitialId =
      "ca-app-pub-3940256099942544/1033173712";

  static String iosBannerId = "ca-app-pub-3940256099942544/2934735716";
  static String androidBannerId = "ca-app-pub-3940256099942544/6300978111";

  static String iosRewardId = "ca-app-pub-3940256099942544/1712485313";
  static String androidRewardId = "ca-app-pub-3940256099942544/5224354917";

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return AdmobUtil.iosInterstitialId;
    } else if (Platform.isAndroid) {
      return AdmobUtil.androidInterstitialId;
    }
    return AdmobUtil.androidInterstitialId;
  }

  static String getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return AdmobUtil.iosRewardId;
    } else if (Platform.isAndroid) {
      return AdmobUtil.androidRewardId;
    }
    return AdmobUtil.androidRewardId;
  }

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return AdmobUtil.iosBannerId;
    } else if (Platform.isAndroid) {
      return AdmobUtil.androidBannerId;
    }
    return AdmobUtil.androidBannerId;
  }
}
