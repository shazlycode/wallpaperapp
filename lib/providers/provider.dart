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

  void deleteImageFile(String path) {
    _imagesList.removeWhere((element) => element == path);
    File(path).deleteSync();
    notifyListeners();
  }

  List _autoThemeImages = [];

  List get autoThemeImages => _autoThemeImages;

  bool _isSelected = false;
  get isSelected => _isSelected;

  addToAutoThemeImages(String imgPath) {
    if (!_autoThemeImages.contains(imgPath)) {
      _autoThemeImages.add(imgPath);
      _isSelected = true;
    } else {
      _autoThemeImages.removeWhere((element) => element == imgPath);
      _isSelected = false;
    }
    print(_autoThemeImages.length);
    notifyListeners();
  }

  bool getIseSelected(String imgPath) {
    if (_autoThemeImages.contains(imgPath)) {
      return _isSelected = true;
    } else {
      return _isSelected = false;
    }
  }
}
