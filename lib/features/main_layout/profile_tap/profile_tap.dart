import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/widgets/custom_drop_down_button.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    var configProvider=Provider.of<ConfigProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding:  REdgeInsets.only(top: 48,left:16 ,right:16 ,bottom: 16),
            decoration: BoxDecoration(
              color: ColorsManager.blue,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64.r)),
            ),
            child: Row(
              children: [
                Image.asset(ImagesManager.rectangle),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("fatma morsy",style: GoogleFonts.inter(fontSize:24.sp ,fontWeight: FontWeight.w700,color: ColorsManager.white,decoration: TextDecoration.none,
                      ),),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("johnsafwat.route@gmail.com",style: GoogleFonts.inter(fontSize:16.sp ,fontWeight: FontWeight.w500,color: ColorsManager.white,decoration: TextDecoration.none,
                      ),),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:  REdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h,),
                  Text(AppLocalizations.of(context)!.language,style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(height: 16.h,),
                  CustomDropDownButton(selectedValue: configProvider.isEn?"English":"عربي",list: ["English","عربي"],onChange: (newLanguage) {
                    configProvider.changeLanguage(newLanguage=="English"?"en":"ar");
                  },),
                  SizedBox(height: 16.h,),
                  Text(AppLocalizations.of(context)!.theme,style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(height: 16.h,),
                  CustomDropDownButton(selectedValue: configProvider.isDark?AppLocalizations.of(context)!.dark:AppLocalizations.of(context)!.light,list: [AppLocalizations.of(context)!.light,AppLocalizations.of(context)!.dark],onChange: (newTheme) {
                    newTheme==AppLocalizations.of(context)!.dark?configProvider.changeTheme(ThemeMode.dark):configProvider.changeTheme(ThemeMode.light);
                  },),
                  Spacer(),
                  ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.babyRed,
                        padding: REdgeInsets.all(16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16.r))
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.output_sharp),
                        SizedBox(width: 8.w,),
                        Text(AppLocalizations.of(context)!.logout,style: GoogleFonts.inter(fontSize:20.sp ,fontWeight:FontWeight.w400 ,color: ColorsManager.white),)
                      ],
                    ),),
                  SizedBox(height: 28.h,)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
