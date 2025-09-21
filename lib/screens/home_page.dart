import 'package:flutter/material.dart';
import 'package:sample_project/commons/color_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greeting = "";
  String userName = "";

  void setGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
  }

  Future<void> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? "User";
    setState(() {
      userName = email.split('@')[0];
    });
  }

  @override
  void initState() {
    setGreeting();
    loadUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.Background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              greeting,
              style: TextStyle(
                color: ColorConstants.textColor,
                fontSize: height * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userName,
              style: TextStyle(
                color: ColorConstants.textColor,
                fontWeight: FontWeight.w500,
                fontSize: height * 0.025,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
