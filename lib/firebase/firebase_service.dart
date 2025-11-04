import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/resources/constant_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/models/login_request.dart';
import 'package:evently/models/register_request.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {

  static Future<UserCredential> register(RegisterRequest request) async {
    UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
    return credential;
  }


  static Future<UserCredential> login(LoginRequest request) async {
    UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
    return credential;
  }

  static Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, Routes.login);
  }


  static Future<void>  addUserToFirebase(UserModel user) async {
    FirebaseFirestore db =FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> usersCollection= db.collection(ConstantManager.users);
    DocumentReference<Map<String, dynamic>> userDoc =usersCollection.doc(user.userId);
    await userDoc.set({
      "id":user.userId,
      "email":user.email,
      "name":user.userName,
    });
  }



  static Future<UserModel> getUserFromFirestore(String id) async {
    FirebaseFirestore db =FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> usersCollection=db.collection(ConstantManager.users);
    DocumentReference<Map<String, dynamic>> userDoc =usersCollection.doc(id);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
    var  json =docSnapshot.data();
    return UserModel(userId: json?["id"], email: json?["email"], userName: json?["name"]);
  }

}