import 'package:assign/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/news_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomePage());
  }
}
