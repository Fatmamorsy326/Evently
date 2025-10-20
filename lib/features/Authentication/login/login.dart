import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/core/widgets/custom_text_button.dart';
import 'package:evently/features/Authentication/validation.dart';
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
                validator: Validation.emailValidation,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "E-mail",
                ),
              ),
              SizedBox(height: 16.h,),
              TextFormField(
                controller: passwordController,
                validator: Validation.passwordValidation,
                obscureText: isSecurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  suffixIcon: IconButton(icon: isSecurePassword?Icon(Icons.visibility_off):Icon(Icons.visibility), onPressed: () {
                    togglePasswordVisibility();
                  },),
                ),
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(text: "Forget Password?", onTap: (){}),
                ],
              ),
              SizedBox(height: 16.h,),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    login();
                  }, child: Text("Login"))),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t Have Account ?",style: Theme.of(context).textTheme.bodySmall,),
                  CustomTextButton(text:"Create Account" ,onTap:(){
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
                  Text("Or",style: Theme.of(context).textTheme.headlineSmall,),
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
              OutlinedButton(onPressed: (){}, child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImagesManager.google),
                  Text(" Login With Google",style: Theme.of(context).textTheme.headlineSmall,)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if(loginFormKey.currentState?.validate()==false)return;
  }
}
