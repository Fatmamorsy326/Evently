import 'package:evently/core/widgets/category_tab_bar_item.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({super.key,required this.category,required this.selectedBgColor,required this.selectedFgColor,required this.unselectedBgColor,required this.unselectedFgColor,});
  List<CategoryModel> category;
  Color selectedBgColor;
  Color unselectedBgColor;
  Color selectedFgColor;
  Color unselectedFgColor;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex=0;
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: CategoryModel.allCategories.length,
      child: TabBar(
        onTap: _onTap,
        isScrollable: true,
        padding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.transparent,
        tabs: widget.category.map((category) => CategoryTabBarItem(
          category: category,
          isSelected:selectedIndex==widget.category.indexOf(category) ,
          selectedBgColor:widget.selectedBgColor ,
          selectedFgColor: widget.selectedFgColor,
          unselectedBgColor:widget.unselectedBgColor ,
          unselectedFgColor: widget.unselectedFgColor,
        ),).toList(),
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      selectedIndex=index;
    });
  }
}
