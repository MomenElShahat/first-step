import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../auth/signup/models/cities_model.dart';
import '../model/edit_profile_request_model.dart';
import '../model/edit_profile_response_model.dart';
import '../model/show_center_data_model.dart';
import 'edit_profile_api_provider.dart';

abstract class IEditProfileRepository {
  Future<Response<CitiesModel>> getCities();
  Future<Response<ShowCenterDataModel>> getCenterData();
  Future<Response<String>> verifyPassword(String password);
  Future<Response<EditProfileResponseModel>> editProfile(EditProfileRequestModel editProfileRequestModel);
}

class EditProfileRepository extends BaseRepository implements IEditProfileRepository {
  EditProfileRepository({required this.provider});

  final IEditProfileProvider provider;

  @override
  Future<Response<CitiesModel>> getCities() async {
    final apiResponse = await provider.getCities();
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      print("Raw response: ${apiResponse.bodyString}");
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<ShowCenterDataModel>> getCenterData() async {
    final apiResponse = await provider.getCenterData();
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      print("Raw response: ${apiResponse.bodyString}");
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<String>> verifyPassword(String password) async {
    final apiResponse = await provider.verifyPassword(password);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      print("Raw response: ${apiResponse.bodyString}");
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<EditProfileResponseModel>> editProfile(EditProfileRequestModel editProfileRequestModel) async {
    final apiResponse = await provider.editProfile(editProfileRequestModel);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      print("Raw response: ${apiResponse.bodyString}");
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
