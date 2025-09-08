import 'package:first_step/pages/parent/home_parent/models/centers_model.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../center/control_panel/models/branch_team_model.dart';
import '../../../../center/control_panel/models/portfolio_prices_model.dart';
import '../../data/center_details_parent_repository.dart';
import '../../models/center_portfolio_model.dart';

class CenterDetailsParentController extends SuperController<dynamic> {
  CenterDetailsParentController({required this.centerDetailsParentRepository});

  final ICenterDetailsParentRepository centerDetailsParentRepository;

  Branches? selectedBranch;
  RxBool isBranchError = false.obs;
  RxBool isAgeError = false.obs;
  RxBool isTypeError = false.obs;

  int? selectedAge;

  String? selectedType;

  final List<Map<String, String>> programTypes = [
    {"value": "day", "label": AppStrings.daily},
    {"value": "week", "label": AppStrings.weekly},
    {"value": "month", "label": AppStrings.monthly},
    {"value": "hour", "label": AppStrings.flexibleHourly},
    {"value": "year", "label": AppStrings.yearly},
  ];

  double? percentage;
  CenterPortfolioModel? centerPortfolioModel;

  getCenterPortfolio(String centerId) async {
    change(false, status: RxStatus.loading());
    centerDetailsParentRepository.getCenterPortfolio(centerId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          centerPortfolioModel = null;
          centerPortfolioModel = value.body;
          await showPortfolioPrices(selectedBranch?.id.toString() ?? "");
          update();
        }
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      // customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
    });
  }

  double calculatePortfolioProgress(
      CenterPortfolioModel model, List<PortfolioPrice> portfolioPricesModel) {
    if (model.data == null) return 0.0;
    final data = model.data!;

    // Sections to check
    int totalSections = 2; // total sections you listed
    int filledSections = 0;

    // 1. HeroSection
    if (data.heroSection != null &&
        (data.heroSection!.titleOfHero?.isNotEmpty == true ||
            data.heroSection!.subtitleOfHero?.isNotEmpty == true ||
            data.heroSection!.description?.isNotEmpty == true ||
            data.heroSection!.backgroundImage?.isNotEmpty == true)) {
      filledSections++;
    }

    // 2. Branches
    // if (data.branches != null && data.branches!.isNotEmpty) {
    //   filledSections++;
    // }
    //
    // // 3. PhilosophyMethodologyGoal
    // if (data.philosophyMethodologyGoal != null) {
    //   final pmg = data.philosophyMethodologyGoal!;
    //   if ((pmg.philosophy?.title?.isNotEmpty == true ||
    //           pmg.philosophy?.content?.isNotEmpty == true) ||
    //       (pmg.methodology?.title?.isNotEmpty == true ||
    //           pmg.methodology?.content?.isNotEmpty == true) ||
    //       (pmg.goals?.title?.isNotEmpty == true ||
    //           pmg.goals?.content?.isNotEmpty == true)) {
    //     filledSections++;
    //   }
    // }

    // // 4. Services
    // if (data.services != null && data.services!.isNotEmpty) {
    //   filledSections++;
    // }

    // 5. NurseryState
    // if (data.nurseryState != null &&
    //     (data.nurseryState!.area?.isNotEmpty == true ||
    //         data.nurseryState!.classRooms?.isNotEmpty == true ||
    //         data.nurseryState!.teamMembers?.isNotEmpty == true)) {
    //   filledSections++;
    // }
    //
    // // 6. ImagesActivities
    // if (data.imagesActivities != null && data.imagesActivities!.isNotEmpty) {
    //   filledSections++;
    // }
    //
    // // 7. AdsImages
    // if (data.adsImages != null && data.adsImages!.isNotEmpty) {
    //   filledSections++;
    // }
    //
    // // 8. Teams
    // if (data.teams != null && data.teams!.isNotEmpty) {
    //   filledSections++;
    // }

    // // 9. ContactInfo
    // if (data.contactInfo != null &&
    //     (data.contactInfo!.address?.isNotEmpty == true ||
    //         data.contactInfo!.workingHours?.isNotEmpty == true ||
    //         data.contactInfo!.phoneNumber?.isNotEmpty == true ||
    //         data.contactInfo!.emailAddress?.isNotEmpty == true ||
    //         data.contactInfo!.facebook?.isNotEmpty == true ||
    //         data.contactInfo!.instagram?.isNotEmpty == true ||
    //         data.contactInfo!.whatsapp?.isNotEmpty == true)) {
    //   filledSections++;
    // }

    // 10. Pricing
    if (portfolioPricesModel.isNotEmpty) {
      filledSections++;
    }

    // Percentage
    return (filledSections / totalSections) * 100;
  }

  List<PortfolioPrice>? portfolioPricesModel;
  List<PortfolioPrice> filteredPortfolioPrices = [];
  RxBool isGettingPrices = false.obs;

  showPortfolioPrices(String branchId) async {
    // change(false, status: RxStatus.loading());
    isGettingPrices.value = true;
    centerDetailsParentRepository.showPortfolioPrices(branchId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          portfolioPricesModel = null;
          portfolioPricesModel = value.body;
          filteredPortfolioPrices = portfolioPricesModel ?? [];
          percentage = calculatePortfolioProgress(
              centerPortfolioModel ?? CenterPortfolioModel(),
              portfolioPricesModel ?? []);
          update();
        }
        // change(true, status: RxStatus.success());
        isGettingPrices.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isGettingPrices.value = false;
    });
  }

  final List<Color> colors = [
    ColorCode.secondaryBurgundy600,
    ColorCode.success600,
    ColorCode.info600,
    ColorCode.secondaryOrange600,
    ColorCode.warning600,
  ];

  void applyFilter() {
    if (portfolioPricesModel == null) return;

    filteredPortfolioPrices = portfolioPricesModel!.where((price) {
      final ageMatch = selectedAge == null ||
          ((price.startAge ?? 0) <= selectedAge! &&
              (price.endAge ?? 999) >= selectedAge!);

      final typeMatch = selectedType == null ||
          price.enrollmentType == selectedType;

      return ageMatch && typeMatch;
    }).toList();

    update();
  }


  NurseryModel? center;

  List<int> getAges() {
    final Set<int> startAges = {};

    if (center!.branches != null) {
      for (var branch in center!.branches!) {
        if (branch.pricing != null) {
          for (var price in branch.pricing!) {
            if (price.startAge != null) {
              startAges.add(price.startAge!);
            }
          }
        }
      }
    }

    return startAges.toList()..sort(); // optional: keep ages sorted
  }


  // List<Map<String, String>> getTypes() {
  //   final List<Map<String, String>> startAges = <Map<String, String>>[];
  //
  //   if (center!.branches != null) {
  //     for (var branch in center!.branches!) {
  //       if (branch.pricing != null) {
  //         for (var price in branch.pricing!) {
  //           if (price.enrollmentType != null) {
  //             startAges.add({
  //               "value": price.enrollmentType!,
  //               "text": price.enrollmentType == "day"
  //                   ? AppStrings.daily
  //                   : price.enrollmentType == "hour"
  //                       ? AppStrings.flexibleHourly
  //                       : price.enrollmentType == "week"
  //                           ? AppStrings.weekly
  //                           : price.enrollmentType == "month"
  //                               ? AppStrings.monthly
  //                               : price.enrollmentType == "year"
  //                                   ? AppStrings.yearly
  //                                   : "",
  //             });
  //           }
  //         }
  //       }
  //     }
  //   }
  //
  //   return startAges;
  // }

  @override
  void onInit() async {
    var args = Get.arguments;
    center = args["center"];
    selectedBranch = center?.branches?.first;
    await getCenterPortfolio(center?.id.toString() ?? "");
    // await getBranchTeam(center?.id);
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
    //       Get.offNamed(Routes.CenterDetailsParent);
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
