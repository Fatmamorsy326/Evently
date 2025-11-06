import 'package:evently/core/UIUtils.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/resources/validation.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/core/widgets/custom_text_button.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/register_request.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool  isSecurePassword=true;
  bool  isSecureRePassword=true;
  GlobalKey<FormState> regFormKey =GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  void togglePasswordVisibility(){
    isSecurePassword=!isSecurePassword;
    setState(() {

    });
  }
  void toggleRePasswordVisibility(){
    isSecureRePassword=!isSecureRePassword;
    setState(() {

    });
  }
  @override
  void initState() {
    nameController=TextEditingController();
    emailController=TextEditingController();
    passwordController=TextEditingController();
    rePasswordController=TextEditingController();
    super.initState();
  }
@override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
       body: SingleChildScrollView(
         padding:REdgeInsets.only(left: 16,right: 16, bottom: MediaQuery.of(context).viewInsets.bottom,top: 47.h) ,
         child: Form(
           key: regFormKey,
           child: Column(
             children: [
               Image.asset(ImagesManager.logo),
               SizedBox(
                 height: 24.h,
               ),
               TextFormField(
                 controller: nameController,
                 validator: (value) => Validation.nameValidation(value, context),
                 keyboardType: TextInputType.name,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.person),
                   labelText: AppLocalizations.of(context)!.name,
                 ),
               ),
               SizedBox(height: 16.h,),
               TextFormField(
                 controller: emailController,
                 validator: (value) => Validation.emailValidation(value, context),
                 keyboardType: TextInputType.emailAddress,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.email),
                   labelText: AppLocalizations.of(context)!.email,
                 ),
               ),
               SizedBox(height: 16.h,),
               TextFormField(
                 controller: passwordController,
                 validator: (value) => Validation.emailValidation(value, context),
                 obscureText: isSecurePassword,
                 keyboardType: TextInputType.visiblePassword,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.lock),
                   labelText: AppLocalizations.of(context)!.password,
                   suffixIcon: IconButton(icon: isSecurePassword?Icon(Icons.visibility_off):Icon(Icons.visibility), onPressed: () {
                     togglePasswordVisibility();
                   },),
                 ),
               ),
               SizedBox(height: 16.h,),
               TextFormField(
                 validator: (value) {
                   return Validation.rePasswordValidation(rePasswordController.text, passwordController.text,context);
                 },
                 controller: rePasswordController,
                 keyboardType: TextInputType.visiblePassword,
                 obscureText: isSecureRePassword,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.lock),
                   labelText: AppLocalizations.of(context)!.re_password,
                   suffixIcon: IconButton(icon: isSecureRePassword?Icon(Icons.visibility_off):Icon(Icons.visibility), onPressed: () {
                     toggleRePasswordVisibility();
                   },),
                 ),
               ),
               SizedBox(height: 16.h,),
               SizedBox(
                 width: double.infinity,
                   child: ElevatedButton(onPressed: (){
                     createAccount();
                   }, child: Text(AppLocalizations.of(context)!.create_account))),
               SizedBox(height: 16.h,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(AppLocalizations.of(context)!.already_have_account,style: Theme.of(context).textTheme.bodySmall,),
                   CustomTextButton(text:AppLocalizations.of(context)!.login,onTap:(){
                     Navigator.pushReplacementNamed(context, Routes.login);
                   } ,),
                 ],
               ),
             ],
           ),
         ),
       ),
    );
  }

  Future<void> createAccount() async {
    if(regFormKey.currentState?.validate()==false){
      return;
    }
    try {
      UIUtils.showLoading(context);
      UserCredential userCredential= await FirebaseService.register(RegisterRequest(password: passwordController.text, email: emailController.text));
      await FirebaseService.addUserToFirebase(UserModel(userId: userCredential.user!.uid, email: emailController.text, userName: nameController.text));
      UIUtils.hideLoading(context);
      UIUtils.showMsg(AppLocalizations.of(context)!.successfully_registration,Colors.green);
      Navigator.pushReplacementNamed(context, Routes.login);
    } on FirebaseAuthException catch (e) {
      UIUtils.hideLoading(context);
      UIUtils.showMsg(e.code,ColorsManager.red);
    } catch (e) {
      UIUtils.hideLoading(context);
      UIUtils.showMsg(AppLocalizations.of(context)!.some_thing_wrong,ColorsManager.red);
    }
  }
}
