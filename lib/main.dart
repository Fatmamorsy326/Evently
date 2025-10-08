import 'package:evently/configration/theme/theme_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/core/routes_manager/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(){
  return runApp(Evently());
}
class Evently extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 841),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.router,
        initialRoute: Routes.register ,
        theme:ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: ThemeMode.light,
      ),
    );
  }

}