import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/provider.dart';
import 'package:wallpaper_app/screens/set_auto_wallpaper.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'package:path_provider/path_provider.dart' as path;

class AutoWallpaperSettings extends StatefulWidget {
  const AutoWallpaperSettings({Key? key}) : super(key: key);

  @override
  State<AutoWallpaperSettings> createState() => _AutoWallpaperSettingsState();
}

class _AutoWallpaperSettingsState extends State<AutoWallpaperSettings> {
  var minutes;
  @override
  void initState() {
    super.initState();
  }

  final List<DropdownMenuItem> _dDMI = [
    const DropdownMenuItem(
      child: Text('1 Minutes',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 1,
    ),
    const DropdownMenuItem(
      child: Text('15 Minutes',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 15,
    ),
    const DropdownMenuItem(
      child: Text('30 Minutes',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 30,
    ),
    const DropdownMenuItem(
      child: Text('1 Hour',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 60,
    ),
    const DropdownMenuItem(
      child: Text('2 Hours',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 120,
    ),
    const DropdownMenuItem(
      child: Text('6 Hours',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 360,
    ),
    const DropdownMenuItem(
      child: Text('12 Hours',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 720,
    ),
    const DropdownMenuItem(
      child: Text('1 Day',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 1440,
    ),
    const DropdownMenuItem(
      child: Text('3 days',
          style: TextStyle(
            color: Colors.white,
          )),
      value: 4320,
    ),
  ];
  var isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
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

  // setAutoWallpaper() async {
  // print(isDone);

  //   Workmanager().registerOneOffTask('uniqueName', 'taskName',
  //       initialDelay: Duration(seconds: 1));
  // }

  // setWallpaper() {
  //   Timer.periodic(Duration(minutes: minutes), (timer) {
  //     setWallPaper();
  //   });
  // }

  getAppDirectory() async {
    var dir = await path.getExternalStorageDirectory();
    print(dir);
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperProviderData = context.read<WallpaperProvider>();
    getAppDirectory();
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper Settings'),
        actions: [
          IconButton(
              onPressed: () {
                // Workmanager().registerOneOffTask('uniqueName', 'taskName',
                //     initialDelay: Duration(seconds: 1));
                // print('DONEEEEEEEEEEEEEEEEEEE');
                final autoThemeImages =
                    context.read<WallpaperProvider>().autoThemeImages;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SetAutoWallpaper(
                      autoThemeImages: autoThemeImages, minutes: minutes);
                }));
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Select Duration'),
                DropdownButton(
                    value: minutes,
                    dropdownColor: Color.fromARGB(255, 115, 10, 10),
                    hint: Text(
                      'Select interval',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    items: _dDMI
                        .map((e) => DropdownMenuItem(
                              child: e.child,
                              value: e.value,
                            ))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        minutes = v;
                      });
                      print(minutes);
                    }),
              ],
            ),
            _isLoading
                ? Center(
                    child: SpinKitCircle(color: Colors.red),
                  )
                : Expanded(
                    child: GridView.builder(
                        itemCount: wallpaperProviderData.imagesList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                context
                                    .read<WallpaperProvider>()
                                    .addToAutoThemeImages(wallpaperProviderData
                                        .imagesList[index]);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          wallpaperProviderData
                                              .imagesList[index],
                                        ),
                                      ),
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(context
                                                  .read<WallpaperProvider>()
                                                  .getIseSelected(
                                                      wallpaperProviderData
                                                          .imagesList[index])
                                              ? 1
                                              : 0),
                                          BlendMode.color),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
