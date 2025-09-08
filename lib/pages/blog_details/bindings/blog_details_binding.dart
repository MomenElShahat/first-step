import 'package:get/get.dart';
import 'package:first_step/pages/blog_details/data/blog_details_api_provider.dart';
import 'package:first_step/pages/blog_details/data/blog_details_repository.dart';
import 'package:first_step/pages/blog_details/presentation/controller/blog_details_controller.dart';

class BlogDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBlogDetailsProvider>(BlogDetailsProvider());
    Get.put<IBlogDetailsRepository>(BlogDetailsRepository(provider: Get.find()));
    Get.put(BlogDetailsController(blogDetailsRepository: Get.find()));
  }
}
