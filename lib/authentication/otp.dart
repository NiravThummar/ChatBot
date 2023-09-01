import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/Animation/fade_animation.dart';
import 'package:chat_bot/authentication/verification_screen.dart';
import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:chat_bot/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  // var controller = Get.put(AuthController());
  double maxHeaderHeight = 200;
  late ScrollController scrollController;
  final ValueNotifier<double> opacity = ValueNotifier(0);
  // final _formKey = GlobalKey<FormState>();

  // TextEditingController countycode = TextEditingController();
  // TextEditingController phonecontroller = TextEditingController();

  @override
  void initState() {
    // countycode.text = "+91";
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
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: TextStyle(
    //     fontSize: 20,
    //     color: Color.fromRGBO(30, 60, 87, 1),
    //     fontWeight: FontWeight.w600,
    //   ),
    //   decoration: BoxDecoration(
    //     border: Border.all(
    //       color: Color.fromRGBO(234, 239, 243, 1),
    //     ),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    // );

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(
    //     color: Color.fromRGBO(114, 178, 238, 1),
    //   ),
    //   borderRadius: BorderRadius.circular(8),
    // );

    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );

    var code = "";
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
                        Pinput(
                          // defaultPinTheme: defaultPinTheme,
                          // focusedPinTheme: focusedPinTheme,
                          // submittedPinTheme: submittedPinTheme,
                          // validator: (s) {
                          //   return s == '2222' ? null : 'Pin is incorrect';
                          // },
                          length: 6,
                          // pinputAutovalidateMode:
                          // PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onChanged: (value) {
                            code = value;
                          },
                          // onCompleted: (pin) => print(pin),
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
                              try {
                                PhoneAuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId:
                                            VerificationScreen.verify,
                                        smsCode: code);
                                await auth.signInWithCredential(credential);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) => Home()));
                              } catch (e) {
                                print("Wrong OTP");
                              }
                            },
                            child: Center(
                              child: Text(
                                "Verify OTP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => VerificationScreen()));
                          },
                          child: Text("Edit phone number?"),
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
