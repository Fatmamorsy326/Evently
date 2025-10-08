import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light =ThemeData(
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1,color: ColorsManager.grey),
      ),
      labelStyle: GoogleFonts.inter(color: ColorsManager.grey,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,),
      prefixIconColor: ColorsManager.grey,
      suffixIconColor: ColorsManager.grey,
      fillColor: ColorsManager.grey,
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
      ),
    ),

  );
  static final ThemeData dark =ThemeData(
    scaffoldBackgroundColor: ColorsManager.darkBlue,

  );
}