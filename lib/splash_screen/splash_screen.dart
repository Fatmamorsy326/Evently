import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState()  {
    // TODO: implement initState
     Future.delayed(const Duration(seconds: 2),() async {
      final prefs =await SharedPreferences.getInstance();
      final seenOnBoarding=prefs.getBool("seenOnboarding") ?? false;
      Navigator.pushReplacementNamed(context, seenOnBoarding?(FirebaseAuth.instance.currentUser==null?Routes.login:Routes.mainLayout):Routes.onboarding);
    },);
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 8,child: Image.asset(ImagesManager.logo)),
            Expanded(flex: 2,child: Image.asset(ImagesManager.route)),
          ],
        ),
      ),
    );
  }
}
