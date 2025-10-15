import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTabBarItem extends StatelessWidget{
  CategoryModel category;
  CategoryTabBarItem({super.key,required this.category,required this.selectedBgColor,required this.selectedFgColor,required this.unselectedBgColor,required this.unselectedFgColor,required this.isSelected});
  Color selectedBgColor;
  Color unselectedBgColor;
  Color selectedFgColor;
  Color unselectedFgColor;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  REdgeInsets.symmetric(horizontal:16 ,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46.r),
        border: Border.all(color: isSelected?selectedFgColor:unselectedFgColor,width: 1.w),
        color: isSelected?selectedBgColor:unselectedBgColor
      ),
      child: Row(
        children: [
          Icon(category.icon,color: isSelected?selectedFgColor:unselectedFgColor,),
          SizedBox(
            width: 8.w,
          ),
          Text(category.name,style: GoogleFonts.inter(fontSize:16.sp ,fontWeight:FontWeight.w500 ,color: isSelected?selectedFgColor:unselectedFgColor))
        ],
      ),
    );
  }
}
