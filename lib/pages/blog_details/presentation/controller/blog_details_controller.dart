import 'package:get/get.dart';
import 'package:first_step/pages/blog_details/data/blog_details_repository.dart';
import 'package:first_step/pages/blog_details/model/model.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';

import '../../../parent/blog_parent/models/blogs_model.dart';

class BlogDetailsController extends SuperController<bool> {
  BlogDetailsController({required this.blogDetailsRepository});

  final IBlogDetailsRepository blogDetailsRepository;

  Blogs? blog;
  List<Blogs>? blogs;

  @override
  void onInit() {
    var args = Get.arguments;
    blog = args["blog"];
    blogs = args["blogs"];
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
