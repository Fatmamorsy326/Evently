import 'package:evently/core/extensions/date_ex.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';


class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventModel;
    var configProvider=Provider.of<ConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:Text("Event Details",style: TextStyle(fontWeight: FontWeight.w400,color: ColorsManager.blue,fontSize: 22.sp)) ,
        elevation: 0,
        centerTitle: true,
          actions: FirebaseAuth.instance.currentUser!.uid==event.creatorId?
          [
          IconButton(onPressed: () {
            _editEvent(event);
          }, icon:Icon(Icons.mode_edit_outline_outlined,color: ColorsManager.blue,),),
          IconButton(onPressed: (){
            _deleteEvent(event);
          }, icon: Icon(Icons.delete_forever,color: ColorsManager.red,),),
          SizedBox(
            width: 10.w,
          ),
        ]:[],
      ),
      body: FutureBuilder(
        future: getAddressFromLatLng(event.latitude,event.longitude),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error loading address:${snapshot.error}'));
          }
          final eventPlace = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding:  REdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16.r),
                    child: Image.asset(event.category.image),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(event.title,style: TextStyle(fontWeight: FontWeight.w500,color: ColorsManager.blue,fontSize: 24.sp)),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    padding: REdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: ColorsManager.blue,width: 1)
                    ),
                    child: Row(
                      children: [
                        Card(
                          color: ColorsManager.blue,
                          child: Padding(
                            padding:  REdgeInsets.symmetric(vertical:12 ,horizontal: 12),
                            child: Icon(Icons.calendar_month_outlined,color: configProvider.isDark?ColorsManager.black:ColorsManager.white,),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(event.date.formattedDate,style: TextStyle(fontWeight: FontWeight.w500,color: ColorsManager.blue,fontSize: 16.sp)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(event.date.formattedTime,style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    padding: REdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: ColorsManager.blue,width: 1)
                    ),
                    child: Row(
                      children: [
                        Card(
                          color: ColorsManager.blue,
                          child: Padding(
                            padding:  REdgeInsets.symmetric(vertical:12 ,horizontal: 12),
                            child: Icon(Icons.my_location,color: configProvider.isDark?ColorsManager.black:ColorsManager.white,),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Text("${eventPlace.country},${eventPlace.locality}",style: TextStyle(fontWeight: FontWeight.w500,color: ColorsManager.blue,fontSize: 16.sp)),
          
                        ),
                        Icon(Icons.arrow_forward_ios_sharp,color: ColorsManager.blue,size: 24.sp,),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
          
                  SizedBox(
                    height: 16.h,
                  ),
                  Text("Description",style: Theme.of(context).textTheme.bodySmall,),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(event.description,style: Theme.of(context).textTheme.bodySmall,),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void _editEvent(EventModel event) {
    Navigator.pushReplacementNamed(context, Routes.editEvent,arguments:event );
  }

  void _deleteEvent(EventModel event) {
    FirebaseService.deleteEvent(event, context);
  }

   Future<Placemark> getAddressFromLatLng(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemarks[0];
    print("Country: ${place.country}");
    print("City: ${place.locality}");
    print("Governorate: ${place.administrativeArea}");
    print("Street: ${place.street}");
    return place;
  }
}
