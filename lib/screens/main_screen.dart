import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/theme_provide.dart';
import 'package:wallpaper_app/screens/cat_details.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/screens/photo_detail_screen.dart';
import 'package:wallpaper_app/screens/search_screen.dart';
import 'package:wallpaper_app/widgets/side_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class Cat {
  final String? id;
  final String? catName;
  final String? catImage;

  Cat({this.id, this.catName, this.catImage});
}

class _MainScreenState extends State<MainScreen> {
  var k = GlobalKey<ScaffoldState>();
  final searchText = TextEditingController();

  Future getTrending() async {
    var url = Uri.parse('https://api.pexels.com/v1/curated?per_page=20'
        // 'https://api.pexels.com/v1/search/?page=1&per_page=15&query=$catName'
        );
    final response = await http.get(url, headers: {
      'Authorization':
          '563492ad6f91700001000001f4005939620e47ab8c179a04d5d39306'
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data['photos'][0]['src']['large']);
      return data;
    }
  }

  List<Cat> img = [
    Cat(id: '1', catImage: 'assets/images/Nature.jpg', catName: 'Nature'),
    Cat(id: '2', catImage: 'assets/images/Space.jpg', catName: 'Space'),
    Cat(id: '4', catImage: 'assets/images/Macro.jpg', catName: 'Macro'),
    Cat(id: '5', catImage: 'assets/images/4k.jpg', catName: '4k'),
    Cat(id: '6', catImage: 'assets/images/Pro.jpg', catName: 'Pro'),
    Cat(
        id: '7',
        catImage: 'assets/images/WaterCraft.jpg',
        catName: 'Water Craft'),
    Cat(id: '8', catImage: 'assets/images/Flowers.jpg', catName: 'Flowers'),
    Cat(id: '9', catImage: 'assets/images/Vehicles.jpg', catName: 'Vehicles'),
    Cat(id: '10', catImage: 'assets/images/Ocean.jpg', catName: 'Ocean'),
    Cat(id: '11', catImage: 'assets/images/Avenue.jpg', catName: 'Avenue'),
    Cat(id: '12', catImage: 'assets/images/Lights.jpg', catName: 'Lights'),
    Cat(id: '13', catImage: 'assets/images/Food.jpg', catName: 'Food'),
    Cat(id: '14', catImage: 'assets/images/Candles.jpg', catName: 'Candles'),
    Cat(id: '16', catImage: 'assets/images/Fire.jpg', catName: 'Fire'),
    Cat(
        id: '17',
        catImage: 'assets/images/Reflections.jpg',
        catName: 'Reflections'),
    Cat(
        id: '18',
        catImage: 'assets/images/Aircrafts.jpg',
        catName: 'Aircrafts'),
    Cat(id: '19', catImage: 'assets/images/Winter.jpg', catName: 'Winter'),
    Cat(id: '20', catImage: 'assets/images/Animals.jpg', catName: 'Animals'),
  ];

