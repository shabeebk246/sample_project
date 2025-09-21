import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/commons/color_constants.dart';
import 'package:sample_project/screens/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String userName = '';

  void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
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
    loadUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: ColorConstants.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              width: width * 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColorConstants.Button, ColorConstants.Background],
                ),
                borderRadius: BorderRadiusGeometry.circular(width * 0.03),
                border: Border.all(
                  color: ColorConstants.Button.withOpacity(0.7),
                  width: width * 0.005,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : "U",
                      style: TextStyle(
                        fontSize: height * 0.03,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.Button,
                      ),
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      color: ColorConstants.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.025,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Log out"),
                          content: Text("Are you want to log out"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                logOut(context);
                              },
                              child: Text("Confirm"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: ColorConstants.Button,
                      ),
                      title: Text(
                        "Log Out",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: ColorConstants.Button,
                        size: width * 0.05,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: ColorConstants.Button),
                    title: Text("Settings"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: ColorConstants.Button,
                      size: width * 0.05,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      color: ColorConstants.Button,
                    ),
                    title: Text("Help & Support"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: ColorConstants.Button,
                      size: width * 0.05,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
