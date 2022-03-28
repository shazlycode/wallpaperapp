import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/ad_helper.dart';
import 'package:wallpaper_app/providers/provider.dart';
import 'package:wallpaper_app/providers/theme_provide.dart';
import 'package:wallpaper_app/screens/set_auto_wallpaper.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'package:path_provider/path_provider.dart' as path;

class AutoWallpaperSettings extends StatefulWidget {
  const AutoWallpaperSettings({Key? key}) : super(key: key);

  @override
  State<AutoWallpaperSettings> createState() => _AutoWallpaperSettingsState();
}

class _AutoWallpaperSettingsState extends State<AutoWallpaperSettings> {
  var minutes;

  late BannerAd _bannerAd;
// TODO: Add _bannerAd

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();

    _initGoogleMobileAds();

    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _loadRewardedAd();

    _bannerAd.load();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd?.dispose();
    _rewardedAd.dispose();

    super.dispose();
  }

// TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // _moveToHome();
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

// TODO: Add _rewardedAd
  late RewardedAd _rewardedAd;

  // TODO: Add _isRewardedAdReady
  bool _isRewardedAdReady = false;

  // TODO: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  final List<DropdownMenuItem> _dDMI = [
    const DropdownMenuItem(
      child: Text('1 Minutes',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 1,
    ),
    const DropdownMenuItem(
      child: Text('15 Minutes',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 15,
    ),
    const DropdownMenuItem(
      child: Text('30 Minutes',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 30,
    ),
    const DropdownMenuItem(
      child: Text('1 Hour',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 60,
    ),
    const DropdownMenuItem(
      child: Text('2 Hours',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 120,
    ),
    const DropdownMenuItem(
      child: Text('6 Hours',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 360,
    ),
    const DropdownMenuItem(
      child: Text('12 Hours',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 720,
    ),
    const DropdownMenuItem(
      child: Text('1 Day',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 1440,
    ),
    const DropdownMenuItem(
      child: Text('3 days',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 4320,
    ),
  ];
  var isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      setState(() {
        _isLoading = true;
      });
      await context.read<WallpaperProvider>().getDownloadDirAndFetchImages();

      setState(() {
        _isLoading = false;
      });
    }
    isInit = false;
  }

  // setAutoWallpaper() async {
  // print(isDone);

  //   Workmanager().registerOneOffTask('uniqueName', 'taskName',
  //       initialDelay: Duration(seconds: 1));
  // }

  // setWallpaper() {
  //   Timer.periodic(Duration(minutes: minutes), (timer) {
  //     setWallPaper();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final wallpaperProviderData = context.read<WallpaperProvider>();

    setAutoWallpaper() async {
      var wpList = context.read<WallpaperProvider>().autoThemeImages;
      print(wpList[1]);
      Timer.periodic(Duration(minutes: minutes), (timer) async {
        int index = Random().nextInt(wpList.length);
        const location = WallpaperManagerFlutter.BOTH_SCREENS;
        await WallpaperManagerFlutter()
            .setwallpaperfromFile(File(wpList[index]), location);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper Settings'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Caution!!!'),
                        content: Text(
                            'You should keep the app running in the background.'),
                        actions: [
                          ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('No')),
                          ElevatedButton(
                              onPressed: () {
                                if (minutes == null) {
                                  return;
                                }
                                _loadInterstitialAd();
                                _interstitialAd?.show();
                                setAutoWallpaper();
                                Navigator.pop(context);
                              },
                              child: Text('Ok')),
                        ],
                      );
                    });
                // Workmanager().registerOneOffTask('uniqueName', 'taskName',
                //     initialDelay: Duration(seconds: 1));
                // print('DONEEEEEEEEEEEEEEEEEEE');
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Select Duration'),
                DropdownButton(
                    value: minutes,
                    dropdownColor: Color.fromARGB(255, 115, 10, 10),
                    hint: Text(
                      'Select interval',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    items: _dDMI
                        .map((e) => DropdownMenuItem(
                              child: e.child,
                              value: e.value,
                            ))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        minutes = v;
                      });
                      print(minutes);
                    }),
              ],
            ),
            _isLoading
                ? Center(
                    child: SpinKitCircle(color: Colors.red),
                  )
                : Expanded(
                    child: GridView.builder(
                        itemCount: wallpaperProviderData.imagesList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                context
                                    .read<WallpaperProvider>()
                                    .addToAutoThemeImages(wallpaperProviderData
                                        .imagesList[index]);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          wallpaperProviderData
                                              .imagesList[index],
                                        ),
                                      ),
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(context
                                                  .read<WallpaperProvider>()
                                                  .getIseSelected(
                                                      wallpaperProviderData
                                                          .imagesList[index])
                                              ? 1
                                              : 0),
                                          BlendMode.color),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        }),
                  ),
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
