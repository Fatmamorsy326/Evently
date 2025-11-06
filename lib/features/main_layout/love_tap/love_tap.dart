import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/widgets/event_item.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoveTap extends StatelessWidget {
  const LoveTap({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:  REdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search_for_event,
                hintStyle: Theme.of(context).textTheme.labelMedium,
                prefixIcon: Icon(Icons.search,color: ColorsManager.blue,size: 24,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(width: 1,color: ColorsManager.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(width: 1,color: ColorsManager.blue),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => EventItem(event: EventModel(id: "1",category: CategoryModel.allCategories(context)[5], title: "This is a Birthday Party", description: "sdfghjm", date: DateTime.now(),latitude:	31.205753 ,longitude: 29.924526
              ),),
              itemCount: 5,),
          )
        ],
      ),
    );
  }
}
