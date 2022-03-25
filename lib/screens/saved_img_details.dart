import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/theme_provide.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class Option {
  final int? id;
  final String? txt;
  final IconData? icon;

  Option({this.id, this.txt, this.icon});
}

class SavedImageView extends StatefulWidget {
  const SavedImageView({Key? key, this.image}) : super(key: key);
  final File? image;
  @override
  State<SavedImageView> createState() => _SavedImageViewState();
}

class _SavedImageViewState extends State<SavedImageView> {
  var _isLoading = false;

  List<dynamic> optionList = [
    Option(id: 1, icon: Icons.home_max_outlined, txt: 'Set to home screen'),
    Option(id: 2, icon: Icons.lock_outline, txt: 'Set to lock screen'),
    Option(
        id: 3,
        icon: Icons.add_to_home_screen_outlined,
        txt: 'Set to home and lock screen'),
    // Option(id: 4, icon: Icons.download_outlined, txt: 'Download'),
    Option(id: 4, icon: Icons.close_rounded, txt: 'Close'),
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<ThemeProvider>();

    Future setHomeScreen(File imgFile) async {
      await showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  color: themeData.isDark ? Colors.black : Colors.white,
                  height: 300,
                  width: 300,
                  child: SpinKitWave(
                    color: Color.fromARGB(255, 246, 54, 6),
                    size: 50.0,
                  )),
            );
          });
      const location = WallpaperManagerFlutter.HOME_SCREEN;

      await WallpaperManagerFlutter().setwallpaperfromFile(imgFile, location);
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Wallpaper set successfully')));
    }

    Future<void> setLockScreen(File imgFile) async {
      setState(() {
        _isLoading = true;
      });
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  color: themeData.isDark ? Colors.black : Colors.white,
                  height: 300,
                  width: 300,
                  child: SpinKitWave(
                    color: Color.fromARGB(255, 246, 54, 6),
                    size: 50.0,
                  )),
            );
          });
      const location = WallpaperManagerFlutter.LOCK_SCREEN;

      await WallpaperManagerFlutter().setwallpaperfromFile(imgFile, location);
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Wallpaper set successfully')));
      setState(() {
        _isLoading = false;
      });
    }

    Future<void> setBothScreen(File imgFile) async {
      setState(() {
        _isLoading = true;
      });

      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  color: themeData.isDark ? Colors.black : Colors.white,
                  height: 300,
                  width: 300,
                  child: SpinKitWave(
                    color: Color.fromARGB(255, 246, 54, 6),
                    size: 50.0,
                  )),
            );
          });
      const location = WallpaperManagerFlutter.BOTH_SCREENS;

      await WallpaperManagerFlutter().setwallpaperfromFile(imgFile, location);
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Wallpaper set successfully')));
      setState(() {
        _isLoading = false;
      });
    }

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                  widget.image!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              right: 30,
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor:
                          themeData.isDark ? Colors.black : Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (context) => _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              height: 300,
                              child: ListView(
                                  children: optionList
                                      .map((e) => ListTile(
                                            onTap: e.id == 1
                                                ? () {
                                                    setHomeScreen(
                                                        widget.image!);
                                                  }
                                                : e.id == 2
                                                    ? () {
                                                        setLockScreen(
                                                            widget.image!);
                                                      }
                                                    : e.id == 3
                                                        ? () {
                                                            setBothScreen(
                                                                widget.image!);
                                                          }
                                                        : e.id == 4
                                                            ? () =>
                                                                Navigator.pop(
                                                                    context)
                                                            : null,
                                            leading: Icon(
                                              e.icon,
                                              color: themeData.isDark
                                                  ? Color(0xffadff02)
                                                  : Colors.black,
                                            ),
                                            title: Text(
                                              e.txt,
                                              style: TextStyle(
                                                color: themeData.isDark
                                                    ? Color(0xffadff02)
                                                    : Colors.black,
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
                  Icons.download_for_offline_rounded,
                  color: themeData.isDark ? Color(0xffadff02) : Colors.white,
                  size: 35,
                ),
              )),
        ],
      )),
    );
  }
}
