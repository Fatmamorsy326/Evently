import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/features/Authentication/login/login.dart';
import 'package:evently/features/Authentication/register/register.dart';
import 'package:evently/features/create_event/create_event.dart';
import 'package:evently/features/create_event/edit_event.dart';
import 'package:evently/features/create_event/event_details.dart';
import 'package:evently/features/create_event/location_picker_map.dart';
import 'package:evently/features/main_layout/home_tap/home_tap.dart';
import 'package:evently/features/main_layout/location_tap/location_tap.dart';
import 'package:evently/features/main_layout/love_tap/love_tap.dart';
import 'package:evently/features/main_layout/main_layout.dart';
import 'package:evently/features/main_layout/profile_tap/profile_tap.dart';
import 'package:evently/onboarding/onboarding_screen.dart';
import 'package:evently/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {


  static Route? router(RouteSettings settings){
    switch(settings.name){

      case Routes.login:{
        return CupertinoPageRoute(builder: (context)=> Login());
      }
      case Routes.register:{
        return CupertinoPageRoute(builder: (context)=> Register());
      }
      case Routes.mainLayout:{
        return CupertinoPageRoute(builder: (context)=> MainLayout());
      }
      case Routes.homeTap:{
        return CupertinoPageRoute(builder: (context)=> HomeTap());
      }
      case Routes.locationTap:{
        return CupertinoPageRoute(builder: (context)=> LocationTap());
      }
      case Routes.profileTap:{
        return CupertinoPageRoute(builder: (context)=> ProfileTap());
      }
      case Routes.loveTap:{
        return CupertinoPageRoute(builder: (context)=> LoveTap());
      }
      case Routes.createEvent:{
        return CupertinoPageRoute(builder: (context)=> CreateEvent());
      }
      case Routes.eventDetails:{
        return CupertinoPageRoute(builder: (context)=> EventDetails(), settings: settings);
      }
      case Routes.editEvent:{
        return CupertinoPageRoute(builder: (context)=> EditEvent(), settings: settings);
      }
      case Routes.onboarding:{
        return CupertinoPageRoute(builder: (context)=> OnboardingScreen(), settings: settings);
      }
      case Routes.splashScreen:{
        return CupertinoPageRoute(builder: (context)=> SplashScreen(), settings: settings);
      }
      case Routes.locationPickerMap:{
        return CupertinoPageRoute(builder: (context)=> LocationPickerMap(), settings: settings);
      }
    }
  }
}