import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  IconData icon;
  String id;
  String image;

  CategoryModel({required this.name,required this.icon,required this.id,required this.image});
  static List<CategoryModel> allCategories(BuildContext context){
    AppLocalizations appLocalizations=AppLocalizations.of(context)!;
    return [
      CategoryModel(name: appLocalizations.all, icon: Icons.all_inclusive_outlined, id: "0",image: ""),
      CategoryModel(name: appLocalizations.sports, icon: Icons.directions_bike_outlined, id: "1",image: ImagesManager.sport),
      CategoryModel(name: appLocalizations.birthday, icon: Icons.cake, id: "2",image: ImagesManager.birthday),
      CategoryModel(name: appLocalizations.eating, icon: Icons.local_pizza_outlined, id: "3",image:ImagesManager.eating ),
      CategoryModel(name: appLocalizations.holiday, icon: Icons.holiday_village_outlined, id: "4",image: ImagesManager.holiday),
      CategoryModel(name: appLocalizations.book_club, icon: Icons.book, id: "5",image: ImagesManager.bookClub),
      CategoryModel(name: appLocalizations.workshop, icon: Icons.work, id: "6",image: ImagesManager.workshop),
      CategoryModel(name: appLocalizations.gaming, icon: Icons.games_outlined, id: "7",image: ImagesManager.gaming),
      CategoryModel(name: appLocalizations.meeting, icon: Icons.laptop, id: "8",image: ImagesManager.meeting),

    ];
  }
  static List<CategoryModel> categories(BuildContext context){
    AppLocalizations appLocalizations=AppLocalizations.of(context)!;
    return [
      CategoryModel(name: appLocalizations.sports, icon: Icons.directions_bike_outlined, id: "1",image: ImagesManager.sport),
      CategoryModel(name: appLocalizations.birthday, icon: Icons.cake, id: "2",image: ImagesManager.birthday),
      CategoryModel(name: appLocalizations.eating, icon: Icons.local_pizza_outlined, id: "3",image:ImagesManager.eating ),
      CategoryModel(name: appLocalizations.holiday, icon: Icons.holiday_village_outlined, id: "4",image: ImagesManager.holiday),
      CategoryModel(name: appLocalizations.book_club, icon: Icons.book, id: "5",image: ImagesManager.bookClub),
      CategoryModel(name: appLocalizations.workshop, icon: Icons.work, id: "6",image: ImagesManager.workshop),
      CategoryModel(name: appLocalizations.gaming, icon: Icons.games_outlined, id: "7",image: ImagesManager.gaming),
      CategoryModel(name: appLocalizations.meeting, icon: Icons.laptop, id: "8",image: ImagesManager.meeting),

    ];
  }

}