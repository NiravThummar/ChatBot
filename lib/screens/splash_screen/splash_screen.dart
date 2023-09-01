import 'dart:async';
import 'package:chat_bot/authentication/login_screen.dart';
import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:chat_bot/home/home.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      if (await auth.currentUser != null) {
        Navigator.push(context, MaterialPageRoute(builder: (c) => Home()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello, Welcome in ChatBot"),
          SizedBox(
            height: 15,
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
