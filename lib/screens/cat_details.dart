import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/screens/main_screen.dart';

class CatDetails extends StatefulWidget {
  static const String id = 'cat_details';
  final Cat? cat;

  const CatDetails({Key? key, this.cat}) : super(key: key);
  @override
  State<CatDetails> createState() => _CatDetailsState();
}

class _CatDetailsState extends State<CatDetails> {
  Future getCatItems(String catName) async {
    var url = Uri.parse(
        'https://api.pexels.com/v1/search/?page=1&per_page=15&query=$catName');
    final response = await http.get(url);
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
          future: getCatItems(widget.cat!.catName!),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            print(snapshot.data['photos'].length);

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(widget.cat!.catImage!),
                  )),
                ),
                SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    delegate: SliverChildListDelegate(
                        (snapshot.data['photos'] as List)
                            .map((e) => Card(
                                  elevation: 5,
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(e['src']['large'])),
                                ))
                            .toList()))
                // GridView.builder(
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       childAspectRatio: 50 / 80,
                //       crossAxisSpacing: 5,
                //       mainAxisSpacing: 5,
                //     ),
                //     itemCount: snapshot.data['photos'].length,
                //     itemBuilder: (context, index) {
                //       print(snapshot.data['photos'].length);
                //       return Card(
                //         child: Image(
                //             image: AssetImage(
                //                 snapshot.data['photos'][index]['src']['larg'])),
                //       );
                //     })
              ],
            );
          }),
    ));
  }
}


  //  SliverList(
  //                   delegate: SliverChildListDelegate(
  //                       (snapshot.data['photos'] as List)
  //                           .map((e) => Card(
  //                                 elevation: 5,
  //                                 child: Image(
  //                                     image: NetworkImage(e['src']['large'])),
  //                               ))
  //                           .toList()))