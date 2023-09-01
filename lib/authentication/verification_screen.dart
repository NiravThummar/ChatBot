// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/Animation/fade_animation.dart';
import 'package:chat_bot/authentication/otp.dart';
import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  static String verify = "";
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // var controller = Get.put(AuthController());
  double maxHeaderHeight = 200;
  late ScrollController scrollController;
  final ValueNotifier<double> opacity = ValueNotifier(0);
  final _formKey = GlobalKey<FormState>();

  TextEditingController countrycode = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  var phone = "";

  @override
  void initState() {
    countrycode.text = "+91";
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
        backgroundColor: Colors.black54,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
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
                          "Verify here",
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
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
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
                                  "OTP Verification",
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
                                    TyperAnimatedText("Verify Here",
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
                                    height: 55,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 40,
                                          child: TextField(
                                            controller: countrycode,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "|",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 33,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            // controller: phonecontroller,
                                            onChanged: (value) {
                                              phone = value;
                                            },
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Phone",
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 170,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeAnimation(
                          delay: 1.8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.all(14),
                            ),
                            onPressed: () async {
                              await auth.verifyPhoneNumber(
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  phoneNumber: '${countrycode.text + phone}',
                                  verificationFailed:
                                      (FirebaseAuthException e) {},
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    VerificationScreen.verify = verificationId;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => MyOtp()));
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {});
                            },
                            child: Center(
                              child: Text(
                                "Send OTP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
