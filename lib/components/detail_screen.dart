import 'package:assign/constants/data.dart';
import 'package:assign/controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  final NewsController _newsController = Get.find();
  @override
  Widget build(BuildContext context) {
    var articles = _newsController.newsList;
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Obx(() {
          if (articles == null)
            return Center(
              child: Text("Loading..."),
            );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 360,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: articles[_newsController.pos.value].urlToImage ==
                                null
                            ? AssetImage(Data.PLACEHOLDER_IMAGE)
                            : NetworkImage(articles[_newsController.pos.value]
                                .urlToImage))),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text(
                    articles[_newsController.pos.value].source.name ??
                        "Not available now",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  articles[_newsController.pos.value].title ??
                      "Not available now",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  articles[_newsController.pos.value].description ??
                      "Not available now",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  articles[_newsController.pos.value].content ??
                      "Not available now",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  articles[_newsController.pos.value].publishedAt ??
                      "Not available now",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          );
        }));
  }
}
