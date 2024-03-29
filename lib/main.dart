// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/sharedPreference.dart';
import 'package:flutter_application_1/view/splash.view.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  final token = await AuthTokenSave.getAuthenticationToken();
 
  runApp( App(token: token,));
}

class App extends StatelessWidget {
  final String? token;
  const App({this.token});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: true,
      home: SplashView(),
      theme: (AuthTokenSave.getThemeStat()!="true")?ThemeData.light(): ThemeData.dark(),
      
    );
  }
}
