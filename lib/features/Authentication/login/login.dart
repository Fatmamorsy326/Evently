import 'package:evently/core/UIUtils.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/resources/validation.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/core/widgets/custom_text_button.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/login_request.dart';
import 'package:evently/models/register_request.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool  isSecurePassword=true;
  GlobalKey<FormState> loginFormKey =GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  void togglePasswordVisibility(){
    isSecurePassword=!isSecurePassword;
    setState(() {

    });
  }
  @override
  void initState() {
    emailController=TextEditingController();
    passwordController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding:REdgeInsets.only(left: 16,right: 16, bottom: MediaQuery.of(context).viewInsets.bottom,top: 47.h) ,
        child: Form(
          key: loginFormKey,
          child: Column(
            children: [
              Image.asset(ImagesManager.logo),
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
                validator: (value) => Validation.passwordValidation(value, context),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(text: AppLocalizations.of(context)!.forget_password, onTap: (){}),
                ],
              ),
              SizedBox(height: 16.h,),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    login();
                  }, child: Text(AppLocalizations.of(context)!.login))),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.dont_have_account,style: Theme.of(context).textTheme.bodySmall,),
                  CustomTextButton(text:AppLocalizations.of(context)!.create_account,onTap:(){
                    Navigator.pushNamed(context, Routes.register);
                  } ,),
                ],
              ),
              SizedBox(height: 16.h,),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 16.w,
                      indent:26.w ,
                      thickness: 1.h,
                      color: ColorsManager.blue,
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.or,style: GoogleFonts.inter(
                      fontWeight:FontWeight.w500 ,
                      fontSize:20.sp ,
                      color: ColorsManager.blue
                  ),),
                  Expanded(
                    child: Divider(
                      endIndent: 26.w,
                      indent:16.w ,
                      thickness: 1.h,
                      color: ColorsManager.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h,),
              OutlinedButton(onPressed: (){
                _signWithGoogle();
              }, child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImagesManager.google),
                  Text(AppLocalizations.of(context)!.login_with_google,style: GoogleFonts.inter(
                      fontWeight:FontWeight.w500 ,
                      fontSize:20.sp ,
                      color: ColorsManager.blue
                  ),)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if(loginFormKey.currentState?.validate()==false)return;
    try {
      UIUtils.showLoading(context);
      UserCredential userCredential= await FirebaseService.login(LoginRequest(password: passwordController.text, email: emailController.text));
      UserModel.currentUser =await FirebaseService.getUserFromFirestore(userCredential.user!.uid);
      UIUtils.hideLoading(context);
      UIUtils.showMsg(AppLocalizations.of(context)!.successfully_login,Colors.green);
      Navigator.pushReplacementNamed(context, Routes.mainLayout);
    } on FirebaseAuthException catch (e) {
      UIUtils.showMsg(AppLocalizations.of(context)!.invalid_email_password, ColorsManager.red);
      UIUtils.hideLoading(context);
    }
  }

  Future<void> _signWithGoogle() async {
    try{
      await FirebaseService.signInWithGoogle(context);
      UIUtils.showMsg(AppLocalizations.of(context)!.successfully_login,Colors.green);
      Navigator.pushReplacementNamed(context, Routes.mainLayout);
    }catch(e){
      UIUtils.showMsg(AppLocalizations.of(context)!.some_thing_wrong, ColorsManager.red);
      print(e.toString());
    }
  }
}
