import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper_app/screens/main_screen.dart';
import 'package:package_info/package_info.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool? _isConnected;

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text('err'),
              content: new Text(content),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Close"))
              ]);
        });
  }

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return MainScreen();
        }));
      }
    } on SocketException catch (err) {
      setState(() {
        _isConnected = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(minutes: 1),
          content: Row(
            children: [
              FaIcon(FontAwesomeIcons.wifi),
              Text('No Internet Connection!!!')
            ],
          )));
      // _showDialog('No Internet!!!', 'Check internet connection', context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternetConnection();
  }

  String? version1 = '';
  String? appName1 = '';
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
          Positioned(
            top: height * .05,
            right: width / 2.5,
            child: Text(
              appName1! + '\n        V ' + version1!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
