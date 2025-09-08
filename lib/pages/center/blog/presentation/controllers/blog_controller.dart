import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../parent/blog_parent/models/blogs_model.dart';
import '../../data/blog_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';


class BlogScreenController extends SuperController<dynamic> {
  BlogScreenController({required this.blogRepository});

  final IBlogRepository blogRepository;

  BlogsParentResponseModel? blogsParentResponseModel;
  RxList<Blogs> filteredBlogs = <Blogs>[].obs;
  TextEditingController search = TextEditingController();

  Future<void> onRefresh()async{
    await getBlogs();
  }
  RxBool isBlogsLoading = false.obs;
  getBlogs() async {
    // change(false, status: RxStatus.loading());
    isBlogsLoading.value = true;
    blogRepository.getBlogs().then(
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
    //       Get.offNamed(Routes.Blog);
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
