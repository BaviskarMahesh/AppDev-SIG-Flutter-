import 'package:flutter/material.dart';
import 'package:medinfo/core/routes.dart';
class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final formkey=GlobalKey<FormState>();


  bool isBorderEnabled=true;
  bool isPasswordObscured=true;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

  }

  Future<void> loginUser() async{
    if(formkey.currentState!.validate()){
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }
  @override
  Widget build(BuildContext context) {
     final height=MediaQuery.of(context).size.height;
     final width=MediaQuery.of(context).size.width;
    return  Scaffold(
      
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:   EdgeInsets.all( width*0.04),
          child: Form(key: formkey,
              child: Column(
            children: [
              Text("Sign In",
              style: TextStyle(
                color: Colors.black,
                fontSize:height*0.03,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: height*0.03),

              //email
              Container(
                height: height*0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height*0.03),
                  border: Border.all(
                    color: isBorderEnabled ? Colors.greenAccent : Colors.grey,
                    width: 1,
                  )
                ),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your email",
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please Enter an Email";
                    }

                    if(!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                    ).hasMatch(value)){
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),

              ),
              SizedBox(height: height*0.025,),

              //password
              Container(
                height: height*0.065,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height*0.03),
                  border: Border.all(
                    color: isBorderEnabled ? Colors.greenAccent:Colors.grey,
                    width: 1
                  ),
                ),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: isPasswordObscured  ,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter a password",
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(onPressed:  (){
                      setState(() {
                        isPasswordObscured=! isPasswordObscured;
                      });
                    }, icon: Icon(isPasswordObscured ? Icons.visibility_off : Icons.visibility))
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please Enter a password";
                    }
                    if(value.length<8){
                      return "Password must be atleast 8 digit";
                    }
                    return null;

                  },
                ),

              ),
              SizedBox(height: height*0.04,),

              //button
              SizedBox(
                height: height*0.055,
                width: width*0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                    onPressed: loginUser, child: Text("Sign in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: height*0.02,
                ),)),
              )

            ],

          )),
        ),
      ),

    );
  }
}
