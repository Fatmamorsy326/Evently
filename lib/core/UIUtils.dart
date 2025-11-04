import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static void showLoading(BuildContext context, {bool canPop = true}){
    showDialog(
      barrierDismissible: false,
      context: context, builder: (context) => PopScope(
        canPop: canPop,
        child: CupertinoAlertDialog(content: Center(child: SizedBox(width:50.w,height: 50.h,child: CircularProgressIndicator())),)),);
  }
  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }
  static showMsg(String msg,Color color){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}