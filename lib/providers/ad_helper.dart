import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4877259958230721/5738207957';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4877259958230721/5738207957';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4877259958230721/1798962940";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4877259958230721/1798962940";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4877259958230721/4189037157";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4877259958230721/4189037157";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
