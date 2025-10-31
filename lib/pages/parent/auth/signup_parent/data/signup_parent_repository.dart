
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../../../services/auth_service.dart';
import '../../../../auth/login/models/login_request.dart';
import '../../../../auth/login/models/user_model.dart';
import '../../../home_parent/models/centers_model.dart';
import '../../add_child/model/existing_enrollment_request_model.dart';
import '../../add_child/model/existing_enrollment_response_model.dart';
import '../models/signup_parent_request_model.dart';
import '../models/signup_parent_response_model.dart';
import 'signup_parent_api_provider.dart';
import '../../../../center/control_panel/models/child_model.dart' as child;


abstract class ISignupParentRepository {
  Future<Response<SignupParentResponseModel>> signup(SignupParentRequestModel signupParentRequestModel);
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest);
  Future<Response<CentersModel>> getCentersWithFilter({required String filter,required List<String> selectedCityIds});
  Future<Response<List<child.ChildModel>>> getChildren();
  Future<Response<ExistingEnrollmentResponseModel>> sendRequest(ExistingEnrollmentRequestModel model);
}

class SignupParentRepository extends BaseRepository implements ISignupParentRepository {
  SignupParentRepository({required this.provider});
  final ISignupParentProvider provider;

  @override
  Future<Response<SignupParentResponseModel>> signup(SignupParentRequestModel signupParentRequestModel)async {
    final apiResponse =
    await provider.signup(signupParentRequestModel);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest)async {
    final apiResponse =
    await provider.login(loginRequest);
    print(apiResponse.bodyString);

    if (apiResponse.isOk && apiResponse.body != null&& apiResponse.statusCode==200) {
      AuthService.to.login(apiResponse.body!);
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<CentersModel>> getCentersWithFilter({required String filter,required List<String> selectedCityIds}) async {
    final apiResponse =
    await provider.getCentersWithFilter(filter: filter,selectedCityIds: selectedCityIds);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<List<child.ChildModel>>> getChildren() async {
    final apiResponse = await provider.getChildren();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<ExistingEnrollmentResponseModel>> sendRequest(ExistingEnrollmentRequestModel model) async {
    final apiResponse = await provider.sendRequest(model);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

}
