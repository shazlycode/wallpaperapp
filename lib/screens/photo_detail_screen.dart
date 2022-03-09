import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

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

  Future setHomeScreen(String imgUrl) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                color: Colors.black,
                height: 300,
                width: 300,
                child: SpinKitWave(
                  color: Color.fromARGB(255, 246, 54, 6),
                  size: 50.0,
                )),
          );
        });
    var location = WallpaperManagerFlutter.HOME_SCREEN;
    final file = await DefaultCacheManager().getSingleFile(imgUrl);
    await WallpaperManagerFlutter()
        .setwallpaperfromFile(File(file.path), location);

    Navigator.pop(context);
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Wallpaper set successfully')));
  }

  Future setLockScreen(String imgUrl) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                color: Colors.black,
                height: 300,
                width: 300,
                child: SpinKitWave(
                  color: Color.fromARGB(255, 246, 54, 6),
                  size: 50.0,
                )),
          );
        });
    var location = WallpaperManagerFlutter.LOCK_SCREEN;
    final file = await DefaultCacheManager().getSingleFile(imgUrl);
    await WallpaperManagerFlutter()
        .setwallpaperfromFile(File(file.path), location);
    Navigator.pop(context);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wallpaper set successfully')));
  }

  Future setBothScreens(String imgUrl) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                color: Colors.black,
                height: 300,
                width: 300,
                child: SpinKitWave(
                  color: Color.fromARGB(255, 246, 54, 6),
                  size: 50.0,
                )),
          );
        });
    var location = WallpaperManagerFlutter.BOTH_SCREENS;
    final file = await DefaultCacheManager().getSingleFile(imgUrl);
    await WallpaperManagerFlutter()
        .setwallpaperfromFile(File(file.path), location);
    Navigator.pop(context);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wallpaper set successfully')));
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

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
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.picsList![index]['alt']),
                          )),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.black,
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
                                                                    : e.id == 3
                                                                        ? () {
                                                                            setBothScreens(widget.picsList![index]['src']['large2x']);
                                                                          }
                                                                        : null,
                                                            leading: Icon(
                                                              e.icon,
                                                              color: Color(
                                                                  0xffadff02),
                                                            ),
                                                            title: Text(
                                                              e.txt,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffadff02)),
                                                            ),
                                                          ))
                                                      .toList()),
                                            ));
                                  // Scaffold.of(context)
                                  //     .showBottomSheet((context) => Container(
                                  //           height: 300,
                                  //         ));
                                },
                                icon: Icon(Icons.download_outlined)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.favorite))
                          ],
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