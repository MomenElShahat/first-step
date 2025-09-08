import 'package:get/get.dart';
import 'package:first_step/pages/terms/data/terms_repository.dart';


import '../../../../consts/colors.dart';
import '../../../../widgets/custom_snackbar.dart';

class TermsController extends SuperController<bool> {
  TermsController({required this.termsRepository});

  final ITermsRepository termsRepository;
  String? terms;
  RxBool isTermsLoading = false.obs;
  getTerms() async {
    // change(false, status: RxStatus.loading());
    isTermsLoading.value = true;
    termsRepository.getTerms().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          terms = value.body;
          update();
        }
        // change(true, status: RxStatus.success());
        isTermsLoading.value =false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isTermsLoading.value =false;
    });
  }

  @override
  void onInit() async{
    await getTerms();
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
