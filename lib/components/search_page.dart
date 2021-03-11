import 'package:assign/controllers/news_controller.dart';
import 'package:assign/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final NewsController _newsController = Get.find();

  final TextEditingController _filter = new TextEditingController();

  String searchText = "";

  @override
  void initState() {
    _filter.addListener(() {
      _filter.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _filter.dispose();

    super.dispose();
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1, spreadRadius: 2, color: Colors.grey[300])
              ]),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      onChanged: (value) {
                        searchText = value;
                      },
                      controller: _filter,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search"),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _newsController.query.value = searchText;
                        _newsController
                            .fetchResultsforQuery(_newsController.query);
                      });
                    },
                    icon: Icon(Icons.search))
              ],
            ),
          ),
        ),
        Obx(() {
          if (_newsController.isResultsForQueryLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_newsController.query.value == "") {
            return Center(
              child: Text("Nothing to show"),
            );
          } else
            return Expanded(
              child: ListView.builder(
                  itemCount: _newsController.articleListForQuery.length,
                  itemBuilder: (ctx, index) {
                    var articles = _newsController.articleListForQuery;
                    return InkWell(
                      onTap: () => _launchURL(context, articles[index].url),
                      child: ArticleCard(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          source: articles[index].source.name,
                          publishedAt: articles[index].publishedAt),
                    );
                  }),
            );
        })
      ],
    ));
  }
}
