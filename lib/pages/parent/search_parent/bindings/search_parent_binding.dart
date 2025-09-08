import 'package:get/get.dart';

import '../data/search_parent_api_provider.dart';
import '../data/search_parent_repository.dart';
import '../presentation/controllers/search_parent_controller.dart';

class SearchParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ISearchParentProvider>(SearchParentProvider());
    Get.put<ISearchParentRepository>(SearchParentRepository(provider: Get.find()));
    Get.put(SearchParentScreenController(searchParentRepository: Get.find()));


  }
}
