import 'package:evently/configration/theme/theme_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/core/routes_manager/routes_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main(){
  return runApp(ChangeNotifierProvider(
      child: Evently(),
    create: (context) => ConfigProvider(),
  )
  );
}
class Evently extends StatelessWidget{
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
        initialRoute: Routes.mainLayout ,
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