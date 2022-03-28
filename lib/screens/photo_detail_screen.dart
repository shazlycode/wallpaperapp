import 'dart:io';
import 'package:dio/dio.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/ad_helper.dart';
import 'package:wallpaper_app/providers/theme_provide.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';

class PhotoDetailsScreen extends StatefulWidget {
  final List<dynamic>? picsList;
  final int? index;

  const PhotoDetailsScreen({Key? key, this.picsList, this.index})
      : super(key: key);

  @override
  State<PhotoDetailsScreen> createState() => _PhotoDetailsScreenState();
}

class Option {
  final int? id;
  final String? txt;
  final IconData? icon;

  Option({this.id, this.txt, this.icon});
}

class _PhotoDetailsScreenState extends State<PhotoDetailsScreen> {
  List<dynamic> optionList = [
    Option(id: 1, icon: Icons.home_max_outlined, txt: 'Set to home screen'),
    Option(id: 2, icon: Icons.lock_outline, txt: 'Set to lock screen'),
    Option(
        id: 3,
        icon: Icons.add_to_home_screen_outlined,
        txt: 'Set to home and lock screen'),
    Option(id: 4, icon: Icons.download_outlined, txt: 'Download'),
    Option(id: 5, icon: Icons.close_rounded, txt: 'Close'),
  ];
  var _isLoading = false;

// TODO: Add _rewardedAd
  late RewardedAd _rewardedAd;

  // TODO: Add _isRewardedAdReady
  bool _isRewardedAdReady = false;

