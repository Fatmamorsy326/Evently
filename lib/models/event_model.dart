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

  EventModel({required this.id,required this.category, required this.title,required this.description,required this.date,required this.latitude,required this.longitude});

  EventModel.fromJson(Map<String,dynamic>json,BuildContext context): this(id: json["id"],title: json["title"],description: json["description"],longitude: json["longitude"],latitude: json["latitude"],date: (json["date"] as Timestamp).toDate(),category:CategoryModel.categories(context).firstWhere((category) => category.id==json["categoryId"],) );

  Map<String,dynamic> toJson()=>{
    "id": id,
    "categoryId":category.id,
    "title" :title,
    "description":description,
    "date": date,
    "latitude":latitude,
    "longitude":longitude,
  };


  static List<EventModel> events=[
    EventModel(
      id: "1",
      category: CategoryModel(name: "gaming", icon: Icons.all_inclusive_outlined, id: "0",image: ImagesManager.meeting),
      title: "Football Championship",
      description: "Local football tournament finals at Cairo Stadium.",
      date: DateTime(2025, 11, 10),
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    EventModel(
      id: "2",
      category: CategoryModel(name: "gaming", icon: Icons.all_inclusive_outlined, id: "0",image: ImagesManager.meeting),
      title: "Mona’s Birthday Party",
      description: "Celebrate Mona’s birthday with cake and music!",
      date: DateTime(2025, 11, 12),
      latitude: 30.0500,
      longitude: 31.2400,
    ),
    EventModel(
      id: "3",
      category: CategoryModel(name: "gaming", icon: Icons.all_inclusive_outlined, id: "0",image: ImagesManager.meeting),
      title: "Pizza Night",
      description: "Enjoy different types of pizza with friends.",
      date: DateTime(2025, 11, 14),
      latitude: 30.0600,
      longitude: 31.2500,
    ),
    EventModel(
      id: "4",
      category: CategoryModel(name: "gaming", icon: Icons.all_inclusive_outlined, id: "0",image: ImagesManager.meeting),
      title: "Weekend Getaway",
      description: "Join us for a relaxing beach trip to Ain Sokhna.",
      date: DateTime(2025, 11, 20),
      latitude: 29.6000,
      longitude: 32.3167,
    ),
    EventModel(
      id: "5",
      category: CategoryModel(name: "gaming", icon: Icons.all_inclusive_outlined, id: "0",image: ImagesManager.meeting),
      title: "Book Club Meeting",
      description: "Discuss 'The Alchemist' with fellow readers.",
      date: DateTime(2025, 11, 22),
      latitude: 30.0700,
      longitude: 31.2300,
    ),
    EventModel(
      id: "6",
      category: CategoryModel(name: "gaming", icon: Icons.all_inclusive_outlined, id: "0",image: ImagesManager.meeting),
      title: "Flutter Workshop",
      description: "Learn Flutter basics and build your first app.",
      date: DateTime(2025, 11, 25),
      latitude: 30.0450,
      longitude: 31.2200,
    ),

  ];
}