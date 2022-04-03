import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/screens/photo_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.searchTxt}) : super(key: key);
  final String? searchTxt;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future search(String searchText) async {
    if (searchText.contains('sex') ||
        searchText.contains('porno') ||
        searchText.contains('porn') ||
        searchText.contains('hot')) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Safe Search is ON...')));
      return;
    }
    var url = Uri.parse(
        'https://api.pexels.com/v1/search?query=$searchText&per_page=80'
        // 'https://api.pexels.com/v1/search/?page=1&per_page=15&query=$catName'
        );
    final response = await http.get(url, headers: {
      'Authorization':
          '563492ad6f91700001000001f4005939620e47ab8c179a04d5d39306'
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['photos'][0]['src']['large']);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder(
                future: search(widget.searchTxt!),
                builder: (context, AsyncSnapshot? snapshot) {
                  if (snapshot!.connectionState == ConnectionState.waiting) {
                    return SpinKitPianoWave(
                      color: Colors.red,
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('No wallpaper available'),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemCount: snapshot.data['photos'].length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PhotoDetailsScreen(
                              picsList: snapshot.data['photos'],
                              index: snapshot.data['photos'][index]['id'],
                            );
                          }));
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                // boxShadow: [
                                //   BoxShadow(
                                //       spreadRadius: 2,
                                //       offset: Offset(5, 2),
                                //       color: Colors.blue,
                                //       blurRadius: 3),
                                //   BoxShadow(
                                //       spreadRadius: 2,
                                //       offset: Offset(5, 2),
                                //       color: Colors.blue,
                                //       blurRadius: 3)
                                // ],
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data['photos']
                                        [index]['src']['medium']),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      );
                    },
                  );
                })));
  }
}
