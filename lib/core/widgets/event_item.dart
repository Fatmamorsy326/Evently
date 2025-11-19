import 'package:evently/core/extensions/date_ex.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventItem extends StatefulWidget{
  EventModel event;
  EventItem({super.key,required this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  bool get isFav => UserModel.currentUser!.favEventsIds.contains(widget.event.id);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        margin:REdgeInsets.symmetric(horizontal: 16, vertical: 8) ,
        padding: REdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: double.infinity,
        height: 203.h,
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: ColorsManager.blue),
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(image: AssetImage(widget.event.category.image),fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding:  REdgeInsets.symmetric(vertical:8 ,horizontal: 10),
                child: Column(
                  children: [
                    Text("${widget.event.date.day}",style: Theme.of(context).textTheme.labelLarge,),
                    Text(widget.event.date.monthName,style: Theme.of(context).textTheme.labelMedium,),
                  ],
                ),
              ),
            ),
            Spacer(),
            Card(
              child: Padding(
                padding:  REdgeInsets.symmetric(vertical:10 ,horizontal: 8),
                child: Row(
                   children: [
                     Expanded(child: Text(widget.event.title,style: Theme.of(context).textTheme.labelSmall,)),
                     IconButton(onPressed: _addToOrRemoveFromFav, icon:  Icon(isFav?Icons.favorite:Icons.favorite_border,color: ColorsManager.blue,),padding: EdgeInsets.zero,constraints: BoxConstraints(),),
                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToOrRemoveFromFav() {
    if(isFav){
      FirebaseService.removeEventFromFav(widget.event.id);
    }
    else{
      FirebaseService.addEventToFav(widget.event.id);
    }
    setState(() {

    });
  }
}
