import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../../base/api_end_points.dart';
import '../../../../../base/base_auth_provider.dart';
import '../../../../../services/auth_service.dart';
import '../../../../auth/login/models/login_request.dart';
import '../../../../auth/login/models/user_model.dart';
import '../models/cities_model.dart';
import '../models/signup_request_model.dart';
import '../models/signup_response_model.dart';

abstract class ISignupProvider {
  Future<Response<SignupResponseModel>> signup(
    SignupRequestModel signupRequestModel,
    File? licenseFile,
    File? commercialRecordFile,
    File? logo,
  );
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest);

  Future<Response<CitiesModel>> getCities();
}

class SignupProvider extends BaseAuthProvider implements ISignupProvider {
  @override
  Future<Response<SignupResponseModel>> signup(
    SignupRequestModel signupRequestModel,
    File? licenseFile,
    File? commercialRecordFile,
    File? logo,
  ) {
    final formData = FormData({});

    // Helper function to add non-null fields
    void addField(String key, dynamic value) {
      if (value != null) {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    }

    // Basic fields
    addField('name', signupRequestModel.name);
    addField('email', signupRequestModel.email);
    // addField('address', signupRequestModel.address);
    addField('password', signupRequestModel.password);
    addField('nursery_name', signupRequestModel.nurseryName);
    addField('location', signupRequestModel.location);
    addField('city_id', signupRequestModel.cityID);
    addField('neighborhood', signupRequestModel.neighborhood);
    addField('phone', signupRequestModel.phone);
    // addField('additional_service', signupRequestModel.additionalService);
    // addField('work_days_from', signupRequestModel.workDaysFrom);
    // addField('work_days_to', signupRequestModel.workDaysTo);
    // addField('work_hours_from', signupRequestModel.workHoursFrom);
    // addField('work_hours_to', signupRequestModel.workHoursTo);
    // addField('time_of_first_period', signupRequestModel.timeOfFirstPeriod);
    // addField('time_of_second_period', signupRequestModel.timeOfSecondPeriod);

    // Boolean values as real booleans
    // addField('emergency_contact', signupRequestModel.emergencyContact == true ? '1' : '0');
    // addField('special_needs', signupRequestModel.specialNeeds == true ? '1' : '0');
    // addField('provides_food', signupRequestModel.providesFood == true ? '1' : '0');

    // List fields
    // for (int i = 0; i < signupRequestModel.services.length; i++) {
    //   final service = signupRequestModel.services[i];
    //   addField('services[$i]', service);
    // }
    for (int i = 0; i < (signupRequestModel.nurseryType?.length ?? 0); i++) {
      final nurseryType = signupRequestModel.nurseryType?[i];
      addField('nursery_type[$i]', nurseryType);
    }
    // for (int i = 0; i < signupRequestModel.acceptedAges.length; i++) {
    //   final acceptedAges = signupRequestModel.acceptedAges[i];
    //   addField('accepted_ages[$i]', acceptedAges);
    // }
    // for (int i = 0; i < signupRequestModel.communicationMethods.length; i++) {
    //   final communicationMethods = signupRequestModel.communicationMethods[i];
    //   addField('communication_methods[$i]', communicationMethods);
    // }

    // Pricing list - each item encoded as JSON string
    // for (int i = 0; i < (signupRequestModel.pricing?.length ?? 0); i++) {
    //   final price = signupRequestModel.pricing?[i];
    //   addField('pricing[$i][enrollment_type]', price?.enrollmentType);
    //   addField('pricing[$i][response_speed]', price?.responseSpeed);
    //   addField('pricing[$i][price_amount]', price?.priceAmount.toString());
    // }

    // Meals (first_meals)
    // if(signupRequestModel.firstMeals != null){
    //   for (int i = 0; i < (signupRequestModel.firstMeals?.length ?? 0); i++) {
    //     final meal = signupRequestModel.firstMeals?[i];
    //     addField('first_meals[$i][meal_name]', meal?.mealName);
    //     addField('first_meals[$i][juice]', meal?.juice);
    //     addField('first_meals[$i][components]', meal?.components);
    //   }
    // }
    //
    // // Meals (second_meals)
    // if(signupRequestModel.secondMeals != null){
    //   for (int i = 0; i < (signupRequestModel.secondMeals?.length ?? 0); i++) {
    //     final meal = signupRequestModel.secondMeals?[i];
    //     addField('second_meals[$i][meal_name]', meal?.mealName);
    //     addField('second_meals[$i][juice]', meal?.juice);
    //     addField('second_meals[$i][components]', meal?.components);
    //   }
    // }

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
        MultipartFile(commercialRecordFile, filename: commercialRecordFile.path.split('/').last),
      ));
    }

    if (logo != null) {
      formData.files.add(MapEntry(
        'logo',
        MultipartFile(logo, filename: logo.path.split('/').last),
      ));
    }

    // Debug print for verification
    formData.fields.forEach((field) => print('FIELD => ${field.key}: ${field.value}'));

    return post<SignupResponseModel>(
      EndPoints.registerCenterV2,
      formData,
      decoder: SignupResponseModel.fromJson,
      contentType: 'multipart/form-data',
    );
  }

  @override
  Future<Response<CitiesModel>> getCities() {
    return get<CitiesModel>(
      EndPoints.cities,
      decoder: CitiesModel.fromJson,
    );
  }

  @override
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest) {
    FirebaseMessaging.instance.getToken().then((token) {
      String fcmToken = token ?? "";
      AuthService.fcmToken = fcmToken;
    });
    log("${{"email": loginRequest.email, "password": loginRequest.password, "fcm_token": AuthService.fcmToken}}");
    return post<LoginResponseModel>(
      EndPoints.loginV2,
      {"email": loginRequest.email, "password": loginRequest.password, "fcm_token": AuthService.fcmToken},
      decoder: LoginResponseModel.fromJson,
    );
  }
}
