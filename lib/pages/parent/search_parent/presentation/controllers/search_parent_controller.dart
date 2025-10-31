import 'package:first_step/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../resources/strings_generated.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../center/auth/signup/models/cities_model.dart';
import '../../../../center/auth/signup/models/cities_model.dart' as city;
import '../../../home_parent/models/centers_model.dart';
import '../../../home_parent/presentation/widgets/cities_dialog.dart';
import '../../data/search_parent_repository.dart';

class SearchParentScreenController extends SuperController<dynamic> {
  SearchParentScreenController({required this.searchParentRepository});

  final ISearchParentRepository searchParentRepository;

  RxList<NurseryModel> filteredNurseries = <NurseryModel>[].obs;
  TextEditingController search = TextEditingController();
  List<RxBool> isFav = [
    false.obs,
    false.obs,
    false.obs,
  ];

  NurseryModel? nurseryModel;
  RxBool isSearching = false.obs;
  RxBool isSearchClicked = false.obs;

  searchCenters({required String keyword}) async {
    isSearchClicked.value = true;
    searchParentRepository.search(keyword: keyword).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          nurseryModel = null;
          nurseryModel = value.body;
          Get.toNamed(Routes.CENTER_DETAILS_PARENT,
              arguments: {"center": nurseryModel});
          update();
          isSearchClicked.value = false;
        }
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isSearchClicked.value = false;
    });
  }

  List<NurseryModel> nurseries = [];
  bool isLoading = true;

  getLatestCentersResearches() async {
    isLoading = true;
    update();
    change(false, status: RxStatus.loading());
    searchParentRepository.getLatestCentersResearches().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          nurseries.clear();
          nurseries.addAll(value.body ?? []);
          update();
        }
        isLoading = false;
        update();
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isLoading = false;
      update();
      change(true, status: RxStatus.success());
    });
  }

  CentersModel? centersModel;
  List<NurseryModel> allNurseries = [];
  RxBool isCentersLoading = false.obs;

  getCentersWithFilter() async {
    change(false, status: RxStatus.loading());
    isCentersLoading.value = true;
    searchParentRepository
        .getCentersWithFilter(
            filter: AppStrings.all, selectedCityIds: selectedCityIds)
        .then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          centersModel = null;
          centersModel = value.body;
          allNurseries.clear();
          allNurseries.addAll(centersModel?.data ?? []);
          filteredNurseries.addAll(allNurseries);
          update();
        }
        change(true, status: RxStatus.success());
        isCentersLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
      isCentersLoading.value = false;
    });
  }

  void openCitiesDialog(BuildContext context) async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) => CitiesDialog(cities: cities),
    );

    if (result != null) {
      selectedCityIds = result;
      filterNurseries();
    }
  }

  void filterNurseries() {
    final query = search.text.toLowerCase();

    filteredNurseries.value = allNurseries.where((nursery) {
      final matchesName = (nursery.nurseryName ?? '').toLowerCase().contains(query);
      final matchesCity = selectedCityIds.isEmpty ||
          selectedCityIds.contains(nursery.cityId.toString());

      return matchesName && matchesCity;
    }).toList();

    isSearching.value = search.text.isNotEmpty;
    update();
  }

  Future<void> onRefresh() async {
    nurseries.clear();
    await getLatestCentersResearches();
  }

  List<city.City> cities = [];

  getCities() async {
    change(false, status: RxStatus.loading());
    searchParentRepository.getCities().then(
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

  @override
  void onInit() async {
    change(true, status: RxStatus.loading());
    isSearching.value = false;
    await getCentersWithFilter();
    await getCities();
    getLatestCentersResearches();
    super.onInit();
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