  @override
  Widget build(BuildContext context) {
    var themeProviderData = context.read<ThemeProvider>();
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: k,
      // backgroundColor: Colors.amberAccent,
      drawer: SideDrawer(),
      body: SafeArea(
          // child:
          //     CustomScrollView(
          //   shrinkWrap: true,
          //   // scrollDirection: Axis.vertical,
          //   slivers: [
          //     const SliverAppBar(
          //         pinned: false,
          //         floating: false,
          //         expandedHeight: 300,
          //         flexibleSpace: FlexibleSpaceBar(
          //           background: Image(image: AssetImage('assets/images/bg.jpg')),
          //         )),
          //     SliverList(
          //         delegate: SliverChildListDelegate([
          //       Text(
          //         'LOKING FOR 4k',
          //         overflow: TextOverflow.ellipsis,
          //         style: GoogleFonts.lato(fontSize: 40),
          //       ),
          //       Text(
          //         'WALLPAPER?',
          //         style: GoogleFonts.lato(fontSize: 40),
          //       ),
          //       const TextField(
          //         style: TextStyle(color: Colors.black),
          //         decoration: InputDecoration(
          //           filled: true,
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(20.0),
          //             ),
          //           ),
          //           hintText: 'Search For Free Wallpaper',
          //           hintStyle: TextStyle(color: Colors.black),
          //           prefixIcon: Icon(
          //             Icons.search,
          //             color: Colors.black,
          //           ),
          //           fillColor: Color.fromARGB(255, 253, 253, 252),
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(30),
          //         child: Text(
          //           'WALLPAPERS',
          //           style: GoogleFonts.lato(
          //               color: Colors.black,
          //               fontWeight: FontWeight.w900,
          //               fontSize: 35),
          //         ),
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Popular Now...',
          //             style: GoogleFonts.lato(
          //                 color: Colors.black, fontWeight: FontWeight.w800),
          //           ),
          //           TextButton(onPressed: () {}, child: const Text('More'))
          //         ],
          //       ),
          //       CarouselSlider.builder(
          //           itemCount: img.length,
          //           itemBuilder: (context, index, b) {
          //             return Card(
          //               elevation: 10,
          //               child: Container(
          //                 // height: 180,
          //                 // width: 150,
          //                 padding: EdgeInsets.all(5),
          //                 decoration: BoxDecoration(
          //                     image: DecorationImage(
          //                         image: AssetImage(
          //                           img[index],
          //                         ),
          //                         fit: BoxFit.cover),
          //                     borderRadius: BorderRadius.all(Radius.circular(10))),
          //                 // child: Image(image: AssetImage(img[index])),
          //               ),
          //             );
          //           },
          //           options: CarouselOptions(
          //               enlargeCenterPage: true,
          //               autoPlay: true,
          //               autoPlayCurve: Curves.bounceInOut,
          //               aspectRatio: 2,
          //               scrollDirection: Axis.horizontal)),
          //       const SizedBox(
          //         height: 15,
          //       ),
          //       Text(
          //         'Categories',
          //         style: GoogleFonts.lato(
          //             color: Colors.black, fontWeight: FontWeight.w800),
          //       ),
          //       Container(
          //         height: 400,
          //         child: GridView.builder(
          //           scrollDirection: Axis.horizontal,
          //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 2,
          //             childAspectRatio: 50 / 80,
          //             crossAxisSpacing: 5,
          //             mainAxisSpacing: 5,
          //           ),
          //           itemBuilder: (context, index) {
          //             return GridTile(
          //               child: Card(
          //                 elevation: 5,
          //                 child: Image(
          //                   image: AssetImage(img[index]),
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //             );
          //           },
          //           itemCount: img.length,
          //         ),
          //       ),
          //       const Image(image: AssetImage('assets/images/img2.png'))
          //     ]))
          //   ],
          // )),

          child: Stack(
        children: [
          Image(
            height: h * 2,
            width: w,
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  k.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: themeProviderData.isDark ? Colors.white : Colors.white,
                )),
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
                  style: GoogleFonts.lato(
                      fontSize: 40,
                      color: themeProviderData.isDark
                          ? Colors.white
                          : Colors.white),
                ),
                Text(
                  'WALLPAPER?',
                  style: GoogleFonts.lato(
                    fontSize: 40,
                    color:
                        themeProviderData.isDark ? Colors.white : Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: w / 20,
            top: h / 4,
            width: w * .9,
            child: TextField(
              controller: searchText,
              onEditingComplete: () {
                print(searchText.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchScreen(
                    searchTxt: searchText.text,
                  );
                })).then((value) => searchText.clear());
              },
              style: TextStyle(
                  color:
                      themeProviderData.isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                hintText: 'Search For Free Wallpaper',
                hintStyle: TextStyle(
                    color:
                        themeProviderData.isDark ? Colors.white : Colors.black),
                prefixIcon: Icon(Icons.search,
                    color: themeProviderData.isDark
                        ? Color.fromARGB(255, 250, 249, 249)
                        : Color.fromARGB(255, 10, 10, 10)),
                fillColor: themeProviderData.isDark
                    ? Color.fromARGB(255, 3, 3, 3)
                    : Color.fromARGB(255, 253, 253, 252),
              ),
            ),
          ),
          Positioned(
            top: h / 3,
            child: Container(
              // color: themeProviderData.isDark ? Colors.black : Colors.white,
              padding: EdgeInsets.all(10),
              height: h / 1.5,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: themeProviderData.isDark ? Colors.black : Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'WALLPAPERS',
                        style: GoogleFonts.lato(
                            color: themeProviderData.isDark
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 35),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Now...',
                          style: GoogleFonts.lato(
                              color: themeProviderData.isDark
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                        // TextButton(onPressed: () {}, child: const Text('More'))
                      ],
                    ),
                    FutureBuilder(
                        future: getTrending(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SpinKitDoubleBounce(
                              color: Colors.red,
                            );
                          } else if (!snapshot.hasData) {
                            return Text('No data available');
                          }
                          return CarouselSlider.builder(
                              itemCount: snapshot.data['photos'].length,
                              itemBuilder: (context, index, b) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => PhotoDetailsScreen(
                                          picsList: snapshot.data['photos'],
                                          index: snapshot.data['photos'][index]
                                              ['id']),
                                    ));
                                  },
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      // height: 180,
                                      // width: 150,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                snapshot.data['photos'][index]
                                                    ['src']['medium']!,
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      // child: Image(image: AssetImage(img[index])),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  autoPlayCurve: Curves.bounceInOut,
                                  aspectRatio: 2,
                                  scrollDirection: Axis.horizontal));
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Categories',
                      style: GoogleFonts.lato(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                    Container(
                      height: h / 4,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 50 / 80,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CatDetails(cat: img[index]))),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(img[index].catImage!),
                                        fit: BoxFit.cover)),
                                child: Text(
                                  img[index].catName!,
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.black87),
                                ),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          );
                        },
                        itemCount: img.length,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
