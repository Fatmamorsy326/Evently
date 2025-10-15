import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/widgets/custom_tab_bar.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
        color: ColorsManager.blue,
      ),
      padding: REdgeInsets.only(top: 40.h,left: 16.w,right: 16.w ,bottom: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back ✨",style: Theme.of(context).textTheme.headlineMedium,),
                  Text("John Safwat",style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              Spacer(),
              Icon(Icons.light_mode_rounded,color: ColorsManager.white,),
              Card(
                margin: REdgeInsets.only(left: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                child: Padding(
                  padding:  REdgeInsets.all(8.0),
                  child: Text("EN",style: Theme.of(context).textTheme.headlineSmall,),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Icon(Icons.location_on,color: ColorsManager.white,),
              Text("Cairo , Egypt",style: Theme.of(context).textTheme.headlineMedium,),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          CustomTabBar(
            unselectedFgColor: ColorsManager.white,
            unselectedBgColor:Theme.of(context).primaryColor ,
            selectedFgColor: Theme.of(context).primaryColor,
            selectedBgColor: ColorsManager.white,
            category: CategoryModel.allCategories,
          ),
        ],
      ),
    );
  }
}
