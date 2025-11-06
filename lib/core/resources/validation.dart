import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

abstract class Validation {
static String? emailValidation(String? email,BuildContext context){
  final RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if(email==null || email.trim().isEmpty){
    return AppLocalizations.of(context)!.email_required;
  }
  else if(!regex.hasMatch(email)){
    return AppLocalizations.of(context)!.email_not_valid;
  }
  return null;
}
static String? passwordValidation(String? password,BuildContext context){
  final RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if(password==null || password.trim().isEmpty){
    return AppLocalizations.of(context)!.password_required;
  }
  else if(password.trim().length<8){
    return AppLocalizations.of(context)!.password_too_short;
  }
  else if(!regex.hasMatch(password)){
    return AppLocalizations.of(context)!.password_not_strong;
  }
  return null;
}
static String? nameValidation(String? name,BuildContext context){
  if(name==null || name.trim().isEmpty){
    return AppLocalizations.of(context)!.name_required;
  }
  else if(name.trim().length<3){
    return AppLocalizations.of(context)!.name_too_short;
  }
  return null;
}
static String? rePasswordValidation(String? rePassword ,String? password,BuildContext context){
  if(rePassword==null || rePassword.trim().isEmpty){
    return AppLocalizations.of(context)!.repassword_required;
  }
  else if(rePassword != password){
    return AppLocalizations.of(context)!.password_not_match;
  }
  return null;
}

static String? titleValidation(String? title,BuildContext context){
  if(title==null || title.trim().isEmpty){
    return AppLocalizations.of(context)!.title_required;
  }
  if(title.trim().length<4){
    return AppLocalizations.of(context)!.title_not_valid;
  }
  return null ;
}

static String? descriptionValidation(String? description,BuildContext context){
  if(description== null || description.trim().isEmpty){
    return AppLocalizations.of(context)!.description_required;
  }
  if(description.trim().length<4){
    return AppLocalizations.of(context)!.description_not_valid;
  }
  return null ;
}
}