  // TODO: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this._rewardedAd = ad;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRewardedAd();
  }

  @override
  void dispose() {
    // TODO: Dispose a RewardedAd object
    _rewardedAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themData = context.read<ThemeProvider>();

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    Future setHomeScreen(String imgUrl) async {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  color: themData.isDark ? Colors.black : Colors.white,
                  height: 300,
                  width: 300,
                  child: SpinKitWave(
                    color: Color.fromARGB(255, 246, 54, 6),
                    size: 50.0,
                  )),
            );
          });
      _loadRewardedAd();
      if (_isRewardedAdReady) {
        _rewardedAd.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
          var location = WallpaperManagerFlutter.HOME_SCREEN;
          final file = await DefaultCacheManager().getSingleFile(imgUrl);
          await WallpaperManagerFlutter()
              .setwallpaperfromFile(File(file.path), location);

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Wallpaper set successfully')));
        });
      }
      Navigator.pop(context);
    }

    Future setLockScreen(String imgUrl) async {
      _loadRewardedAd();
      if (_isRewardedAdReady) {
        _rewardedAd.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          //
        });
      }
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  color: themData.isDark ? Colors.black : Colors.white,
                  height: 300,
                  width: 300,
                  child: SpinKitWave(
                    color: Color.fromARGB(255, 246, 54, 6),
                    size: 50.0,
                  )),
            );
          });
      _loadRewardedAd();
      if (_isRewardedAdReady) {
        _rewardedAd.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
          var location = WallpaperManagerFlutter.LOCK_SCREEN;
          final file = await DefaultCacheManager().getSingleFile(imgUrl);
          await WallpaperManagerFlutter()
              .setwallpaperfromFile(File(file.path), location);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Wallpaper set successfully')));
        });
      }
      Navigator.pop(context);
    }

    Future setBothScreens(String imgUrl) async {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  color: themData.isDark ? Colors.black : Colors.white,
                  height: 300,
                  width: 300,
                  child: SpinKitWave(
                    color: Color.fromARGB(255, 246, 54, 6),
                    size: 50.0,
                  )),
            );
          });
      _loadRewardedAd();
      if (_isRewardedAdReady) {
        _rewardedAd.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
          var location = WallpaperManagerFlutter.BOTH_SCREENS;
          final file = await DefaultCacheManager().getSingleFile(imgUrl);
          await WallpaperManagerFlutter()
              .setwallpaperfromFile(File(file.path), location);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Wallpaper set successfully')));
        });
      }
      Navigator.pop(context);
    }

    Directory? appDir;
    Future<File?> downloadImage(String imgUrl, String fileName) async {
      try {
        // final appDir = await path.getApplicationDocumentsDirectory();
        var dir = await getExternalStorageDirectory();
        appDir = Directory('${dir!.path}/downloades');
        if (!appDir!.existsSync()) {
          await appDir!.create();
        }

        final file = File('${appDir!.path}/$fileName');
        final response = await Dio().get(imgUrl,
            options: Options(
                followRedirects: false,
                receiveTimeout: 0,
                responseType: ResponseType.bytes));
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
        await GallerySaver.saveImage(file.path);
        return file;
      } catch (err) {
        print(err);
        return null;
      }
    }

    Future<void> openImage(String imgUrl) async {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  color: themData.isDark ? Colors.black : Colors.white,
                  height: 300,
                  width: 300,
                  child: SpinKitWave(
                    color: Color.fromARGB(255, 246, 54, 6),
                    size: 50.0,
                  )),
            );
          });

      _loadRewardedAd();
      if (_isRewardedAdReady) {
        _rewardedAd.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
          String? fileName = 'wallpaperapp${DateTime.now()}.jpg';
          var imgFile = await downloadImage(imgUrl, fileName);
          if (imgFile == null) {
            return;
          }
          print('PATH= ${imgFile.path}');

          await OpenFile.open(imgFile.path);

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Wallpaper downloaded Successfully')));
        });
      }
      Navigator.pop(context);
    }

    return Scaffold(
      body: CarouselSlider.builder(
          itemCount: widget.picsList!.length,
          itemBuilder: (context, index, f) {
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: h,
                width: w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.picsList![index]['src']['large']),
                        fit: BoxFit.cover)),
                child: Container(
                  height: h,
                  width: w,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Column(
                            children: [
                              IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: themData.isDark
                                            ? Colors.black
                                            : Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        context: context,
                                        builder: (context) => _isLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Container(
                                                height: 300,
                                                child: ListView(
                                                    children: optionList
                                                        .map((e) => ListTile(
                                                              onTap: e.id == 1
                                                                  ? () {
                                                                      setHomeScreen(widget.picsList![index]
                                                                              [
                                                                              'src']
                                                                          [
                                                                          'large2x']);
                                                                    }
                                                                  : e.id == 2
                                                                      ? () {
                                                                          setLockScreen(widget.picsList![index]['src']
                                                                              [
                                                                              'large2x']);
                                                                        }
                                                                      : e.id ==
                                                                              3
                                                                          ? () {
                                                                              setBothScreens(widget.picsList![index]['src']['large2x']);
                                                                            }
                                                                          : e.id == 4
                                                                              ? () {
                                                                                  openImage(widget.picsList![index]['src']['large2x']);
                                                                                }
                                                                              : e.id == 5
                                                                                  ? () => Navigator.pop(context)
                                                                                  : null,
                                                              leading: Icon(
                                                                e.icon,
                                                                color: themData
                                                                        .isDark
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            172,
                                                                            231,
                                                                            112)
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                              title: Text(
                                                                e.txt,
                                                                style:
                                                                    TextStyle(
                                                                  color: themData
                                                                          .isDark
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          172,
                                                                          231,
                                                                          112)
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList()),
                                              ));
                                    // Scaffold.of(context)
                                    //     .showBottomSheet((context) => Container(
                                    //           height: 300,
                                    //         ));
                                  },
                                  icon: Icon(
                                    Icons.download_outlined,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
          options: CarouselOptions(
            // aspectRatio: ,
            autoPlay: false,
            initialPage: widget.picsList!
                .indexWhere((element) => element['id'] == widget.index),
            height: h,
            scrollDirection: Axis.vertical,
          )),
    );
  }
}
