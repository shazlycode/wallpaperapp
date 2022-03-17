import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class WallpaperProvider with ChangeNotifier {
  List _imagesList = [];

  List get imagesList => [..._imagesList];

  Future<void> getDownloadDirAndFetchImages() async {
    var dir = await getExternalStorageDirectory();
    Directory? downloadDir = Directory('${dir!.path}/downloades');
    List _fetched = [];

    _fetched = downloadDir.listSync().map((e) => e.path).toList();
    // print('Fetched= ${_fetched.length}');
    _imagesList = _fetched;
    // print('IMAGES= ${_imagesList}');

    notifyListeners();
  }

//downloadDir!.listSync().map((e) => e.path).toList();
}
