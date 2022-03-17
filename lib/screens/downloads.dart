import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
    // TODO: implement didChangeDependencies
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
                  Shadow(
                      color: Color.fromARGB(255, 116, 2, 2),
                      blurRadius: 2,
                      offset: Offset(2, 3))
                ]),
              ),
              Text('Downloads',
                  style: GoogleFonts.anton(
                      fontSize: 30,
                      shadows: [
                        Shadow(
                            color: Color.fromARGB(255, 116, 2, 2),
                            blurRadius: 2,
                            offset: Offset(2, 3))
                      ],
                      color: Colors.blue[700])),
            ],
          ),
        ),
        drawer: SideDrawer(),
        body: SafeArea(
            child: _isLoading
                ? Center(
                    child: SpinKitCircle(color: Colors.red),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemCount: dwonloadsData.imagesList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => SavedImageView(
                                      image: File(
                                          dwonloadsData.imagesList[index])))));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                  image: FileImage(File(
                                    dwonloadsData.imagesList[index],
                                  )),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    })));

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
