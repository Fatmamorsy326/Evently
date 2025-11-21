import 'package:evently/configration/theme/theme_manager.dart';
import 'package:evently/core/prefs_manager/prefs_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/core/routes_manager/routes_manager.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PrefsManager.init();
  final prefs =await SharedPreferences.getInstance();
  final seenOnBoarding=prefs.getBool("seenOnboarding") ?? false;

  if(FirebaseAuth.instance.currentUser != null){
    UserModel.currentUser = await FirebaseService.getUserFromFirestore(FirebaseAuth.instance.currentUser!.uid);
  }
  return runApp(ChangeNotifierProvider(
      child: Evently(seenOnBoarding: seenOnBoarding,),
    create: (context) => ConfigProvider(),
  )
  );
}
class Evently extends StatelessWidget{
  bool seenOnBoarding;
  Evently({required this.seenOnBoarding});

  @override
  Widget build(BuildContext context) {
    var configProvider=Provider.of<ConfigProvider>(context);
    return ScreenUtilInit(
      designSize: Size(393, 841),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.router,
        initialRoute: Routes.splashScreen ,
        theme:ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: configProvider.currentTheme,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        locale: Locale(configProvider.currentLanguage),
      ),
    );
  }

}