import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import 'admob_util.dart';

enum AdType { BANNER, INTERSTITIAL, REWARD }

class AdmobController extends FxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  AdmobInterstitial? interstitialAd;
  AdmobReward? rewardAd;
  AdmobBanner? admobBanner;

  final AdType adType;

  AdmobController(this.adType) {
    save = false;
  }

  @override
  void initState() {
    super.initState();
    switch (adType) {
      case AdType.BANNER:
        initBannerAds();
        break;
      case AdType.INTERSTITIAL:
        initInterstitialAds();
        break;
      case AdType.REWARD:
        initRewardAds();
        break;
    }
  }

  initBannerAds() {
    admobBanner = AdmobBanner(
      adUnitId: AdmobUtil.getBannerAdUnitId(),
      adSize: AdmobBannerSize.BANNER,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        handleEvent(event, args, 'Banner');
      },
      onBannerCreated: (AdmobBannerController controller) {},
    );

    rewardAd?.load();
  }

  initRewardAds() {
    rewardAd = AdmobReward(
      adUnitId: AdmobUtil.getRewardBasedVideoAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd?.load();
        handleEvent(
          event,
          args,
          'Reward',
        );
      },
    );

    rewardAd?.load();
  }

  initInterstitialAds() {
    interstitialAd = AdmobInterstitial(
      adUnitId: AdmobUtil.getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd?.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd?.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: scaffoldKey.currentContext!,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    args != null
                        ? Text('Type: ${args['type']}')
                        : FxSpacing.empty(),
                    args != null
                        ? Text('Amount: ${args['amount']}')
                        : FxSpacing.empty(),
                  ],
                ),
              ),
              onWillPop: () async {
                scaffoldKey.currentState!.hideCurrentSnackBar();
                return true;
              },
            );
          },
        );
        break;
      default:
    }
  }

  void showInterstitialAd() async {
    if (interstitialAd != null && (await interstitialAd?.isLoaded) != null) {
      interstitialAd?.show();
    } else {
      showSnackBar('Interstitial ad is still loading...');
    }
  }

  void showRewardAds() async {
    if (rewardAd != null && (await rewardAd?.isLoaded) != null) {
      rewardAd?.show();
    } else {
      showSnackBar('Reward ad is still loading...');
    }
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    rewardAd?.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return 'admob_controller';
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
