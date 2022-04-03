import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app/providers/theme_provide.dart';
import 'package:wallpaper_app/screens/auto_wp_se.dart';
import 'package:wallpaper_app/screens/downloads.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeData = context.read<ThemeProvider>();
    return SafeArea(
      child: Drawer(
        child: Scaffold(
            backgroundColor: themeData.isDark ? Colors.black : Colors.white,
            body: ListView(children: [
              SizedBox(
                height: 20,
              ),
              Text('4K Wallpaper - HD Background',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                      fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png')))),
              ListTile(
                onTap: () => Navigator.pushNamed(context, '/'),
                title: Text(
                  'Home',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                leading: FaIcon(
                  FontAwesomeIcons.home,
                  color: themeData.isDark ? Colors.white : Colors.black,
                ),
              ),
              // ListTile(
              //   title: Text('My Favorite'),
              //   leading: FaIcon(FontAwesomeIcons.heart, color: Colors.white),
              // ),
              ListTile(
                  title: Text('My Downloads'),
                  leading: FaIcon(
                    FontAwesomeIcons.download,
                    color: themeData.isDark ? Colors.white : Colors.black,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, DownloadsScreen.id);
                  }),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return AutoWallpaperSettings();
                })),
                title: Text('Auto Wallpaper Settings'),
                leading: FaIcon(
                  FontAwesomeIcons.hammer,
                  color: themeData.isDark ? Colors.white : Colors.black,
                ),
              ),
              ListTile(
                leading: Text('Theme'),
                title: Row(
                  children: [
                    Icon(
                      Icons.light_mode,
                      color:
                          themeData.isDark ? Colors.grey : Colors.amberAccent,
                    ),
                    Switch(
                        value: themeData.isDark,
                        onChanged: (_) {
                          themeData.toggleTheme();
                        }),
                    Icon(
                      Icons.dark_mode,
                      color: themeData.isDark
                          ? Color.fromARGB(255, 246, 226, 3)
                          : Colors.grey,
                    ),
                  ],
                ),
              ),
              // ListTile(
              //   title: Text('Get Pro'),
              //   leading: FaIcon(
              //     FontAwesomeIcons.ad,
              //     color: themeData.isDark ? Colors.white : Colors.black,
              //   ),
              // ),
              ListTile(
                title: Text('Explore more...'),
                leading: FaIcon(
                  FontAwesomeIcons.googlePlay,
                  color: themeData.isDark ? Colors.white : Colors.black,
                ),
                onTap: () async {
                  var url =
                      'https://play.google.com/store/apps/dev?id=8403495839670533437';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
              ),
            ])),
      ),
    );
  }
}
