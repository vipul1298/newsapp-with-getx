import 'package:assign/controllers/news_controller.dart';
import 'package:assign/widgets/source_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:get/get.dart';

class Sources extends StatelessWidget {
  final NewsController _newsController = Get.find();

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          // or user defined animation.

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
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      child: Obx(() {
        if (_newsController.isSourcesLoading.value)
          return const Center(
            child: const CircularProgressIndicator(),
          );
        return ListView.builder(
            itemCount: _newsController.sourceList.length,
            itemBuilder: (context, index) {
              var sources = _newsController.sourceList;
              return InkWell(
                onTap: () => _launchURL(context, sources[index].url),
                child: SourceCard(
                    sourceName: sources[index].name,
                    country: sources[index].country),
              );
            });
      }),
    ));
  }
}
