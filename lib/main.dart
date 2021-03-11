import 'package:assign/screens/desktop_home_page.dart';
import 'package:assign/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

import 'controllers/news_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NewsController _newsController = Get.put(NewsController());

  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Platform.isLinux ? DesktopHomePage() : HomePage());
  }
}
