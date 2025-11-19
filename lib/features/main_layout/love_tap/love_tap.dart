import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/widgets/event_item.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoveTap extends StatefulWidget {
  const LoveTap({super.key});

  @override
  State<LoveTap> createState() => _LoveTapState();
}

class _LoveTapState extends State<LoveTap> {
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
          FutureBuilder(future: FirebaseService.getFavEvents(context), builder:(context, snapshot) {
            if(snapshot.connectionState== ConnectionState.waiting){
              return Expanded(child: Center(child: CircularProgressIndicator(),));
            }
            if(snapshot.hasError){
              print(snapshot.error.toString());
              return Expanded(child: Center(child: Text("Error loading favorites: ${snapshot.error.toString()}",),));
            }
            List<EventModel> events =snapshot.data ?? [];
            if (events.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    "No favorite events yet",
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => EventItem(event: events[index],),
                itemCount: events.length,),
            );
          },),

        ],
      ),
    );
  }
}
