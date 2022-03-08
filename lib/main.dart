import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/cat_details.dart';

import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainScreen(),
      routes: {
        CatDetails.id: (context) => CatDetails(),
      },
    );
  }
}
