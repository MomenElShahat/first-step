import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../center/auth/signup/models/cities_model.dart';
import '../../data/home_parent_repository.dart';
import '../../models/centers_model.dart';
import '../../models/services_model.dart';
import '../widgets/cities_dialog.dart';

class HomeParentController extends SuperController<dynamic> {
  HomeParentController({required this.homeParentRepository});

  final IHomeParentRepository homeParentRepository;

  List<RxBool> isFav = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];

  List<String> filters = [
    AppStrings.all,
    AppStrings.nurseriesFrom0To3Years,
    AppStrings.nurseriesFrom3To6Years,
    AppStrings.childrenWithSpecialNeeds,
  ];
  RxString selectedFilter = AppStrings.all.obs;

  ServicesParentResponseModel? servicesParentResponseModel;

  RxBool isServicesLoading = false.obs;

  getServices() async {
    // change(false, status: RxStatus.loading());
    isServicesLoading.value = true;
    homeParentRepository.getServices().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          servicesParentResponseModel = value.body;
          update();
        }
        // change(true, status: RxStatus.success());
        isServicesLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isServicesLoading.value = false;
    });
  }

  CentersModel? centersModel;
  List<NurseryModel> centers = [];
  RxBool isCentersLoading = false.obs;

  getCentersWithFilter({required String filter}) async {
    // change(false, status: RxStatus.loading());
    isCentersLoading.value = true;
    homeParentRepository
        .getCentersWithFilter(filter: filter, selectedCityIds: selectedCityIds)
        .then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          centersModel = null;
          centersModel = value.body;
          if (filter == AppStrings.all) {
            centers.clear();
            centers.addAll(centersModel?.data ?? []);
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

  String getAllCities(NurseryModel center) {
    // Get list of cities, ignoring null or empty values
    List<String> cities = center.branches
            ?.map((branch) => AuthService.to.language == "ar"
                ? branch.city?.name?.ar ?? ""
                : branch.city?.name?.en ?? "")
            .where((city) => city.isNotEmpty && city != "undefined")
            .toList() ??
        [];

    // Combine with " - " separator
    return cities.join(" - ");
  }

  List<City> cities = [];

  getCities() async {
    change(false, status: RxStatus.loading());
    homeParentRepository.getCities().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          cities = value.body?.data ?? [];
          update();
        }
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
    });
  }

  List<String> selectedCityIds = [];

  Future<void> onRefresh() async {
    await getServices();
    await getCentersWithFilter(filter: AppStrings.all);
  }

  void openCitiesDialog(BuildContext context) async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) => CitiesDialog(cities: cities),
    );

    if (result != null) {
      selectedCityIds = result;
      update();
      print("Selected city IDs: $selectedCityIds");
    }
  }

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    await getServices();
    await getCentersWithFilter(filter: AppStrings.all);
    await getCities();
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
    //       Get.offNamed(Routes.HomeParent);
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
