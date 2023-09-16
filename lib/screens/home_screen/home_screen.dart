// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types, must_be_immutable, unnecessary_import, avoid_unnecessary_containers

import 'package:chat_bot/screens/chat_screen/chat_screen_5/chat_screen.dart';
import 'package:chat_bot/screens/wallet_screen/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool multiple = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        elevation: 10,
        title: Text("Home"),
      ),
      // drawer: MyDrawer(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => WalletScreen()));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Get Premium",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "For an uninterrupted\n"
                              "ChatBot experience",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.crown,
                        size: 90,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ask Question",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: Icon(
                        multiple ? Icons.view_agenda : Icons.dashboard,
                      ),
                      onTap: () {
                        setState(() {
                          multiple = !multiple;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Container(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: multiple ? 2 : 1,
                    childAspectRatio: multiple ? 0.6 : 1.9,
                  ),
                  controller: ScrollController(keepScrollOffset: false),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    multiple
                        ? multipleItemContainer(
                            title: "Ask\nAnything",
                            subtitle: "Your ultimate\nknowledge\nassistant.",
                            icon: Icons.question_mark,
                            iconBackgroundColor: Colors.green,
                          )
                        : itemContainer(
                            title: "Ask Anything",
                            subtitle: "Your ultimate knowledge assistant.",
                            icon: Icons.question_mark,
                            iconBackgroundColor: Colors.green,
                          ),
                    multiple
                        ? multipleItemContainer(
                            title: "Write an\nEmail",
                            subtitle:
                                "Effortlessly draft\nprofessional\nemails.",
                            icon: Icons.email_outlined,
                            iconBackgroundColor: Colors.blue,
                          )
                        : itemContainer(
                            title: "Write an Email",
                            subtitle: "Effortlessly draft professional emails.",
                            icon: Icons.email_outlined,
                            iconBackgroundColor: Colors.blue,
                          ),
                    multiple
                        ? multipleItemContainer(
                            title: "Interview\nQuestions",
                            subtitle: "Build effective\ninterview\nquestions.",
                            icon: Icons.shopping_bag_rounded,
                            iconBackgroundColor: Colors.orange,
                          )
                        : itemContainer(
                            title: "Interview Questions",
                            subtitle: "Build effective interview questions.",
                            icon: Icons.shopping_bag_rounded,
                            iconBackgroundColor: Colors.orange,
                          ),
                    multiple
                        ? multipleItemContainer(
                            title: "Create\nStudy notes",
                            subtitle: "Learn and\nRemember\nBetter,Smarter",
                            icon: Icons.note,
                            iconBackgroundColor: Colors.purple,
                          )
                        : itemContainer(
                            title: "Create Study notes",
                            subtitle: "Learn and Remember Better,Smarter",
                            icon: Icons.note,
                            iconBackgroundColor: Colors.purple,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class multipleItemContainer extends StatelessWidget {
  multipleItemContainer({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackgroundColor,
    super.key,
  });

  String title;
  String subtitle;
  IconData icon;
  Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: iconBackgroundColor,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => ChatScreen5()));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class itemContainer extends StatelessWidget {
  itemContainer({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackgroundColor,
    super.key,
  });

  String title;
  String subtitle;
  IconData icon;
  Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: iconBackgroundColor,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => ChatScreen5()));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
