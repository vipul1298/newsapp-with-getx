import 'package:assign/components/detail_screen.dart';
import 'package:assign/components/news_list.dart';

import 'package:flutter/material.dart';

class DesktopHomePage extends StatefulWidget {
  @override
  _DesktopHomePageState createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: NewsList(),
            flex: 2,
          ),
          Expanded(child: DetailScreen(), flex: 3)
        ],
      ),
    );
  }
}
