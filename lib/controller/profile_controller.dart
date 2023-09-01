import 'package:chat_bot/controller/authentication_repository.dart';
import 'package:chat_bot/controller/user_repository.dart';
import 'package:chat_bot/controller/usermodel.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authrepo = Get.put(AuthenticationRepository());
  final _userrepo = Get.put(UserRepository());
  getUserData() {
    final email = _authrepo.firebaseUser!.email;
    if (email != null) {
      return _userrepo.getUserDetails(email);
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  Future<List<UserModel>> getAllUsers() async => await _userrepo.allUser();

  // updateRecord(UserModel userData, UserModel user) async {
  //   await _userrepo.updateUserRecord(userData, user);
  // }
}
