import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';

class EventModel {
  String id;
  CategoryModel category;
  String title;
  String description;
  DateTime date;
  double latitude;
  double longitude;
  String creatorId;

  EventModel({required this.id,required this.category, required this.title,required this.description,required this.date,required this.latitude,required this.longitude,required this.creatorId});

  EventModel.fromJson(Map<String,dynamic>json,BuildContext context): this(id: json["id"],title: json["title"],description: json["description"],longitude: json["longitude"],latitude: json["latitude"],date: (json["date"] as Timestamp).toDate(),category:CategoryModel.categories(context).firstWhere((category) => category.id==json["categoryId"],) ,creatorId: json["creatorId"]);

  Map<String,dynamic> toJson()=>{
    "id": id,
    "title" :title,
    "description":description,
    "date": date,
    "latitude":latitude,
    "longitude":longitude,
    "categoryId":category.id,
    "creatorId":creatorId,
  };



}