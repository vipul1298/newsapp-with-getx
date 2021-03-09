import 'package:assign/services/remote_services.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var newsList = [].obs;
  var sourceList = [].obs;
  var isLoading = true.obs;
  var isSourcesLoading = true.obs;
  var category = "general".obs;
  var pos = 0.obs;

  @override
  void onInit() {
    fetchTopHeadlines(category);
    fetchSources();

    super.onInit();
  }

  void fetchTopHeadlines(RxString category) async {
    try {
      isLoading(true);
      var articles = await RemoteServices.fetchTopHeadlines(category.string);

      if (articles != null) {
        newsList.assignAll(articles);
      }
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  void fetchSources() async {
    try {
      isSourcesLoading(true);
      var sources = await RemoteServices.fetchSources();
      if (sources != null) {
        sourceList.assignAll(sources);
      }
    } catch (e) {} finally {
      isSourcesLoading(false);
    }
  }
}
