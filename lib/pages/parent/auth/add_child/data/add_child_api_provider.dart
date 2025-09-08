// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/api_end_points.dart';
import '../../../../../base/base_auth_provider.dart';
import '../../signup_parent/models/signup_parent_request_model.dart';
import '../../signup_parent/models/signup_parent_response_model.dart';



abstract class IAddChildProvider {
  Future<Response<SignupParentResponseModel>> signup(SignupParentRequestModel signupParentRequestModel);
}

class AddChildProvider extends BaseAuthProvider implements IAddChildProvider {
  @override
  Future<Response<SignupParentResponseModel>> signup(SignupParentRequestModel signupParentRequestModel) {
    print(signupParentRequestModel.toJson());
    return post<SignupParentResponseModel>(
        EndPoints.registerParent,
        signupParentRequestModel.toJson(),
        decoder: SignupParentResponseModel.fromJson
    );
  }
}
