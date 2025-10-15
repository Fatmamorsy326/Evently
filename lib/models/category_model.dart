import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  IconData icon;
  String id;

  CategoryModel({required this.name,required this.icon,required this.id});
  static List<CategoryModel> allCategories=[
    CategoryModel(name: "ALL", icon: Icons.all_inclusive_outlined, id: "0"),
    CategoryModel(name: "sport", icon: Icons.directions_bike_outlined, id: "1"),
    CategoryModel(name: "Birthday", icon: Icons.cake, id: "2"),
    CategoryModel(name: "Eating", icon: Icons.local_pizza_outlined, id: "3"),
    CategoryModel(name: "Holiday", icon: Icons.holiday_village_outlined, id: "4"),
    CategoryModel(name: "Book club", icon: Icons.book, id: "5"),
    CategoryModel(name: "Workshop", icon: Icons.work, id: "6"),
    CategoryModel(name: "Gaming", icon: Icons.games_outlined, id: "7"),
    CategoryModel(name: "Meeting", icon: Icons.laptop, id: "8"),

  ];

}