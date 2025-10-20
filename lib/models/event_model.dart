import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';

class EventModel {
  CategoryModel category;
  String title;
  String description;
  DateTime date;
  TimeOfDay time;

  EventModel({required this.category, required this.title,required this.description,required this.date,required this.time});
}