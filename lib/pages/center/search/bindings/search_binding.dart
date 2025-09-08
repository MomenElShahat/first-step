import 'package:get/get.dart';

import '../data/search_api_provider.dart';
import '../data/search_repository.dart';
import '../presentation/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ISearchProvider>(SearchProvider());
    Get.put<ISearchRepository>(SearchRepository(provider: Get.find()));
    Get.put(SearchScreenController(searchRepository: Get.find()));


  }
}
