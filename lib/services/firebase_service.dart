import 'package:chat_bot/consts/firebase_consts.dart';

class FirestoreServices {
  static saveUser({name, email, password, phone, uid}) async {
    await firestore.collection(userCollection).doc(uid).set({
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
      'id': currentUser!.uid,
    });
  }

  // void getUser(uid) async {
  //   final DocumentSnapshot userDoc =
  //       await firestore.collection(userCollection).doc(uid).get();
  //   String name = userDoc.get("name");
  //   print("name ${name}");
  // }

  // static saveGoogleUser(AuthCredential user) async {
  //   await firestore.collection(userCollection).doc().set({
  //     'email': user.,
  //     'name': user.displayName,
  //     'phone': "",
  //     'password': "",
  //     'id': user.uid,
  //   });
  // }
}
