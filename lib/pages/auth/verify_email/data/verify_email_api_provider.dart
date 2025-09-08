// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../../../base/base_auth_provider.dart';
import '../../../parent/auth/signup_parent/models/signup_parent_response_model.dart';


abstract class IVerifyEmailProvider {
  Future<Response<SignupParentResponseModel>> sendOtp(String email);
}

class VerifyEmailProvider extends BaseAuthProvider implements IVerifyEmailProvider {

  @override
  Future<Response<SignupParentResponseModel>> sendOtp(String email) {
    final formData = FormData({
      'email': email,
    });
    print("email $email");
    return post<SignupParentResponseModel>(
      EndPoints.forgetPassword,
      formData,
      decoder: SignupParentResponseModel.fromJson,
    );
  }

}
