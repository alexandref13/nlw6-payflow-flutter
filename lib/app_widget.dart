import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/login/login_binding.dart';
import 'modules/home/home_page.dart';
import 'modules/login/login_page.dart';
import 'modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage()),
        GetPage(
            name: '/login', page: () => LoginPage(), binding: LoginBinding()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}
