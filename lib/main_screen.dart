import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image(
            height: h,
            width: w,
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.horizontal_split_rounded)),
          ),
          Positioned(
            top: h / 10,
            left: w / 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LOKING FOR 4k',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(fontSize: 40),
                ),
                Text(
                  'WALLPAPER?',
                  style: GoogleFonts.lato(fontSize: 40),
                )
              ],
            ),
          ),
          Positioned(
            left: w / 20,
            top: h / 4,
            width: w * .9,
            child: const TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                hintText: 'Search For Free Wallpaper',
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                fillColor: Color.fromARGB(255, 253, 253, 252),
              ),
            ),
          ),
          Positioned(
            top: h / 2.5,
            child: Container(
              height: h,
              width: w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'WALLPAPERS',
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 35),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
