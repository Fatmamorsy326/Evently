import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/routes_manager/routes.dart';
import 'package:evently/core/routes_manager/routes_manager.dart';
import 'package:evently/features/Authentication/register/custom_text_button.dart';
import 'package:evently/features/Authentication/validation.dart';
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
      appBar: AppBar(
        title: Text("Register",style: Theme.of(context).textTheme.titleLarge,),
        centerTitle: true,
      ),
       resizeToAvoidBottomInset: false,
       body: SingleChildScrollView(
         padding:REdgeInsets.only(left: 16,right: 16, bottom: MediaQuery.of(context).viewInsets.bottom) ,
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
                 validator: Validation.nameValidation,
                 keyboardType: TextInputType.name,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.person),
                   labelText: "Name",
                 ),
               ),
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
               TextFormField(
                 validator: (value) {
                   return Validation.rePasswordValidation(rePasswordController.text, passwordController.text);
                 },
                 controller: rePasswordController,
                 keyboardType: TextInputType.visiblePassword,
                 obscureText: isSecureRePassword,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.lock),
                   labelText: "Re-password",
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
                   }, child: Text("Create Account"))),
               SizedBox(height: 16.h,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Already Have Account ?",style: Theme.of(context).textTheme.bodySmall,),
                   CustomTextButton(text:"Login" ,onTap:(){
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

  void createAccount() {
    if(regFormKey.currentState?.validate()==false){
      return;
    }
  }
}
