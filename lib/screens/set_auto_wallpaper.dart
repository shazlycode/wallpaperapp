import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:workmanager/workmanager.dart';

class SetAutoWallpaper extends StatefulWidget {
  const SetAutoWallpaper({Key? key, this.autoThemeImages, this.minutes})
      : super(key: key);
  final List? autoThemeImages;
  final int? minutes;

  void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) {
      setWallpaper();
      return Future.value(true);
    });
  }

  setWallpaper() {
    int index = Random().nextInt(autoThemeImages!.length - 1);

    const location = WallpaperManagerFlutter.BOTH_SCREENS;

    WallpaperManagerFlutter()
        .setwallpaperfromFile(File(autoThemeImages![index]), location);
  }

  @override
  State<SetAutoWallpaper> createState() => _SetAutoWallpaperState();
}

class _SetAutoWallpaperState extends State<SetAutoWallpaper> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Workmanager().initialize(widget.callbackDispatcher, isInDebugMode: true);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.autoThemeImages);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ElevatedButton(
            onPressed: () {
              Workmanager().registerOneOffTask('1', 'Auto Wallpaper',
                  initialDelay: Duration(seconds: widget.minutes!));
            },
            child: const Text('Set Auto Wallpaper')),
      )),
    );
  }
}
