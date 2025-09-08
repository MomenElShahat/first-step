import 'package:first_step/pages/parent/blog_parent/models/blogs_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/blog_parent_repository.dart';

class BlogParentScreenController extends SuperController<dynamic> {
  BlogParentScreenController({required this.blogParentRepository});

  final IBlogParentRepository blogParentRepository;

  BlogsParentResponseModel? blogsParentResponseModel;
  RxList<Blogs> filteredBlogs = <Blogs>[].obs;
  TextEditingController search = TextEditingController();

  RxBool isBlogsLoading = false.obs;
  getBlogs() async {
    // change(false, status: RxStatus.loading());
    isBlogsLoading.value = true;
    blogParentRepository.getBlogs().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          blogsParentResponseModel = value.body;
          filteredBlogs.clear();
          filteredBlogs.addAll(blogsParentResponseModel?.data ?? []);
          update();
        }
        // change(true, status: RxStatus.success());
        isBlogsLoading.value =false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isBlogsLoading.value =false;
    });
  }
  Future<void> onRefresh()async {
    await getBlogs();
  }
  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    await getBlogs();
    super.onInit();
    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   final isLoggedIn = AuthService.to.isLoggedIn.value;
    //   final isSelectedLanguage = AuthService.to.isSelectedLanguage.value;
    //   AuthService.to.selectLanguage(AuthService.to.language ?? 'en');
    //
    //   if (AuthService.to.isFirstTime) {
    //     Get.offNamed(Routes.BOARD);
    //   } else {
    //     if (isLoggedIn) {
    //       Get.offNamed(Routes.BlogParent);
    //     } else {
    //       Get.offNamed(Routes.LOGIN);
    //     }
    //   }
    // });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
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

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
