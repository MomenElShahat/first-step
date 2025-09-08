import 'package:get/get.dart';


import '../../../../consts/colors.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../data/privacy_repository.dart';

class PrivacyController extends SuperController<bool> {
  PrivacyController({required this.privacyRepository});

  final IPrivacyRepository privacyRepository;
  String? privacy;
  RxBool isPrivacyLoading = false.obs;
  getPrivacy() async {
    // change(false, status: RxStatus.loading());
    isPrivacyLoading.value = true;
    privacyRepository.getPrivacy().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          privacy = value.body;
          update();
        }
        // change(true, status: RxStatus.success());
        isPrivacyLoading.value =false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isPrivacyLoading.value =false;
    });
  }

  @override
  void onInit() async{
    await getPrivacy();
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
