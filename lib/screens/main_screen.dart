import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wallpaper_app/screens/cat_details.dart';

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

  List<Cat> img = [
    Cat(id: '1', catImage: 'assets/images/img2.png', catName: 'nature'),
    Cat(id: '2', catImage: 'assets/images/img3.png', catName: 'graphic'),
    Cat(id: '1', catImage: 'assets/images/bg.jpg', catName: 'photography'),
    Cat(id: '1', catImage: 'assets/images/img2.png', catName: 'animals'),
    Cat(id: '1', catImage: 'assets/images/img3.png', catName: 'hd'),
  ];
  @override
  Widget build(BuildContext context) {
    // final _scaffold = Scaffold.of(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: k,
      // backgroundColor: Colors.amberAccent,
      drawer: Drawer(),
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
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  k.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu)),
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
            top: h / 3,
            child: Container(
              padding: EdgeInsets.all(10),
              height: h / 1.5,
              width: w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
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
                            color: Colors.black,
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
                              color: Colors.black, fontWeight: FontWeight.w800),
                        ),
                        TextButton(onPressed: () {}, child: const Text('More'))
                      ],
                    ),
                    CarouselSlider.builder(
                        itemCount: img.length,
                        itemBuilder: (context, index, b) {
                          return Card(
                            elevation: 10,
                            child: Container(
                              // height: 180,
                              // width: 150,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        img[index].catImage!,
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              // child: Image(image: AssetImage(img[index])),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayCurve: Curves.bounceInOut,
                            aspectRatio: 2,
                            scrollDirection: Axis.horizontal)),
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
                              child: Image(
                                image: AssetImage(img[index].catImage!),
                                fit: BoxFit.cover,
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
