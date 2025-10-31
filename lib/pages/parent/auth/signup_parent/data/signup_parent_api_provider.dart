// ignore: one_member_abstracts
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/api_end_points.dart';
import '../../../../../base/base_auth_provider.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../../../auth/login/models/login_request.dart';
import '../../../../auth/login/models/user_model.dart';
// import '../../../home_parent/models/centers_model.dart';
// import '../models/signup_parent_request_model.dart';
import '../../../../center/control_panel/models/child_model.dart' as child;
import '../../../home_parent/models/centers_model.dart';
import '../../add_child/model/existing_enrollment_request_model.dart';
import '../../add_child/model/existing_enrollment_response_model.dart';
import '../models/signup_parent_request_model.dart';
import '../models/signup_parent_response_model.dart';



abstract class ISignupParentProvider {
  Future<Response<SignupParentResponseModel>> signup(SignupParentRequestModel signupParentRequestModel);
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest);
  Future<Response<CentersModel>> getCentersWithFilter(
      {required String filter, required List<String> selectedCityIds});
  Future<Response<List<child.ChildModel>>> getChildren();
  Future<Response<ExistingEnrollmentResponseModel>> sendRequest(ExistingEnrollmentRequestModel model);
}

class SignupParentProvider extends BaseAuthProvider implements ISignupParentProvider {
  @override
  Future<Response<SignupParentResponseModel>> signup(SignupParentRequestModel signupParentRequestModel) {
    print(signupParentRequestModel.toJson());
    return post<SignupParentResponseModel>(
        EndPoints.registerParentV2,
        signupParentRequestModel.toJson(),
        decoder: SignupParentResponseModel.fromJson
    );
  }

  @override
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest) {
    FirebaseMessaging.instance.getToken().then((token) {
      String fcmToken = token ?? "";
      AuthService.fcmToken = fcmToken;
    });
    log("${{
      "email": loginRequest.email,
      "password": loginRequest.password,
      "fcm_token": AuthService.fcmToken
    }}");
    return post<LoginResponseModel>(
      EndPoints.loginV2,
      {
        "email": loginRequest.email,
        "password": loginRequest.password,
        "fcm_token": AuthService.fcmToken
      },
      decoder: LoginResponseModel.fromJson,
    );
  }

  @override
  Future<Response<CentersModel>> getCentersWithFilter({
    required String filter,
    required List<String> selectedCityIds,
  }) {
    String? selectedFilter;
    if (filter == AppStrings.nurseriesFrom0To3Years) {
      selectedFilter = "0-3";
    } else if (filter == AppStrings.nurseriesFrom3To6Years) {
      selectedFilter = "3-6";
    } else if (filter == AppStrings.childrenWithSpecialNeeds) {
      selectedFilter = "disabled";
    } else if (filter == AppStrings.all) {
      selectedFilter = null;
    }

    // Build city_id[] parameter
    String? cityParams;
    if (selectedCityIds.isEmpty) {
      cityParams = null; // Required field sent as empty string
    } else {
      cityParams = selectedCityIds.map((id) => 'city_id[]=$id').join('&');
    }

    // Base query parameters
    String baseQuery = "age=$selectedFilter";

    // Combine full URL
    String finalUrl =
        "${EndPoints.centerFilterParent}?${selectedFilter != null ? baseQuery : null}&${cityParams != null ? cityParams : null}";

    print("Final URL: $finalUrl");

    return get<CentersModel>(
      finalUrl,
      decoder: CentersModel.fromJson,
    );
  }

  @override
  Future<Response<List<child.ChildModel>>> getChildren() {
    return get<List<child.ChildModel>>(
      EndPoints.childrenParentList,
      decoder: (data) {
        if (data is List) {
          // normal case: API returned a list of children
          return data.map((e) => child.ChildModel.fromJson(e)).toList();
        } else if (data is Map<String, dynamic>) {
          // case when API wraps result or returns empty object
          if (data["children"] is List) {
            return (data["children"] as List)
                .map((e) => child.ChildModel.fromJson(e))
                .toList();
          }
          return []; // fallback if it's {} or doesn't contain children
        }
        return [];
      },
    );
  }

  @override
  Future<Response<ExistingEnrollmentResponseModel>> sendRequest(ExistingEnrollmentRequestModel model) {
    return post<ExistingEnrollmentResponseModel>(
      EndPoints.enrollmentExisting,
      model.toJson(),
      decoder: ExistingEnrollmentResponseModel.fromJson,
    );
  }

}
