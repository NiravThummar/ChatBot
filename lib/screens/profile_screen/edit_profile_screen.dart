// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:chat_bot/controller/profile_controller.dart';
import 'package:chat_bot/controller/user_repository.dart';
import 'package:chat_bot/models/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var pickedImage = null;
  Future<dynamic> showProfilePictureDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return Dialog(
          child: Container(
            height: 170,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Choose Profile Photo",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      onTap: () {
                        pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Icon(
                            Icons.image,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  pickImage(ImageSource imagetype) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final photo = await _picker.pickImage(source: imagetype);
      if (photo == null) {
        return;
      }
      final tempImg = File(photo.path);
      setState(() {
        this.pickedImage = tempImg;
      });
      print("wnfnevvv $pickedImage");
      print("  hiiiiiHellokkv: $pickedImage");
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final userRepo = Get.put(UserRepository());
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
        title: Text("Edit Profile"),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  final name = TextEditingController(text: user.name);
                  final email = TextEditingController(text: user.email);
                  final phone = TextEditingController(text: user.phone);
                  final password = TextEditingController(text: user.password);
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 80,
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 65,
                                      backgroundColor: Colors.white,
                                      child: user.imgUrl.isEmptyOrNull
                                          ? pickedImage != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(65),
                                                  child: SizedBox.fromSize(
                                                    size: Size.fromRadius(63),
                                                    child: Image.file(
                                                      pickedImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : ProfilePicture(
                                                  name: user.name![0],
                                                  radius: 64,
                                                  fontsize: 50,
                                                  random: false,
                                                )
                                          : pickedImage != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(65),
                                                  child: SizedBox.fromSize(
                                                    size: Size.fromRadius(63),
                                                    child: Image.file(
                                                      pickedImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(65),
                                                  child: SizedBox.fromSize(
                                                    size: Size.fromRadius(63),
                                                    child: Image.network(
                                                      user.imgUrl!,
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
                                  onTap: () async {
                                    await showProfilePictureDialog(context);
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 26,
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: InputBorder.none,
                            label: Text(
                              "Name",
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: InputBorder.none,
                            label: Text(
                              "Email",
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phone,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: InputBorder.none,
                            label: Text(
                              "Phone",
                            ),
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: InputBorder.none,
                            label: Text(
                              "Password",
                            ),
                            prefixIcon: Icon(
                              Icons.fingerprint_outlined,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade300,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(14),
                          ),
                          onPressed: () async {
                            final userData = UserModel(
                              name: name.text,
                              email: email.text,
                              phone: phone.text,
                              password: password.text,
                            );
                            await userRepo.updateUserRecord(userData, user);
                            if (pickedImage.toString().isNotEmptyAndNotNull) {
                              await userRepo.updateProfilePicture(
                                  pickedImage, user);
                            }
                            setState(() {});
                            Fluttertoast.showToast(msg: "Profile is Updated");
                          },
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                Future.delayed(Duration(seconds: 3));
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
