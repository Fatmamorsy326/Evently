import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EventShortcutItem extends StatelessWidget {
  EventModel eventModel;
  EventShortcutItem({super.key,required this.eventModel});

  @override
  Widget build(BuildContext context) {
    var configProvider=Provider.of<ConfigProvider>(context);
    return Container(
      width: 321.w,
      height: 94.h,
      padding: REdgeInsets.all(8),
      margin:   REdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color:configProvider.isDark ?ColorsManager.darkBlue : ColorsManager.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorsManager.blue,width: 1)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(eventModel.category.image,width: 138.w,fit: BoxFit.cover,)),
          SizedBox(width: 10.w,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    fit:FlexFit.loose ,
                    flex: 2 ,
                    child: Text(eventModel.title,style: Theme.of(context).textTheme.labelMedium,)
                ),
                SizedBox(height: 8.h,),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Flexible(
                      fit:FlexFit.loose ,
                        flex: 1 ,
                        child: Text("Alex , Egypt ",style: Theme.of(context).textTheme.labelSmall,)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
