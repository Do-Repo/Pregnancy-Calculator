// ignore_for_file: avoid_print

import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);

  String get homeBannerAd => Platform.isAndroid
      ? "ca-app-pub-1311318327446054/3002087804"
      : "To implement for ios";

  String get lessonBannerAd => Platform.isAndroid
      ? "ca-app-pub-1311318327446054/3316555522"
      : "To implement for ios";

  String get interstitial => Platform.isAndroid
      ? "ca-app-pub-1311318327446054/3596984175"
      : "To implement for ios";

  String get interstitialPresent => Platform.isAndroid
      ? "ca-app-pub-1311318327446054/9013419542"
      : "To implement for ios";

  String get interstitialQuiz => Platform.isAndroid
      ? "ca-app-pub-1311318327446054/6195684515"
      : "To implement for ios";

  String get rewardedAd => Platform.isAndroid
      ? "ca-app-pub-1311318327446054/5177830909"
      : "To implement for ios";

  BannerAdListener get bannerAdListener => _bannerAdListener;

  final BannerAdListener _bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad loaded: ${ad.adUnitId} '),
    onAdClosed: (ad) => print('Ad closed: ${ad.adUnitId} '),
    onAdFailedToLoad: (ad, error) {
      print('Ad failed to load ${ad.adUnitId}, $error ');
      ad.dispose();
    },
    onAdOpened: (ad) => print('Ad opened: ${ad.adUnitId} '),
  );
}
