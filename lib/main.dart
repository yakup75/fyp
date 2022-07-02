import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Bindings/binding.dart';
import 'package:fyp/Views/MainPage.dart';
import 'package:get/get.dart';

import 'Widgets/Constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp( home:MainPage(),
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    initialBinding: defaultBinding(),
    darkTheme: darkTheme,
    themeMode: ThemeMode.system,
    defaultTransition: Transition.leftToRightWithFade,
  ));
}

