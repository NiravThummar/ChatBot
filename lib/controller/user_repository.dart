import 'dart:io';
import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:chat_bot/models/usermodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  createUser(UserModel user) async {
    try {
      await firestore.collection(userCollection).add(user.toJson());
      // .whenComplete(() => Fluttertoast.showToast(msg: "Your Account created"))
      // .catchError((error, stackTrace) {
      // Fluttertoast.showToast(msg: "Error");
      // });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await firestore
        .collection(userCollection)
        .where("email", isEqualTo: email)
        .get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userdata;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await firestore.collection(userCollection).get();
    final userdata =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<void> updateUserRecord(UserModel userData, UserModel user) async {
    await firestore
        .collection(userCollection)
        .doc(user.id)
        .update(userData.toJson());
  }

  Future<void> updateProfilePicture(File image, UserModel user) async {
    var pathImage = image.toString();
    var temp = pathImage.lastIndexOf('/');
    var result = pathImage.substring(temp + 1);
    final Reference ref =
        FirebaseStorage.instance.ref().child("profile_images").child(result);
    TaskSnapshot snapshot = await ref.putFile(image);
    var imgUrl = await snapshot.ref.getDownloadURL();
    await firestore
        .collection(userCollection)
        .doc(user.id)
        .update({'imgUrl': imgUrl});
  }
}
