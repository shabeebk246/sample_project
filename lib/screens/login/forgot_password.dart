import 'package:flutter/material.dart';
import 'package:sample_project/commons/color_constants.dart';

import '../../main.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool tap = true;
  bool touch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.Background,
      appBar: AppBar(
        backgroundColor: ColorConstants.Background,
        title: Text(
          "Forgot Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Password",
              style: TextStyle(
                color: ColorConstants.textColor,
                fontWeight: FontWeight.w600,
                fontSize: width * 0.08,
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Your new Password must be different from previous used Password",
            ),
            SizedBox(height: height * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: height * 0.01),
                Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: ColorConstants.textColor,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: newPasswordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: touch ? true : false,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(fontSize: width * 0.04),
                    constraints: BoxConstraints(
                      minHeight: height * 0.07,
                      maxWidth: width * 1,
                      minWidth: width * 1,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        touch = !touch;
                        setState(() {});
                      },
                      child: touch
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
                SizedBox(height: height * 0.05),
                Container(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
