// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_bot/screens/chat_screen/chat_screen.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_5/chat_screen.dart';
import 'package:chat_bot/screens/home_screen/home_screen.dart';
import 'package:chat_bot/screens/profile_screen/profile_screen.dart';

import 'package:chat_bot/screens/wallet_screen/wallet_screen.dart';
import 'package:chat_bot/widgets/dialogs/exit_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:bottom_bar_matu/bottom_bar_matu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showExitDialog(context);
        if (shouldExit) {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            HomeScreen(),
            // ChatScreen(),
            ChatScreen5(),
            WalletScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                spreadRadius: 4,
                blurRadius: 15,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.home,
                    size: 19,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_outlined,
                    size: 23,
                  ),
                  activeIcon: Icon(
                    Icons.chat,
                    size: 23,
                  ),
                  label: "Chat",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.wallet_sharp,
                    size: 23,
                  ),
                  activeIcon: Icon(
                    Icons.wallet_outlined,
                    size: 23,
                  ),
                  label: "Wallet",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.person,
                    size: 19,
                  ),
                  activeIcon: Icon(
                    Icons.person,
                    size: 25,
                  ),
                  label: "Profile",
                ),
              ],
              currentIndex: selectedIndex,
              mouseCursor: MouseCursor.defer,
              onTap: onItemClicked,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 13,
              unselectedFontSize: 12,
              showUnselectedLabels: true,
              backgroundColor: Colors.black54,
              unselectedItemColor: Colors.white54,
              selectedItemColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
