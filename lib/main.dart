import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => SplashPage()),
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/home', page: () => HomePage()),
    ],
  ));
}
