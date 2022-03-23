import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/providers/provider.dart';
import 'package:wallpaper_app/screens/auto_wp_se.dart';
import 'package:wallpaper_app/screens/cat_details.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screens/downloads.dart';
import 'package:wallpaper_app/screens/splash.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WallpaperProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(
                bodyText2: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white))),
        home: Splash(),
        routes: {
          CatDetails.id: (context) => CatDetails(),
          DownloadsScreen.id: (context) => DownloadsScreen(),
        },
      ),
    );
  }
}
