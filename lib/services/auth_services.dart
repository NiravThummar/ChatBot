// import 'package:chat_bot/consts/firebase_consts.dart';
// import 'package:chat_bot/services/firebase_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class AuthServices {
//   static signupUser(
//       String email, String password, String name, BuildContext context) async {
//     try {
//       UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//           email: email, password: password);

//       await auth.currentUser!.updateDisplayName(name);
//       await auth.currentUser!.updateEmail(email);
//       await FirestoreServices.saveUser(
//           name, password, email, userCredential.user!.uid);
//       Fluttertoast.showToast(msg: "Welcome $name");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "weak-password") {
//         Fluttertoast.showToast(msg: "Password is too weak");
//       } else if (e.code == "email-already-in-use") {
//         Fluttertoast.showToast(msg: "Email is Already in Use");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   static loginUser(String email, String password, BuildContext context) async {
//     try {
//       await auth.signInWithEmailAndPassword(email: email, password: password);

//       Fluttertoast.showToast(msg: "Yor are Login Successfully");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "user-not-found") {
//         Fluttertoast.showToast(msg: "No user found with this email");
//       } else if (e.code == "wrong-password") {
//         Fluttertoast.showToast(msg: "Password not match");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   static signoutUser() {
//     auth.signOut();
//     Fluttertoast.showToast(msg: "LogOut Successfully");
//   }
// }
