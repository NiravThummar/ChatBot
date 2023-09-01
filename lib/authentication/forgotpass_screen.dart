// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/Animation/fade_animation.dart';
import 'package:chat_bot/authentication/login_screen.dart';
import 'package:chat_bot/controller/authentication_repository.dart';
import 'package:chat_bot/controller/forgotpass_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgotpassScreen extends StatefulWidget {
  const ForgotpassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotpassScreen> createState() => _ForgotpassScreenState();
}

class _ForgotpassScreenState extends State<ForgotpassScreen> {
  double maxHeaderHeight = 200;
  late ScrollController scrollController;
  final ValueNotifier<double> opacity = ValueNotifier(0);
  final controller = Get.put(ForgotPassController());
  final authrepo = Get.put(AuthenticationRepository());
  final _formKey = GlobalKey<FormState>();

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
                          "Reset Password",
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: FadeAnimation(
                          delay: 1,
                          child: Center(
                              child: AnimatedTextKit(animatedTexts: [
                            TyperAnimatedText(
                              "Reset Password",
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Kaushan Script',
                              ),
                            ),
                          ])),
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                            delay: 1.2,
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
                                                  color:
                                                      Colors.grey.shade200))),
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
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                            delay: 1.4,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.all(14),
                              ),
                              onPressed: () async {
                                final email = controller.email;
                                if (email.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Email");
                                } else if (!email.text.isEmail) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Valid Email");
                                } else {
                                  Future<bool> isEmail =
                                      controller.checkIfEmailInUse(email.text);
                                  if (await isEmail) {
                                    await authrepo.passwordReset(email.text);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => LoginScreen()));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Email is not exists");
                                  }
                                }
                                // try {
                                //   await controller.passwordReset(
                                //       email: email);
                                // } on InvalidEmailAuthException {
                                //   Fluttertoast.showToast(
                                //       msg: "Invalid Email ID");
                                // }
                              },
                              child: Center(
                                child: Text(
                                  "Send Email",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]))
          ],
        ));
  }
}
