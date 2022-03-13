import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: ListView(children: [
              Text(
                'Wallpaper App',
                textAlign: TextAlign.center,
              ),
              ListTile(
                title: Text('Home'),
                leading: FaIcon(FontAwesomeIcons.home, color: Colors.white),
              ),
              ListTile(
                title: Text('My Favorite'),
                leading: FaIcon(FontAwesomeIcons.heart, color: Colors.white),
              ),
              ListTile(
                title: Text('My Downloads'),
                leading: FaIcon(FontAwesomeIcons.download, color: Colors.white),
              ),
              ListTile(
                title: Text('Auto Wallpaper Settings'),
                leading: FaIcon(FontAwesomeIcons.hammer, color: Colors.white),
              ),
              ListTile(
                title: Text('Theme'),
                leading: FaIcon(FontAwesomeIcons.sun, color: Colors.white),
              ),
              ListTile(
                title: Text('Get Pro'),
                leading: FaIcon(FontAwesomeIcons.ad, color: Colors.white),
              ),
            ])),
      ),
    );
  }
}
