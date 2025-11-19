import 'package:evently/core/widgets/category_tab_bar_item.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({super.key,required this.categories,required this.selectedBgColor,required this.selectedFgColor,required this.unselectedBgColor,required this.unselectedFgColor,this.itemOnClicked});
  List<CategoryModel> categories;
  Color selectedBgColor;
  Color unselectedBgColor;
  Color selectedFgColor;
  Color unselectedFgColor;
  void Function(CategoryModel category)?itemOnClicked;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex=0;
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        onTap: _onTap,
        isScrollable: true,
        labelPadding: REdgeInsets.only(right: 8),
        padding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.transparent,
        tabs: widget.categories.map((category) => CategoryTabBarItem(
          category: category,
          isSelected:selectedIndex==widget.categories.indexOf(category) ,
          selectedBgColor:widget.selectedBgColor ,
          selectedFgColor: widget.selectedFgColor,
          unselectedBgColor:widget.unselectedBgColor ,
          unselectedFgColor: widget.unselectedFgColor,
        ),).toList(),
      ),
    );
  }

  void _onTap(int index) {
    widget.itemOnClicked?.call(widget.categories[index]);
    setState(() {
      selectedIndex=index;
    });
  }


}
