import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/providers/provider.dart';
import 'package:wallpaper_app/providers/theme_provide.dart';
import 'package:wallpaper_app/screens/auto_wp_se.dart';
import 'package:wallpaper_app/screens/cat_details.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screens/downloads.dart';
import 'package:wallpaper_app/screens/splash.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'screens/main_screen.dart';
import 'package:path_provider/path_provider.dart' as path;

// callbackDispatcher() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager().executeTask((taskName, inputData) {
//     setAutoWallpaperFun();
//     return Future.value(true);
//   });
// }

// setAutoWallpaperFun() {
//   print('TESTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
//   List images = Directory(
//           '/storage/emulated/0/Android/data/com.shazlycode.wallpaper_app/files/downloades')
//       .listSync()
//       .map((e) => e.path)
//       .toList();
//   int id = Random().nextInt(images.length);
//   const location = WallpaperManagerFlutter.BOTH_SCREENS;

//   WallpaperManagerFlutter().setwallpaperfromFile(images[id], location);

//   print('IMAGES LENGTH===${images.length}');
// var dir = await path.getExternalStorageDirectory();

// List images = Directory('${path.getExternalStorageDirectory()}/downloades')
//     .listSync()
//     .map((e) => e.path)
//     .toList();
// int id = Random().nextInt(images.length);
// const location = WallpaperManagerFlutter.BOTH_SCREENS;

// WallpaperManagerFlutter().setwallpaperfromFile(File(images[id]), location);
// print(images[id]);
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  // Workmanager()
  //     .registerOneOffTask('2', '3', initialDelay: Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => WallpaperProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider())
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, tp, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  canvasColor: Color.fromARGB(255, 243, 238, 217),
                  iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
                  textTheme: TextTheme(
                      bodyText2: TextStyle(color: Color.fromARGB(255, 9, 8, 8)),
                      bodyText1:
                          TextStyle(color: Color.fromARGB(255, 10, 10, 10)))),
              darkTheme: ThemeData(
                  canvasColor: Colors.black,
                  iconTheme: IconThemeData(color: Colors.white),
                  textTheme: TextTheme(
                      bodyText2: TextStyle(color: Colors.white),
                      bodyText1: TextStyle(color: Colors.white))),
              themeMode: tp.isDark ? ThemeMode.dark : ThemeMode.light,
              home: Splash(),
              routes: {
                CatDetails.id: (context) => CatDetails(),
                DownloadsScreen.id: (context) => DownloadsScreen(),
              },
            );
          },
        ));
  }
}
