import 'package:flutkit_feature/features/admob/banner_ads.dart';
import 'package:flutkit_feature/features/admob/interstitial_ads.dart';
import 'package:flutkit_feature/features/admob/reward_ads.dart';
import 'package:flutkit_feature/features/create_shortcut/create_shortcut_screen.dart';
import 'package:flutkit_feature/features/firebase/views/forgot_password_screen.dart';
import 'package:flutkit_feature/features/firebase/views/login_screen.dart';
import 'package:flutkit_feature/features/firebase/views/register_screen.dart';
import 'package:flutkit_feature/features/firebase/views/user_screen.dart';
import 'package:flutkit_feature/features/google_auth/google_auth_screen.dart';
import 'package:flutkit_feature/features/http_request/get_request_screen.dart';
import 'package:flutkit_feature/features/http_request/post_request_screen.dart';
import 'package:flutkit_feature/features/image_cropper/image_cropper_screen.dart';
import 'package:flutkit_feature/features/razorpay/razorpay_payment_screen.dart';
import 'package:flutkit_feature/features/shimmer/loading_shimmer_effect.dart';
import 'package:flutkit_feature/features/url_launcher/url_launcher_screen.dart';
import 'package:flutkit_feature/features/video_player/video_screen.dart';
import 'package:flutkit_feature/features/web_view/web_view_screen.dart';
import 'package:flutkit_feature/homes/single_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class FeaturesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ListView(
      padding: FxSpacing.zero,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        GridView.count(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            crossAxisCount: 2,
            padding: FxSpacing.nTop(20),
            mainAxisSpacing: 20,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            children: <Widget>[
              SingleGridItem(
                  title: "Admob",
                  icon: './assets/icons/admob.png',
                  items: [
                    SinglePageItem(
                      icon: './assets/icons/admob.png',
                      title: "Admob Interstitial",
                      navigation: InterstitialAds(
                        refUrl: 'https://pub.dev/packages/admob_flutter',
                      ),
                    ),
                    SinglePageItem(
                      icon: './assets/icons/admob.png',
                      title: "Admob Reward",
                      navigation: RewardAds(
                        refUrl: 'https://pub.dev/packages/admob_flutter',
                      ),
                    ),
                    SinglePageItem(
                      icon: './assets/icons/admob.png',
                      title: "Admob Banner",
                      navigation: BannerAds(
                        refUrl: 'https://pub.dev/packages/admob_flutter',
                      ),
                    ),
                  ]),
              SingleGridItem(
                title: "Firebase",
                icon: './assets/icons/firebase.png',
                items: [
                  SinglePageItem(
                    icon: './assets/icons/firebase.png',
                    title: "Home",
                    navigation: FirebaseUserScreen(),
                  ),
                  SinglePageItem(
                    icon: './assets/icons/firebase.png',
                    title: "Login",
                    navigation: FirebaseLoginScreen(),
                  ),
                  SinglePageItem(
                    icon: './assets/icons/firebase.png',
                    title: "Register",
                    navigation: FirebaseRegisterScreen(),
                  ),
                  SinglePageItem(
                    icon: './assets/icons/firebase.png',
                    title: "Forgot Password",
                    navigation: FirebaseForgotPasswordScreen(),
                  ),
                ],
              ),
              SingleGridItem(
                title: "Request",
                icon: './assets/icons/request.png',
                items: [
                  SinglePageItem(
                    icon: './assets/icons/request.png',
                    title: "GET",
                    navigation: GetRequestScreen(),
                  ),
                  SinglePageItem(
                    icon: './assets/icons/request.png',
                    title: "POST",
                    navigation: PostRequestScreen(),
                  ),
                ],
              ),
              SinglePageItem(
                icon: './assets/icons/web_view.png',
                title: "Web View",
                navigation: WebViewScreen(
                  refUrl: 'https://pub.dev/packages/webview_flutter',
                ),
              ),
              SinglePageItem(
                icon: './assets/icons/image_crop.png',
                title: "Image Cropper",
                navigation: ImageCropperScreen(
                  refUrl: 'https://pub.dev/packages/image_cropper',
                ),
              ),
              SinglePageItem(
                icon: './assets/icons/google.png',
                title: "Google SignIn",
                navigation: GoogleAuthScreen(
                  refUrl: 'https://pub.dev/packages/google_sign_in',
                ),
              ),
              SinglePageItem(
                icon: './assets/icons/quick_action.png',
                title: "Quick Actions",
                navigation: CreateShortcutScreen(
                  refUrl: 'https://pub.dev/packages/quick_actions',
                ),
              ),
              SinglePageItem(
                icon: './assets/icons/razorpay.png',
                title: "Razorpay Payment",
                navigation: RazorpayPaymentScreen(
                  refUrl: 'https://pub.dev/packages/razorpay_flutter',
                ),
              ),
              SinglePageItem(
                icon: './assets/icons/shimmer.png',
                title: "Shimmer Loading",
                navigation: LoadingShimmerEffect(
                  refUrl: 'https://pub.dev/packages/shimmer',
                ),
              ),
              SinglePageItem(
                icon: './assets/icons/url_launcher.png',
                title: "URL Launcher",
                navigation: UrlLauncherScreen(
                  refUrl: 'https://pub.dev/packages/url_launcher',
                ),
              ),
              SinglePageItem(
                icon: './assets/icons/video_player.png',
                title: "Video Player",
                navigation: VideoScreen(
                  refUrl: 'https://pub.dev/packages/video_player',
                ),
              ),
            ]),
        Container(
          margin: FxSpacing.y(16),
          child: Center(
            child: FxText("More Integrations are coming soon..."),
          ),
        )
      ],
    );
  }
}
