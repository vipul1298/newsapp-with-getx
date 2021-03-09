import 'package:assign/components/search_page.dart';
import 'package:assign/components/sources.dart';
import 'package:assign/components/top_headlines.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _scrollController = new ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          body: TabBarView(
            controller: _tabController,
            children: [
              TopHeadlines(),
              Sources(),
              SearchPage(),
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: Colors.blueGrey,
                title: Text("NewsApp"),
                bottom: TabBar(
                    indicatorWeight: 3.0,
                    indicatorColor: Colors.black,
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: "Top-Headlines",
                      ),
                      Tab(
                        text: "Sources",
                      ),
                      Tab(
                        text: "Search",
                      )
                    ]),
              )
            ];
          }),
    );
  }
}
