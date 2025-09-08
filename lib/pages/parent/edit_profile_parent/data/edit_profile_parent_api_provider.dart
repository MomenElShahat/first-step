import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../base/api_end_points.dart';
import '../../../center/auth/signup/models/cities_model.dart';
import '../../../center/edit_profile/model/edit_profile_response_model.dart';
import '../model/edit_profile_parent_request_model.dart';
import '../model/edit_profile_parent_response_model.dart';
import '../model/show_parent_data_model.dart';

abstract class IEditProfileParentProvider {
  Future<Response<CitiesModel>> getCities();

  Future<Response<ShowParentDataModel>> getParentData();

  Future<Response<String>> verifyPassword(String password);

  Future<Response<EditProfileParentResponseModel>> editProfile(
      EditProfileParentRequestModel editProfileParentRequestModel);
}

class EditProfileParentProvider extends BaseAuthProvider
    implements IEditProfileParentProvider {
  @override
  Future<Response<CitiesModel>> getCities() {
    return get<CitiesModel>(
      EndPoints.cities,
      decoder: CitiesModel.fromJson,
    );
  }

  @override
  Future<Response<ShowParentDataModel>> getParentData() {
    return get<ShowParentDataModel>(
      EndPoints.getUser,
      decoder: ShowParentDataModel.fromJson,
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
  Future<Response<EditProfileParentResponseModel>> editProfile(
      EditProfileParentRequestModel editProfileParentRequestModel) {
    return put<EditProfileParentResponseModel>(
      EndPoints.updateProfileParent,
      {
        if (editProfileParentRequestModel.email != null)
          "email": editProfileParentRequestModel.email,
        if (editProfileParentRequestModel.phone != null)
          "phone": editProfileParentRequestModel.phone,
        if (editProfileParentRequestModel.name != null)
          "name": editProfileParentRequestModel.name,
        if (editProfileParentRequestModel.nationalNumber != null)
          "national_number": editProfileParentRequestModel.nationalNumber
      },
      decoder: EditProfileParentResponseModel.fromJson,
    );
  }
}
