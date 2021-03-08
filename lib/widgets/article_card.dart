import 'package:assign/constants/data.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String publishedAt;

  ArticleCard(
      {@required this.imageUrl,
      @required this.title,
      @required this.source,
      @required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height * 0.32,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageUrl == null
                          ? AssetImage(Data.PLACEHOLDER_IMAGE)
                          : NetworkImage(imageUrl),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  source,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                publishedAt,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
