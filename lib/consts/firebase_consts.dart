import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
CollectionReference ref = firestore.collection(userCollection);

const userCollection = "users";
