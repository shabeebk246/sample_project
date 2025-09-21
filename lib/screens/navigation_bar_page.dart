import 'package:flutter/material.dart';
import 'package:sample_project/commons/color_constants.dart';
import 'package:sample_project/screens/home_page.dart';
import 'package:sample_project/screens/settings_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import 'country_page.dart';
import 'list_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  List pages = [HomePage(), ListPage(), CountryPage(), SettingsPage()];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.Background,
      body: Container(child: pages[selectedIndex]),
      bottomNavigationBar: StylishBottomBar(
        items: [
          BottomBarItem(
            backgroundColor: ColorConstants.Button,
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomBarItem(
            backgroundColor: ColorConstants.Button,
            icon: Icon(Icons.list),
            title: Text("List"),
          ),
          BottomBarItem(
            backgroundColor: ColorConstants.Button,
            icon: Icon(Icons.place),
            title: Text("Country"),
          ),
          BottomBarItem(
            backgroundColor: ColorConstants.Button,
            icon: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
        option: AnimatedBarOptions(iconStyle: IconStyle.animated),
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
