import 'package:get/get.dart';

import '../data/blog_api_provider.dart';
import '../data/blog_repository.dart';
import '../presentation/controllers/blog_controller.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBlogProvider>(BlogProvider());
    Get.put<IBlogRepository>(BlogRepository(provider: Get.find()));
    Get.put(BlogScreenController(blogRepository: Get.find()));


  }
}
