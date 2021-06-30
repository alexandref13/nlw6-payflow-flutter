import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/home/home.page.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => Home()),
    ],
  ));
}
