import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/main_screen.dart';
import 'package:package_info/package_info.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      // getInfo();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MainScreen();
      }));
    });
  }

  String? version1 = '';
  String? appName1;
  getInfo() async {
    await PackageInfo.fromPlatform().then((value) {
      setState(() {
        version1 = value.version;
        appName1 = value.appName;
      });
      // value.appName;
    });
    print(version1);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Image(
              image: AssetImage('assets/images/bg.webp'),
              fit: BoxFit.cover,
            ),
          ),
          // Positioned(
          //   top: height * .05,
          //   right: width / 2.5,
          //   child: Text(
          //     appName1! + '\n        V ' + version1!,
          //     style: Theme.of(context).textTheme.bodyText1,
          //   ),
          // ),
        ],
      ),
    );
  }
}
