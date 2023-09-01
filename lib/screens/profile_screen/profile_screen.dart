// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:chat_bot/controller/profile_controller.dart';
import 'package:chat_bot/controller/authentication_repository.dart';
import 'package:chat_bot/controller/usermodel.dart';
import 'package:chat_bot/screens/profile_screen/components/profile_for_switch.dart';
import 'package:chat_bot/screens/profile_screen/components/profile_menu.dart';
import 'package:chat_bot/screens/profile_screen/edit_profile.dart';
import 'package:chat_bot/screens/splash_screen/splash_screen.dart';
import 'package:chat_bot/widgets/dialogs/theme_dialog.dart';
import 'package:chat_bot/widgets/dialogs/logout_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final authrepo = Get.put(AuthenticationRepository());
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
        title: Text("Profile"),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;

                    final name = TextEditingController(text: userData.name);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 60,
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: userData.imgUrl == null
                                          ? ProfilePicture(
                                              name: name.text[0],
                                              radius: 60,
                                              fontsize: 50,
                                              random: false,
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(63),
                                                child: Image.network(
                                                  userData.imgUrl!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 19,
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.black, size: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                          keyboardType: TextInputType.none,
                          initialValue: userData.name,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                          keyboardType: TextInputType.none,
                          initialValue: userData.email,
                          scrollPadding: EdgeInsets.all(12),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => EditProfileScreen()));
                          },
                          child: Text("Edit Profile"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade300,
                              foregroundColor: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            height: 2,
                            // color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ProfileMenuWidget(
                          title: "Settings",
                          icon: Icons.settings,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: "History",
                          icon: Icons.history,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: "Theme",
                          icon: Icons.dark_mode_outlined,
                          // onPress: showThemePicker,
                          onPress: () async {
                            await showThemeChangerDialog(context);
                          },
                        ),
                        ProfileMenuWidget(
                          title: "Wallet",
                          icon: Icons.wallet,
                          onPress: () {},
                        ),
                        ProfileMenuSwitchWidget(
                          title: "Notifications",
                          icon: Icons.notifications,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: "Help & Center",
                          icon: Icons.help_outline_outlined,
                          onPress: () {},
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            height: 2,
                            // color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        ProfileMenuWidget(
                          title: "Information",
                          icon: Icons.info,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: "Logout",
                          icon: Icons.logout,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () async {
                            final shouldLogout =
                                await showLogOutDialog(context);
                            if (shouldLogout) {
                              await authrepo.logout();
                              Fluttertoast.showToast(
                                  msg: "LogOut Successfully");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => MySplashScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
