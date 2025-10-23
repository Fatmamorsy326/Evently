import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme= ThemeMode.light;
  String currentLanguage="en";
  void changeTheme(ThemeMode newTheme){
    if(currentTheme==newTheme)return;
    currentTheme=newTheme;
    notifyListeners();
  }
  void toggleTheme(){
    if(currentTheme==ThemeMode.light){
      currentTheme=ThemeMode.dark;
    }
    else{
      currentTheme=ThemeMode.light;
    }
    notifyListeners();
  }
  bool get isDark => currentTheme==ThemeMode.dark;
  void changeLanguage(String newLanguage){
    if(currentLanguage==newLanguage)return;
    currentLanguage=newLanguage;
    notifyListeners();
  }
  void toggleLanguage(){
    if(currentLanguage=="en"){
      currentLanguage="ar";
    }
    else{
      currentLanguage="en";
    }
    notifyListeners();
  }
  bool get isEn => currentLanguage=="en";
}