import 'package:assign/constants/category.dart';
import 'package:assign/controllers/news_controller.dart';
import 'package:assign/widgets/article_card.dart';
import 'package:assign/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:get/get.dart';

class TopHeadlines extends StatefulWidget {
  @override
  _TopHeadlinesState createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  final NewsController _newsController = Get.find();

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
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: Category.categorylist.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _newsController.category.value =
                          Category.categorylist[index]["name"];
                      _newsController
                          .fetchTopHeadlines(_newsController.category);
                    });
                  },
                  child: CategoryTile(
                      image: Category.categorylist[index]["image"],
                      categoryName: Category.categorylist[index]["name"]),
                );
              }),
        ),
        Expanded(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: Obx(() {
              if (_newsController.isLoading.value)
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              else
                return ListView.builder(
                    itemCount: _newsController.newsList.length,
                    itemBuilder: (ctx, index) {
                      var articles = _newsController.newsList;
                      return InkWell(
                        onTap: () => _launchURL(context, articles[index].url),
                        child: ArticleCard(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            source: articles[index].source.name,
                            publishedAt: articles[index].publishedAt),
                      );
                    });
            }),
          )),
        ),
      ],
    );
  }
}
