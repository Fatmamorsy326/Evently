import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage =0;

  void _onIntroEnd(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seenOnboarding", true);
    Navigator.pushReplacementNamed(context, Routes.login);
  }



  @override
  Widget build(BuildContext context) {
    if(_currentPage==0){
      return _buildWelcomeScreen();
    }
    return _buildOnboarding();
  }

  Widget _buildOnboarding(){
    var configProvider=Provider.of<ConfigProvider>(context);
    return IntroductionScreen(
      onDone: () {
        _onIntroEnd(context);
      },
      done: Icon(Icons.arrow_circle_right_outlined,size: 40,),
      next: Icon(Icons.arrow_circle_right_outlined,size: 40,),
      back: Icon(Icons.arrow_circle_left_outlined,size: 40,),
      showBackButton: true,
      globalHeader: Image.asset(ImagesManager.onboardingHeader),
      globalBackgroundColor: configProvider.isDark?ColorsManager.darkBlue:ColorsManager.white,
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 28.h,
              ),
              Image.asset(ImagesManager.hotTrending),
              SizedBox(
                height: 28.h,
              ),
              Text("Find Events That Inspire You",style: TextStyle(color: ColorsManager.blue,fontWeight: FontWeight.w700,fontSize: 20.sp),),
              SizedBox(
                height: 28.h,
              ),
              Text("Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",style: Theme.of(context).textTheme.labelSmall,),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 28.h,
              ),
              Image.asset(ImagesManager.beingCreative1),
              SizedBox(
                height: 28.h,
              ),
              Text("Effortless Event Planning",style: TextStyle(color: ColorsManager.blue,fontWeight: FontWeight.w700,fontSize: 20.sp),),
              SizedBox(
                height: 28.h,
              ),
              Text("Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",style: Theme.of(context).textTheme.labelSmall,),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 28.h,
              ),
              Image.asset(ImagesManager.beingCreative2),
              SizedBox(
                height: 28.h,
              ),
              Text("Connect with Friends & Share Moments",style: TextStyle(color: ColorsManager.blue,fontWeight: FontWeight.w700,fontSize: 20.sp),),
              SizedBox(
                height: 28.h,
              ),
              Text("Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",style: Theme.of(context).textTheme.labelSmall,),
            ],
          ),
        ),

      ],
      dotsDecorator: DotsDecorator(
        color: ColorsManager.blue,
          activeSize:Size(20, 8),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36)
          ),
        activeColor: ColorsManager.blue,
      ),
    );
  }
  Widget _buildWelcomeScreen(){
    var configProvider=Provider.of<ConfigProvider>(context);
    return Scaffold(
      body:Padding(
        padding:  REdgeInsets.symmetric(vertical:27.h , horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 28.h,
            ),
            Image.asset(ImagesManager.beingCreative),
            SizedBox(
              height: 28.h,
            ),
            Text("Personalize Your Experience",style: TextStyle(color: ColorsManager.blue,fontWeight: FontWeight.w700,fontSize: 20.sp),),
            SizedBox(
              height: 28.h,
            ),
            Text("Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",style: Theme.of(context).textTheme.labelSmall,),
            Row(
              children: [
                Text("Language",style: TextStyle(color: ColorsManager.blue,fontWeight: FontWeight.w500,fontSize: 20.sp),),
                Spacer(),
                InkWell(
                  onTap:() {
                    configProvider.toggleLanguage();
                  } ,
                  child: Card(
                    color: ColorsManager.blue,
                    margin: REdgeInsets.only(right: 8),
                    child: Padding(
                      padding:  REdgeInsets.all(8.0),
                      child: Text(configProvider.currentLanguage,style: TextStyle(color: ColorsManager.white,fontSize: 14.sp,fontWeight: FontWeight.w700),),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text("Theme",style: TextStyle(color: ColorsManager.blue,fontWeight: FontWeight.w500,fontSize: 20.sp),),
                Spacer(),
                IconButton(onPressed: (){
                  configProvider.toggleTheme();
                },icon:Icon(configProvider.isDark?Icons.dark_mode:Icons.light_mode),color: ColorsManager.blue,),
              ],
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  setState(() {
                    _currentPage=1;
                  });
                }, child: Text("Let’s Start"))),
          ],
        ),
      ) ,
    );
  }
}


