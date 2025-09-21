import 'package:flutter/material.dart';
import 'package:sample_project/commons/color_constants.dart';
import 'package:sample_project/commons/image_constants.dart';
import 'package:sample_project/main.dart';
import 'package:sample_project/screens/login/forgot_password.dart';
import 'package:sample_project/screens/navigation_bar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool tap = true;
  bool showForgotPassword = false;

  void logIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (email == 'admin@gmail.com' && password == '12345678') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigationBarPage()),
      );
    } else {
      setState(() {
        showForgotPassword = true;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Invalid credentials"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.Background,
      appBar: AppBar(backgroundColor: ColorConstants.Background),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back ",
              style: TextStyle(
                color: ColorConstants.textColor,
                fontWeight: FontWeight.w600,
                fontSize: width * 0.08,
              ),
            ),
            Text("please enter your e–mail and password for login"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Email",
                  style: TextStyle(
                    color: ColorConstants.textColor,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Example@gmail.com",
                    hintStyle: TextStyle(fontSize: width * 0.04),
                    constraints: BoxConstraints(
                      minHeight: height * 0.07,
                      maxWidth: width * 1,
                      minWidth: width * 1,
                    ),
                    filled: true,
                    fillColor: Color(0xffffffff),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  "Password",
                  style: TextStyle(
                    color: ColorConstants.textColor,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: tap ? true : false,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(fontSize: width * 0.04),
                    constraints: BoxConstraints(
                      minHeight: height * 0.07,
                      maxWidth: width * 1,
                      minWidth: width * 1,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        tap = !tap;
                        setState(() {});
                      },
                      child: tap
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    filled: true,
                    fillColor: Color(0xffffffff),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
                if (showForgotPassword)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                      );
                    },
                    child: Text("Forgot password?", style: TextStyle()),
                  ),
              ],
            ),
            InkWell(
              onTap: logIn,
              child: Container(
                height: height * 0.07,
                width: width * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  color: ColorConstants.Button,
                ),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.02,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.06,
              width: width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.03),
                color: Color(0xffffffff),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(ImageConstants.google, width: width * 0.07),
                  Text(
                    "Sign up with Google",
                    style: TextStyle(
                      color: ColorConstants.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.015,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.06,
              width: width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.03),
                color: Color(0xffffffff),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    ImageConstants.apple,
                    width: width * 0.07,
                    // height: width*0.07,
                  ),
                  Text(
                    "Sign up with apple id",
                    style: TextStyle(
                      color: ColorConstants.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.015,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                "Create Account",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
