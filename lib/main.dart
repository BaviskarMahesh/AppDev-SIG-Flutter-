import 'package:flutter/material.dart';
import 'package:medinfo/core/routes.dart';
import 'package:medinfo/core/themes.dart';

void main(){
  runApp(MediInfo());
}

class MediInfo extends StatelessWidget {
  const MediInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,

    );
  }
}
