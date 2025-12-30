import 'package:flutter/material.dart';
import 'package:medinfo/screens/HomePage.dart';
import 'package:medinfo/screens/LoginScreen.dart';
import 'package:medinfo/screens/SignUpPage.dart';

class AppRoutes{
  static const login='/login';
  static const signup='/signup';
  static const home='/home';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case login:
        return MaterialPageRoute(builder: (_)=> const Loginscreen());

      case signup:
        return MaterialPageRoute(builder: (_)=> const Signuppage());

      case home:
        return MaterialPageRoute(builder: (_)=> const Homepage());

      default :
        return MaterialPageRoute(builder: (_)=> const Loginscreen());
    }
  }
}