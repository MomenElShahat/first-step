import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../base/base_repositroy.dart';
import '../../../center/auth/signup/models/cities_model.dart';
import '../model/edit_profile_parent_request_model.dart';
import '../model/edit_profile_parent_response_model.dart';
import '../model/show_parent_data_model.dart';
import 'edit_profile_parent_api_provider.dart';


abstract class IEditProfileParentRepository {
  Future<Response<CitiesModel>> getCities();
  Future<Response<ShowParentDataModel>> getParentData();
  Future<Response<String>> verifyPassword(String password);
  Future<Response<EditProfileParentResponseModel>> editProfile(EditProfileParentRequestModel editProfileParentRequestModel);
}

class EditProfileParentRepository extends BaseRepository implements IEditProfileParentRepository {
  EditProfileParentRepository({required this.provider});

  final IEditProfileParentProvider provider;

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
  Future<Response<ShowParentDataModel>> getParentData() async {
    final apiResponse = await provider.getParentData();
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
  Future<Response<EditProfileParentResponseModel>> editProfile(EditProfileParentRequestModel editProfileParentRequestModel) async {
    final apiResponse = await provider.editProfile(editProfileParentRequestModel);
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
