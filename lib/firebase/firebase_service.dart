import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/UIUtils.dart';
import 'package:evently/core/resources/constant_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/login_request.dart';
import 'package:evently/models/register_request.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {

  static Future<UserCredential> register(RegisterRequest request) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
    return credential;
  }


  static Future<UserCredential> login(LoginRequest request) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
    return credential;
  }

  static Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  static CollectionReference<UserModel> _getUserCollection(){
    FirebaseFirestore db = FirebaseFirestore.instance;
     return db.collection(
        ConstantManager.users).withConverter<UserModel>(fromFirestore: (snapshot, options) => UserModel.fromJson(snapshot.data()!), toFirestore: (user, options) => user.toJson(),
    );
  }

  static Future<void> addUserToFirebase(UserModel user) async {
    CollectionReference<UserModel> usersCollection =_getUserCollection();
    DocumentReference<UserModel> userDoc = usersCollection.doc(user.userId);
    await userDoc.set(user);
  }


  static Future<UserModel?> getUserFromFirestore(String id) async {
    CollectionReference<UserModel> usersCollection =_getUserCollection();
    DocumentReference<UserModel> userDoc = usersCollection.doc(id);
    DocumentSnapshot<UserModel> docSnapshot = await userDoc.get();
    UserModel? user = docSnapshot.data();
    return user;
  }


  static Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn signIn = GoogleSignIn.instance;
    signIn.initialize(
        clientId: "230468482007-9fr6sq7p2aghjr779ioc3ssn8qidusg4.apps.googleusercontent.com",
        serverClientId: "230468482007-d8nsferc4brf8pbeg6cecs8iprd4ne0u.apps.googleusercontent.com");

    final GoogleSignInAccount? googleUser = await signIn.authenticate();
    if (googleUser == null) return;
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken);
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    UIUtils.showLoading(context);
    UserModel? existingUser = await getUserFromFirestore(
        userCredential.user!.uid);
    if (existingUser == null) {
      UserModel newUser = UserModel(
        userId: userCredential.user!.uid,
        email: userCredential.user!.email ?? "no email",
        userName: userCredential.user!.displayName ?? "Google User",
        favEventsIds: [],
      );
      await addUserToFirebase(newUser);
      UserModel.currentUser = newUser;
    } else {
      UserModel.currentUser = existingUser;
    }
    UIUtils.hideLoading(context);
  }

  static CollectionReference<EventModel> _getEventCollection(BuildContext context){
    FirebaseFirestore db=FirebaseFirestore.instance;
   return db.collection(ConstantManager.events).withConverter(fromFirestore: (snapshot, options) => EventModel.fromJson(snapshot.data()!,context), toFirestore: (event, options) => event.toJson(),);
  }


  static Future<void> addEventToFirebase(EventModel event,BuildContext context) async {
    CollectionReference<EventModel> eventCollection=_getEventCollection(context);
    DocumentReference<EventModel> eventDoc =eventCollection.doc();
    event.id=eventDoc.id;
    await eventDoc.set(event);
  }


  static Stream<List<EventModel>> getEventFromFirebase(BuildContext context,CategoryModel category) async* {
  CollectionReference<EventModel> eventCollection =_getEventCollection(context);
  Stream<QuerySnapshot<EventModel>> eventCollectionSnapShot= eventCollection.where("categoryId",isEqualTo: category.id =="0" ? null :category.id).orderBy("date").snapshots();
  Stream<List<EventModel>> events = eventCollectionSnapShot.map(
    (eventSnapShot) => eventSnapShot.docs.map((eventSnapShot) => eventSnapShot.data(),).toList(),
  );
  yield* events;

  }


  static Future<List<EventModel>> getFavEvents(BuildContext context)async{
    if (UserModel.currentUser!.favEventsIds.isEmpty) {
      return [];
    }
    CollectionReference<EventModel> eventCollection =_getEventCollection(context);
    QuerySnapshot<EventModel> eventSnapShot = await eventCollection.where("id",whereIn: UserModel.currentUser!.favEventsIds).get();
    List<EventModel> events =eventSnapShot.docs.map((eventSnapShot) => eventSnapShot.data(),).toList();
    return events;
  }

  static Future<void> addEventToFav(String eventId){
    UserModel.currentUser!.favEventsIds.add(eventId);
    UIUtils.showMsg("added successfully", Colors.green);
    CollectionReference<UserModel> userCollection =_getUserCollection();
    DocumentReference<UserModel> userDoc=userCollection.doc(UserModel.currentUser!.userId);
    return userDoc.set(UserModel.currentUser!);
  }


  static Future<void> removeEventFromFav(String eventId){
    bool successfulRemoving =UserModel.currentUser!.favEventsIds.remove(eventId);
    if(successfulRemoving){
      UIUtils.showMsg("removed successfully", Colors.green);
    }else{
      UIUtils.showMsg("there is an error", Colors.red);
    }
    CollectionReference<UserModel> userCollection =_getUserCollection();
    DocumentReference<UserModel> userDoc=userCollection.doc(UserModel.currentUser!.userId);
    return userDoc.set(UserModel.currentUser!);
  }



}