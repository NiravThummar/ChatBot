import 'package:flutter/material.dart';
import 'package:fan_side_drawer/fan_side_drawer.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  List<DrawerMenuItem> get menuItems => [
        DrawerMenuItem(
            title: 'Home',
            icon: Icons.house_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Account Details',
            icon: Icons.account_circle_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Profile',
            icon: Icons.info_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Wallet',
            icon: Icons.wallet_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Transaactions',
            icon: Icons.attach_money_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Messages',
            icon: Icons.message_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Tickets',
            icon: Icons.support_agent_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Orders',
            icon: Icons.format_list_bulleted_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'App Settings',
            icon: Icons.adb_sharp,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Notifications',
            icon: Icons.alarm_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Subscribtion Plans',
            icon: Icons.question_answer_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Shops',
            icon: Icons.store,
            iconSize: 15,
            onMenuTapped: () {}),
      ];

  @override
  Widget build(BuildContext context) {
    // return Drawer(
    //   width: 255,
    //   child: FanSideDrawer(
    //     drawerType: DrawerType.pipe,
    //     menuItems: menuItems,
    //   ),
    // );
    return Drawer(
      width: 255,
      child:
          // ListView(
          // children: [
          // Container(
          // height: 165,
          // color: Colors.white,
          // child:
          // DrawerHeader(
          //   decoration: const BoxDecoration(color: Colors.black),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       children: [
          //         Container(
          //           height: 75,
          //           width: 75,
          //           child: Icon(
          //             Icons.person,
          //             size: 55,
          //           ),
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(50),
          //           ),
          //         ),
          //         const SizedBox(
          //           width: 30,
          //         ),
          //         Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               "Name",
          //               style: const TextStyle(
          //                 fontSize: 16,
          //                 color: Colors.grey,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Text(
          //               "Email",
          //               style: const TextStyle(
          //                 fontSize: 12,
          //                 color: Colors.grey,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // // ),
          // const SizedBox(
          //   height: 10,
          // ),
          FanSideDrawer(
        menuItems: menuItems,
        drawerType: DrawerType.pipe,
      ),
      // GestureDetector(
      //   onTap: () {},
      //   child: const ListTile(
      //     leading: Icon(
      //       Icons.history,
      //       color: Colors.black,
      //     ),
      //     title: Text(
      //       "History",
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
      // GestureDetector(
      //   onTap: () {},
      //   child: const ListTile(
      //     leading: Icon(
      //       Icons.settings,
      //       color: Colors.black,
      //     ),
      //     title: Text(
      //       "Setting",
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
      // GestureDetector(
      //   onTap: () {},
      //   child: const ListTile(
      //     leading: Icon(
      //       Icons.person,
      //       color: Colors.black,
      //     ),
      //     title: Text(
      //       "Profile",
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
      // GestureDetector(
      //   onTap: () {},
      //   child: const ListTile(
      //     leading: Icon(
      //       Icons.info,
      //       color: Colors.black,
      //     ),
      //     title: Text(
      //       "About",
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
      // GestureDetector(
      //   onTap: () {
      //     // controller.signoutMethod(context);
      //     // Navigator.push(
      //     //     context, MaterialPageRoute(builder: (c) => MySplashScreen()));
      //   },
      //   child: const ListTile(
      //     leading: Icon(
      //       Icons.logout,
      //       color: Colors.black,
      //     ),
      //     title: Text(
      //       "SignOut",
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
      // ],
      // ),
    );
  }
}
