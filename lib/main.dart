import 'package:flutter/material.dart';
import 'package:wallpaper_app/providers/provider.dart';
import 'package:wallpaper_app/screens/cat_details.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screens/downloads.dart';
import 'screens/main_screen.dart';

void main() {
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
        home: MainScreen(),
        routes: {
          CatDetails.id: (context) => CatDetails(),
          DownloadsScreen.id: (context) => DownloadsScreen(),
        },
      ),
    );
  }
}
