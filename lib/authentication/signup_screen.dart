import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/Animation/fade_animation.dart';
import 'package:chat_bot/authentication/login_screen.dart';
import 'package:chat_bot/controller/authentication_repository.dart';
import 'package:chat_bot/controller/sign_controller.dart';
import 'package:chat_bot/controller/user_repository.dart';
import 'package:chat_bot/controller/usermodel.dart';
import 'package:chat_bot/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final controller = Get.put(SignupController());
  double maxHeaderHeight = 200;
  late ScrollController scrollController;
  final ValueNotifier<double> opacity = ValueNotifier(0);
  final _formKey = GlobalKey<FormState>();
  final userrepo = Get.put(UserRepository());
  final authrepo = Get.put(AuthenticationRepository());

  bool passVisible = false;
  bool repassVisible = false;

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
                          "Register Here",
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
                                  "SignUp",
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
                                    TyperAnimatedText("Register Here",
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
                                      controller: controller.name,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person_2_outlined,
                                            color: Colors.grey.shade700,
                                          ),
                                          label: Text("Name"),
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: "Name",
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
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: controller.email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.email_outlined,
                                            color: Colors.grey.shade700,
                                          ),
                                          label: Text("Email"),
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: "Email",
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
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: controller.phone,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.phone,
                                            color: Colors.grey.shade700,
                                          ),
                                          label: Text("Phone"),
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: "Phone",
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
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: controller.repassword,
                                      obscureText: !repassVisible,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                repassVisible = !repassVisible;
                                              });
                                            },
                                            icon: Icon(
                                              repassVisible
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          label: Text("Repeat Password"),
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: "Repeat Password",
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
                              final name = controller.name;
                              final email = controller.email;
                              final phone = controller.phone;
                              final pass = controller.password;
                              final repass = controller.repassword;
                              if (name.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter name");
                              } else if (email.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter Email");
                              } else if (!email.text.isEmail) {
                                Fluttertoast.showToast(
                                    msg: "Enter Valid Email");
                              } else if (phone.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter Phone");
                              } else if (pass.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter Password");
                              } else if (pass.text.length < 6) {
                                Fluttertoast.showToast(
                                    msg: "Password length is greater than 6");
                              } else if (repass.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter Repeat Password");
                              } else if (repass.text.length < 6) {
                                Fluttertoast.showToast(
                                    msg: "Password length is greater than 6");
                              } else if (pass.text != repass.text) {
                                Fluttertoast.showToast(
                                    msg: "Password is not match");
                              } else {
                                final user = UserModel(
                                  name: name.text.trim(),
                                  email: email.text.trim(),
                                  phone: phone.text.trim(),
                                  password: pass.text.trim(),
                                );

                                Future<bool> isEmail =
                                    controller.checkIfEmailInUse(email.text);
                                if (await isEmail) {
                                  Fluttertoast.showToast(
                                      msg: "Email Already in Use");
                                } else {
                                  authrepo.signup(email.text, pass.text);
                                  userrepo.createUser(user);
                                  Future.delayed(Duration(seconds: 2));
                                  Fluttertoast.showToast(
                                      msg: "Account Created");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => Home()));
                                  name.clear();
                                  email.clear();
                                  phone.clear();
                                  pass.clear();
                                  repass.clear();
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                "SignUp",
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
                        FadeAnimation(
                          delay: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I have an account?",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => LoginScreen()));
                                },
                                child: Text(
                                  "Login",
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
