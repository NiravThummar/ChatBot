// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/Animation/fade_animation.dart';
import 'package:chat_bot/authentication/forgotpass_screen.dart';
import 'package:chat_bot/authentication/signup_screen.dart';
import 'package:chat_bot/controller/authentication_repository.dart';
import 'package:chat_bot/controller/login_controller.dart';
import 'package:chat_bot/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double maxHeaderHeight = 200;
  late ScrollController scrollController;
  final ValueNotifier<double> opacity = ValueNotifier(0);
  final controller = Get.put(LoginController());
  bool passVisible = false;
  final _formKey = GlobalKey<FormState>();
  final authrepo = Get.put(AuthenticationRepository());

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    if (maxHeaderHeight > scrollController.offset &&
        scrollController.offset > 1) {
      opacity.value = 1 - scrollController.offset / maxHeaderHeight;
    } else if (scrollController.offset > maxHeaderHeight &&
        opacity.value != 1) {
      opacity.value = 0;
    } else if (scrollController.offset < 0 && opacity.value != 0) {
      opacity.value = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: ValueListenableBuilder<double>(
                  valueListenable: opacity,
                  builder: (context, value, child) {
                    return AnimatedOpacity(
                      opacity: 1 - value,
                      duration: Duration(milliseconds: 1),
                      child: Center(
                        child: Text(
                          "Login Here",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
              pinned: true,
              expandedHeight: maxHeaderHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FadeAnimation(
                              delay: 1,
                              child: Center(
                                  child: AnimatedTextKit(animatedTexts: [
                                TyperAnimatedText(
                                  "Login",
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 45,
                                    fontFamily: 'Kaushan Script',
                                  ),
                                ),
                              ])),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                                delay: 1.4,
                                child: Center(
                                  child: AnimatedTextKit(animatedTexts: [
                                    TyperAnimatedText("Welcome back",
                                        textStyle: TextStyle(
                                          fontSize: 30,
                                          fontFamily: 'Alex Brush',
                                          color: Colors.white,
                                        )),
                                  ]),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                collapseMode: CollapseMode.parallax,
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          delay: 1.6,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: controller.email,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.email_outlined,
                                            color: Colors.grey.shade700,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          label: Text("Email"),
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: controller.password,
                                      obscureText: !passVisible,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                passVisible = !passVisible;
                                              });
                                            },
                                            icon: Icon(
                                              passVisible
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          label: Text("Password"),
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 160,
                            ),
                            FadeAnimation(
                              delay: 1.7,
                              child: TextButton(
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => ForgotpassScreen()));
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeAnimation(
                          delay: 1.9,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.all(14),
                            ),
                            onPressed: () async {
                              final email = controller.email;
                              final pass = controller.password;

                              if (email.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter Email");
                              } else if (!email.text.isEmail) {
                                Fluttertoast.showToast(
                                    msg: "Enter Valid Email");
                              } else if (pass.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter Password");
                              } else if (pass.text.length < 6) {
                                Fluttertoast.showToast(
                                    msg: "Password length is greater than 6");
                              } else {
                                Future<bool> isEmail =
                                    controller.checkIfEmailInUse(email.text);
                                if (await isEmail) {
                                  Future<bool> isPass = authrepo.login(
                                    email.text,
                                    pass.text,
                                  );
                                  if (await isPass) {
                                    Future.delayed(Duration(seconds: 2));
                                    Fluttertoast.showToast(
                                        msg: "Login Successfully");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => Home()));
                                    email.clear();
                                    pass.clear();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Password is wrong");
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Email is not exists");
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeAnimation(
                          delay: 2.1,
                          child: Text(
                            "------------------------- Or Login with -------------------------",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeAnimation(
                          delay: 1.9,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.all(14),
                            ),
                            onPressed: () async {
                              try {
                                await authrepo.signInWithGoogle();
                                Fluttertoast.showToast(
                                    msg: "Login Successfully");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) => Home()));
                              } catch (e) {
                                Fluttertoast.showToast(msg: e.toString());
                              }
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 15,
                                    child: Image.asset(
                                      "assets/images/google_logo.png",
                                      width: 23,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "SignIn With Google",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeAnimation(
                          delay: 2.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => SignupScreen()));
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]))
          ],
        ));
  }
}
