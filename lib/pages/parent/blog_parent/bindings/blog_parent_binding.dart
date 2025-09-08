import 'package:get/get.dart';

import '../data/blog_parent_api_provider.dart';
import '../data/blog_parent_repository.dart';
import '../presentation/controllers/blog_parent_controller.dart';

class BlogParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBlogParentProvider>(BlogParentProvider());
    Get.put<IBlogParentRepository>(BlogParentRepository(provider: Get.find()));
    Get.put(BlogParentScreenController(blogParentRepository: Get.find()));


  }
}
