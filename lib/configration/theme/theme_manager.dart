import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light =ThemeData(
    primaryColor: ColorsManager.blue,
    useMaterial3: false,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.white,
      backgroundColor: ColorsManager.blue,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        size: 24,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: StadiumBorder(
          side: BorderSide(color: ColorsManager.white,width: 5.w)
      ),
      elevation: 0,
      iconSize: 24,
    ),
    scaffoldBackgroundColor: ColorsManager.white,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1,color: ColorsManager.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1,color: ColorsManager.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1,color: ColorsManager.grey),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1,color: ColorsManager.grey),
      ),
      labelStyle: GoogleFonts.inter(color: ColorsManager.grey,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,),
      prefixIconColor: ColorsManager.grey,
      suffixIconColor: ColorsManager.grey,
      fillColor: ColorsManager.grey,
      hintStyle: GoogleFonts.inter(color: ColorsManager.grey,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16.r),
        ),
        padding: REdgeInsets.symmetric(vertical: 16,horizontal: 16),
        foregroundColor: ColorsManager.white,
        textStyle: GoogleFonts.inter(fontSize:20.sp ,fontWeight: FontWeight.w500)
      )
    ),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.inter(
        fontWeight:FontWeight.w500 ,
        fontSize:16.sp ,
        color: ColorsManager.black
      ),
      bodyLarge: GoogleFonts.inter(
        fontWeight:FontWeight.w500 ,
        fontSize:16.sp ,
        color: ColorsManager.white,
      ),
      headlineSmall: GoogleFonts.inter(
        fontWeight:FontWeight.w500 ,
        fontSize:20.sp ,
        color: ColorsManager.blue
      ),
      headlineLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: ColorsManager.white,
      ),
      headlineMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: ColorsManager.white,
      ),
      labelMedium: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize:14 ,color: ColorsManager.blue),
      labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize:20 ,color: ColorsManager.blue),
      labelSmall: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize:14 ,color: ColorsManager.black,letterSpacing: 0.3,height: 1.4),
      titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w400,color: ColorsManager.blue)
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.white,
      iconTheme: IconThemeData(
        color: ColorsManager.blue
      )
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16.r),

        ),
        side: BorderSide(
            color: ColorsManager.blue,
            width: 1.w,
          )
      )
    ),
    cardTheme: CardThemeData(
      color: ColorsManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    )
  );
  static final ThemeData dark =ThemeData(
    scaffoldBackgroundColor: ColorsManager.darkBlue,

  );
}