import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? imgUrl;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.imgUrl,
  });

  toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "imgUrl": '',
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
      name: data!['name'],
      email: data['email'],
      phone: data['phone'],
      password: data['password'],
      imgUrl: data['imgUrl'],
    );
  }
}
