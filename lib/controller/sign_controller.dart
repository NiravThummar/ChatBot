import 'package:chat_bot/controller/user_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final repassword = TextEditingController();
  final userrepo = Get.put(UserRepository());

  // void registerUser(String email, String password) {
  //   AuthenticationRepository.instance.signup(email, password);
  // }

  // Future<void> saveData(UserModel user) async {
  //   registerUser(user.email!, user.password!);
  //   await userrepo.createUser(user);
  // }

  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }
}
