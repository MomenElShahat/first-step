import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../auth/signup/models/cities_model.dart';
import '../model/edit_profile_request_model.dart';
import '../model/edit_profile_response_model.dart';
import '../model/show_center_data_model.dart';

abstract class IEditProfileProvider {
  Future<Response<CitiesModel>> getCities();
  Future<Response<ShowCenterDataModel>> getCenterData();
  Future<Response<String>> verifyPassword(String password);
  Future<Response<EditProfileResponseModel>> editProfile(EditProfileRequestModel editProfileRequestModel);
}

class EditProfileProvider extends BaseAuthProvider implements IEditProfileProvider {
  @override
  Future<Response<CitiesModel>> getCities() {
    return get<CitiesModel>(
      EndPoints.cities,
      decoder: CitiesModel.fromJson,
    );
  }

  @override
  Future<Response<ShowCenterDataModel>> getCenterData() {
    return get<ShowCenterDataModel>(
      EndPoints.getCenter,
      decoder: ShowCenterDataModel.fromJson,
    );
  }

  @override
  Future<Response<String>> verifyPassword(String password) {
    return put<String>(
      EndPoints.verifyPassword,
      {
        "password": password,
      },
      decoder: (data) {
        final json = data["message"] as String;
        return json;
      },
    );
  }

  @override
  Future<Response<EditProfileResponseModel>> editProfile(EditProfileRequestModel editProfileRequestModel) {
    return put<EditProfileResponseModel>(
      EndPoints.updateProfileCenter,
      editProfileRequestModel.toJson(),
      decoder: EditProfileResponseModel.fromJson,
    );
  }
}
