import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/features/main_layout/home_tap/home_tap.dart';
import 'package:evently/features/main_layout/location_tap/location_tap.dart';
import 'package:evently/features/main_layout/love_tap/love_tap.dart';
import 'package:evently/features/main_layout/profile_tap/profile_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> taps=[
    HomeTap(),
    LocationTap(),
    LoveTap(),
    ProfileTap(),
  ];
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: taps[currentIndex],
      bottomNavigationBar:BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(currentIndex!=0?Icons.home_outlined:Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(currentIndex!=1?Icons.location_on_outlined:Icons.location_on),label: "Map"),
          BottomNavigationBarItem(icon: Icon(currentIndex!=2?Icons.favorite_border:Icons.favorite),label: "Love"),
          BottomNavigationBarItem(icon: Icon(currentIndex!=3?Icons.person_2_outlined:Icons.person_2_rounded),label: "Profile"),
        ],
        currentIndex: currentIndex,
        onTap: _onTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createEvent,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  void _onTap(int index){
    setState(() {
      currentIndex=index;
    });
  }

  void _createEvent() {
    Navigator.pushNamed(context, Routes.createEvent);
  }
}
