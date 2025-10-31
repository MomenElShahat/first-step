// ignore: one_member_abstracts
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../auth/signup/models/cities_model.dart';
import '../../auth/signup/models/signup_request_model.dart';
import '../../control_panel/models/branch_model.dart';

abstract class IBranchEditProvider {
  Future<Response<BranchModel>> getBranchDetails(String branchId);
  Future<Response<BranchModel>> editBranch({  required SignupRequestModel branchModel,
    File? licenseFile,
    File? commercialRecordFile,
    File? logo, required String branchId});
  Future<Response<CitiesModel>> getCities();
}

class BranchEditProvider extends BaseAuthProvider implements IBranchEditProvider {
  @override
  Future<Response<BranchModel>> getBranchDetails(String branchId) {
    return get<BranchModel>(
      "${EndPoints.branchesList}/$branchId",
      decoder: BranchModel.fromJson,
    );
  }

  @override
  Future<Response<BranchModel>> editBranch({  required SignupRequestModel branchModel,
    File? licenseFile,
    File? commercialRecordFile,
    File? logo, required String branchId}) {
    final formData = FormData({});

    // Helper function to add non-null fields
    void addField(String key, dynamic value) {
      if (value != null) {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    }

    // Basic fields
    addField('name', branchModel.name);
    addField('email', branchModel.email);
    addField('password', branchModel.password);
    addField('nursery_name', branchModel.nurseryName);
    addField('city_id', branchModel.cityID);
    addField('neighborhood', branchModel.neighborhood);
    addField('phone', branchModel.phone);
    addField('work_days_from', branchModel.workDaysFrom);
    addField('work_days_to', branchModel.workDaysTo);
    addField('work_hours_from', branchModel.workHoursFrom);
    addField('work_hours_to', branchModel.workHoursTo);
    addField('location', branchModel.location);
    addField('additional_service', branchModel.additionalService);
    addField('time_of_first_period', branchModel.timeOfFirstPeriod);
    addField('time_of_second_period', branchModel.timeOfSecondPeriod);

    // Boolean values as real booleans
    addField(
        'emergency_contact', branchModel.emergencyContact == true ? '1' : '0');
    addField('special_needs', branchModel.specialNeeds == true ? '1' : '0');
    addField('provides_food', branchModel.providesFood == true ? '1' : '0');

    for (int i = 0; i < (branchModel.services?.length ?? 0); i++) {
      final service = branchModel.services?[i];
      addField('services[$i]', service);
    }
    for (int i = 0; i < (branchModel.nurseryType?.length ?? 0); i++) {
      final nurseryType = branchModel.nurseryType?[i];
      addField('nursery_type[$i]', nurseryType);
    }
    for (int i = 0; i < (branchModel.acceptedAges?.length ?? 0); i++) {
      final acceptedAges = branchModel.acceptedAges?[i];
      addField('accepted_ages[$i]', acceptedAges);
    }
    for (int i = 0; i < (branchModel.communicationMethods?.length ?? 0); i++) {
      final communicationMethods = branchModel.communicationMethods?[i];
      addField('communication_methods[$i]', communicationMethods);
    }

    // Meals (first_meals)
    if (branchModel.firstMeals != null) {
      for (int i = 0; i < (branchModel.firstMeals?.length ?? 0); i++) {
        final meal = branchModel.firstMeals?[i];
        addField('first_meals[$i][meal_name]', meal?.mealName);
        addField('first_meals[$i][juice]', meal?.juice);
        addField('first_meals[$i][components]', meal?.components);
      }
    }

    // Meals (second_meals)
    if (branchModel.secondMeals != null) {
      for (int i = 0; i < (branchModel.secondMeals?.length ?? 0); i++) {
        final meal = branchModel.secondMeals?[i];
        addField('second_meals[$i][meal_name]', meal?.mealName);
        addField('second_meals[$i][juice]', meal?.juice);
        addField('second_meals[$i][components]', meal?.components);
      }
    }

    // Files
    if (licenseFile != null) {
      formData.files.add(MapEntry(
        'license_path',
        MultipartFile(licenseFile, filename: licenseFile.path.split('/').last),
      ));
    }

    if (commercialRecordFile != null) {
      formData.files.add(MapEntry(
        'commercial_record_path',
        MultipartFile(commercialRecordFile,
            filename: commercialRecordFile.path.split('/').last),
      ));
    }

    if (logo != null) {
      formData.files.add(MapEntry(
        'logo',
        MultipartFile(logo, filename: logo.path.split('/').last),
      ));
    }
    formData.fields.forEach((field) => print('FIELD => ${field.key}: ${field.value}'));
    return post<BranchModel>(
      "${EndPoints.branchesList}/$branchId",
      formData,
      decoder: BranchModel.fromJson,
    );
  }

  @override
  Future<Response<CitiesModel>> getCities() {
    return get<CitiesModel>(
      EndPoints.cities,
      decoder: CitiesModel.fromJson,
    );
  }
}
