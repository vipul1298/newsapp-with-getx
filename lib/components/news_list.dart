import 'package:assign/controllers/news_controller.dart';

import 'package:assign/widgets/article_card_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final NewsController _newsController = Get.find();
  final listOfCategories = [
    "general",
    "entertainment",
    "sports",
    "health",
    "technology",
    "business",
    "science"
  ];
  String _selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: DropdownButton(
            items: listOfCategories.map((val) {
              return DropdownMenuItem(
                child: Text(val),
                value: val,
              );
            }).toList(),
            hint: _selectedCategory == ""
                ? Text("Please select a category")
                : Text(_selectedCategory),
            onChanged: (newVal) {
              setState(() {
                _selectedCategory = newVal;
                _newsController.category.value = _selectedCategory;
                _newsController.pos.value = 0;
                _newsController.fetchTopHeadlines(_newsController.category);
              });
            },
          ),
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Obx(() {
                if (_newsController.isLoading.value)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return ListView.builder(
                    itemCount: _newsController.newsList.length,
                    itemBuilder: (ctx, index) {
                      var articles = _newsController.newsList;

                      return InkWell(
                        onTap: () {
                          _newsController.pos.value = index;
                        },
                        child: ArticleCardDesktop(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            source: articles[index].source.name,
                            publishedAt: articles[index].publishedAt),
                      );
                    });
              })),
        ),
      ],
    );
  }
}
