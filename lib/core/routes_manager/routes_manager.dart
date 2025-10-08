import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/features/Authentication/login/login.dart';
import 'package:evently/features/Authentication/register/register.dart';
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

    }
  }
}