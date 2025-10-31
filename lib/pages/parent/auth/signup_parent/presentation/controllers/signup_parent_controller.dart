import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../services/auth_service.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../auth/login/models/login_request.dart';
import '../../../../../center/control_panel/models/child_model.dart' as child;
import '../../../../home_parent/models/centers_model.dart';
import '../../../add_child/model/existing_enrollment_request_model.dart';
import '../../../add_child/model/existing_enrollment_response_model.dart';
import '../../data/signup_parent_repository.dart';
import '../../models/signup_parent_request_model.dart';
import '../widgets/sub_card.dart';
import '../widgets/sub_dialog.dart';

class SignupParentController extends SuperController<dynamic> {
  SignupParentController({required this.signupParentRepository});

  final ISignupParentRepository signupParentRepository;

  TextEditingController name = TextEditingController();
  TextEditingController kinship = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController nationalId = TextEditingController();
  RxString phone = "".obs;
  RxBool isHidden = true.obs;
  RxBool isHiddenConfirm = true.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxBool isLoadingChild = false.obs;

  CentersModel? centersModel;

  List<NurseryModel> centers = [];

  RxBool isCentersLoading = false.obs;
  RxBool isSharing = false.obs;

  Future<void> getCentersWithFilter({required String filter}) async {
    // change(false, status: RxStatus.loading());
    isCentersLoading.value = true;
    signupParentRepository
        .getCentersWithFilter(filter: filter, selectedCityIds: []).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          centersModel = null;
          centersModel = value.body;
          if (filter == AppStrings.all) {
            centers.clear();
            centers.addAll(centersModel?.data ?? []);
            filteredNurseries.addAll(centersModel?.data ?? []);
          }
          update();
        }
        // change(true, status: RxStatus.success());
        isCentersLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isCentersLoading.value = false;
    });
  }

  List<child.ChildModel>? children;

  List<int> selectedChildIds = [];

  void toggleChildFilter(int childId) {
    if (selectedChildIds.contains(childId)) {
      selectedChildIds.remove(childId);
    } else {
      selectedChildIds.add(childId);
    }
    update();
  }

  bool isChildSelected(int childId) => selectedChildIds.contains(childId);

  RxBool isChildrenLoading = false.obs;

  Future<void> getChildren() async {
    isChildrenLoading.value = true;
    // change(false, status: RxStatus.loading());
    signupParentRepository.getChildren().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          children = null;
          children = value.body;
          update();
        }
        isChildrenLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isChildrenLoading.value = false;
    });
  }

  TextEditingController search = TextEditingController();

  RxList<NurseryModel> filteredNurseries = <NurseryModel>[].obs;

  NurseryModel? selectedCenter;

  void filterNurseries() {
    final query = search.text.toLowerCase();

    filteredNurseries.value = centers.where((nursery) {
      final matchesName =
          (nursery.nurseryName ?? '').toLowerCase().contains(query);
      return matchesName;
    }).toList();
    update();
  }

  RxBool isSubed = false.obs;

  RxBool isCenterSelected = false.obs;

  Future<void> onRegisterParentClicked(
      BuildContext context, String page) async {
    // change(false, status: RxStatus.loading());
    if (page == Routes.ADD_CHILD) {
      isLoadingChild.value = true;
    } else {
      isLoading.value = true;
    }
    SignupParentRequestModel signupParentRequestModel =
        SignupParentRequestModel(
      name: name.text ?? "",
      email: email.text ?? "",
      password: password.text ?? "",
      nationalNumber: nationalId.text ?? "",
      phone: "966${mobileNumber.text ?? ""}",
    );
    signupParentRepository.signup(signupParentRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(value.body?.message ?? "", ColorCode.success600);
          if (page == Routes.ADD_CHILD) {
            await onLoginClicked().then(
              (value) {
                Get.offNamed(page);
              },
            );
          } else {
            await onLoginClicked().then(
                  (value) {
                    Get.dialog(
                      barrierDismissible: false,
                      SubDialog(),
                    );
              },
            );
          }
        } else {
          customSnackBar(value.body?.message ?? "", ColorCode.danger600);
        }
        // change(true, status: RxStatus.success());
        if (page == Routes.ADD_CHILD) {
          isLoadingChild.value = false;
        } else {
          isLoading.value = false;
        }
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      if (page == Routes.ADD_CHILD) {
        isLoadingChild.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  Future<void> onLoginClicked() async {
    // change(false, status: RxStatus.loading());
    signupParentRepository
        .login(LoginRequest(
      email: email.text,
      password: password.text,
    ))
        .then((value) async {
      if (value.body?.user != null && value.statusCode == 200) {
        AuthService.to.isGuest = false;
        // AuthService.to.savePassword(password.text);
        // AuthService.to.isParent = value.body?.user?.role == "parent" ? true : false;
        update();
      } else {
        customSnackBar(value.body?.message ?? "", ColorCode.danger600);
      }
      // change(true, status: RxStatus.success());
    }, onError: (error) {
      customSnackBar(error.toString() ?? "", ColorCode.danger600);
      // change(false, status: RxStatus.success());
    });
  }

  Branches? selectedBranch;

  RxBool isBranchError = false.obs;

  Pricing? selectedBranchPricing;

  RxBool isSending = false.obs;

  ExistingEnrollmentResponseModel? existingEnrollmentResponseModel;

  Future<void> sendRequest() async {
    ExistingEnrollmentRequestModel existingEnrollmentRequestModel =
        ExistingEnrollmentRequestModel(
      branchPriceId: selectedBranchPricing?.id ?? 0,
      centerBranchId: selectedCenter?.id ?? 0,
      children: selectedChildIds,
      parentPhone: AuthService.to.userInfo?.user?.phone ?? "",
      startingDate: "",
      dayString: "",
      startingTime: "",
    );
    isSending.value = true;
    // change(false, status: RxStatus.loading());
    signupParentRepository.sendRequest(existingEnrollmentRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          existingEnrollmentResponseModel = null;
          existingEnrollmentResponseModel = value.body;
          update();
        }
        isSending.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isSending.value = false;
    });
  }

  @override
  void onInit() async {
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
    //       Get.offNamed(Routes.HOME);
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
