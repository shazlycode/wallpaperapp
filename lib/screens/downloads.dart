import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/ad_helper.dart';
import 'package:wallpaper_app/providers/provider.dart';
import 'package:wallpaper_app/screens/saved_img_details.dart';
import 'package:wallpaper_app/widgets/side_drawer.dart';

class DownloadsScreen extends StatefulWidget {
  static const String id = 'downloads';
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  var k = GlobalKey<ScaffoldState>();

  var _isLoading = false;
  var isInit = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit == true) {
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

  @override
  Widget build(BuildContext context) {
    final dwonloadsData = context.read<WallpaperProvider>();
    print(dwonloadsData.imagesList.length);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My ',
                style: GoogleFonts.anton(fontSize: 30, shadows: [
                  const Shadow(
                      color: Color.fromARGB(255, 116, 2, 2),
                      blurRadius: 2,
                      offset: Offset(2, 3))
                ]),
              ),
              Text('Downloads',
                  style: GoogleFonts.anton(
                      fontSize: 30,
                      shadows: [
                        const Shadow(
                            color: Color.fromARGB(255, 116, 2, 2),
                            blurRadius: 2,
                            offset: Offset(2, 3))
                      ],
                      color: Colors.blue[700])),
            ],
          ),
        ),
        drawer: const SideDrawer(),
        body: SafeArea(
            child: _isLoading
                ? const Center(
                    child: SpinKitCircle(color: Colors.red),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 2 / 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: dwonloadsData.imagesList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Delete Wallpaper!!!'),
                                          content: const Text(
                                              'Are you sure you want to delete wallpaper?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('NO')),
                                            IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<WallpaperProvider>()
                                                      .deleteImageFile(
                                                          dwonloadsData
                                                                  .imagesList[
                                                              index]);
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        );
                                      });
                                },
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                          builder: (context) => SavedImageView(
                                              image: File(dwonloadsData
                                                  .imagesList[index])))));
                                  _loadInterstitialAd();
                                  _interstitialAd?.show();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      image: DecorationImage(
                                          image: FileImage(File(
                                            dwonloadsData.imagesList[index],
                                          )),
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
                  )));

    //         FutureBuilder(
    //   future: dwonloadsData.getDownloadDirAndFetchImages(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return SpinKitCircle(
    //         color: Colors.redAccent,
    //       );
    //     }
    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: Text('No wallpaper available now!!!'),
    //       );
    //     }
    //     return GridView.builder(
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 3,
    //             childAspectRatio: 3 / 2,
    //             crossAxisSpacing: 5,
    //             mainAxisSpacing: 5),
    //         itemCount: dwonloadsData.imagesList.length,
    //         itemBuilder: (context, index) {
    //           return Image.file(File(dwonloadsData.imagesList[index]));
    //         });
    //   },
    // )));
  }
}
