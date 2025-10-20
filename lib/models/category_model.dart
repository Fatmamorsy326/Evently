import 'package:evently/core/resources/images_manager.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  IconData icon;
  String id;
  String image;

  CategoryModel({required this.name,required this.icon,required this.id,required this.image});
  static List<CategoryModel> allCategories=[
    CategoryModel(name: "ALL", icon: Icons.all_inclusive_outlined, id: "0",image: ""),
    CategoryModel(name: "sport", icon: Icons.directions_bike_outlined, id: "1",image: ImagesManager.sport),
    CategoryModel(name: "Birthday", icon: Icons.cake, id: "2",image: ImagesManager.birthday),
    CategoryModel(name: "Eating", icon: Icons.local_pizza_outlined, id: "3",image:ImagesManager.eating ),
    CategoryModel(name: "Holiday", icon: Icons.holiday_village_outlined, id: "4",image: ImagesManager.holiday),
    CategoryModel(name: "Book club", icon: Icons.book, id: "5",image: ImagesManager.bookClub),
    CategoryModel(name: "Workshop", icon: Icons.work, id: "6",image: ImagesManager.workshop),
    CategoryModel(name: "Gaming", icon: Icons.games_outlined, id: "7",image: ImagesManager.gaming),
    CategoryModel(name: "Meeting", icon: Icons.laptop, id: "8",image: ImagesManager.meeting),

  ];
  static List<CategoryModel> categories=[
    CategoryModel(name: "sport", icon: Icons.directions_bike_outlined, id: "1",image: ImagesManager.sport),
    CategoryModel(name: "Birthday", icon: Icons.cake, id: "2",image: ImagesManager.birthday),
    CategoryModel(name: "Eating", icon: Icons.local_pizza_outlined, id: "3",image:ImagesManager.eating ),
    CategoryModel(name: "Holiday", icon: Icons.holiday_village_outlined, id: "4",image: ImagesManager.holiday),
    CategoryModel(name: "Book club", icon: Icons.book, id: "5",image: ImagesManager.bookClub),
    CategoryModel(name: "Workshop", icon: Icons.work, id: "6",image: ImagesManager.workshop),
    CategoryModel(name: "Gaming", icon: Icons.games_outlined, id: "7",image: ImagesManager.gaming),
    CategoryModel(name: "Meeting", icon: Icons.laptop, id: "8",image: ImagesManager.meeting),

  ];

}