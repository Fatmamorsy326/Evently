import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/features/main_layout/location_tap/event_shortcut_item.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationTap extends StatefulWidget {
  const LocationTap({super.key});

  @override
  State<LocationTap> createState() => _LocationTapState();
}

class _LocationTapState extends State<LocationTap> {
  late GoogleMapController _controller;
  LatLng? initLocation;
  Location location=Location();

  @override
  void initState() {
   initMap();
    super.initState();
  }

   Future<void> initMap() async {
     bool serviceEnabled = await location.serviceEnabled();
     if (!serviceEnabled) {
       serviceEnabled = await location.requestService();
       if (!serviceEnabled) {
         return;
       }
     }
     PermissionStatus permissionGranted = await location.hasPermission();
     if (permissionGranted == PermissionStatus.denied) {
       permissionGranted = await location.requestPermission();
       if (permissionGranted != PermissionStatus.granted) {
         return;
       }
     }

     LocationData locationData = await location.getLocation();
     setState(() {
       initLocation=LatLng(locationData.latitude!, locationData.longitude!);
     });
   }


  @override
  Widget build(BuildContext context) {
    var configProvider=Provider.of<ConfigProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: initLocation == null ? Center(child: CircularProgressIndicator(),): StreamBuilder(stream: FirebaseService.getEventFromFirebase(context, CategoryModel.allCategories(context)[0]), builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<EventModel> eventList= snapshot.data ?? [];
              return GoogleMap(
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  _controller =controller;
                },
                // onCameraMove: (position) => print(position),
                initialCameraPosition: CameraPosition(target: initLocation! ,zoom: 17),
                markers: _setMarkers(eventList),
              );
            },),
          ),




          Positioned(
              bottom: 32.h,
              left: 0,
              right: 0,
              height: 94.h,
              child: StreamBuilder(stream:FirebaseService.getEventFromFirebase(context, CategoryModel.allCategories(context)[0]) , builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                List<EventModel> eventList= snapshot.data ?? [];
                return ListView.builder(itemBuilder: (context, index) => EventShortcutItem(eventModel: eventList[index]),itemCount: 5,scrollDirection: Axis.horizontal,);
              },)
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(onPressed: (){
        _returnToMyLocation();
      },child: Icon(Icons.gps_fixed,color: configProvider.isDark?ColorsManager.black:ColorsManager.white,),backgroundColor: ColorsManager.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),),
    );
  }

  Future<void> _returnToMyLocation() async {
    await _controller.animateCamera(duration: Duration(milliseconds: 600),CameraUpdate.newCameraPosition(CameraPosition(target: initLocation!,zoom: 17)));
  }

  _setMarkers(List<EventModel> events) {
    return events.map((e) => Marker(
        infoWindow: InfoWindow(title: e.title),
        markerId: MarkerId(e.id) ,
        position: LatLng(e.latitude, e.longitude)),
    ).toSet();
  }
}
