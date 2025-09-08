
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../signup_parent/models/signup_parent_request_model.dart';
import '../../signup_parent/models/signup_parent_response_model.dart';
import 'add_child_api_provider.dart';

abstract class IAddChildRepository {
  Future<Response<SignupParentResponseModel>> signup(SignupParentRequestModel signupParentRequestModel);
}

class AddChildRepository extends BaseRepository implements IAddChildRepository {
  AddChildRepository({required this.provider});
  final IAddChildProvider provider;

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
}
