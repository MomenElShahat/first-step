// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../../../base/base_auth_provider.dart';
import '../../../parent/auth/signup_parent/models/signup_parent_response_model.dart';


abstract class IResetPasswordProvider {
  Future<Response<SignupParentResponseModel>> resetPassword({required String email,required String password});
}

class ResetPasswordProvider extends BaseAuthProvider implements IResetPasswordProvider {

  @override
  Future<Response<SignupParentResponseModel>> resetPassword({required String email,required String password}) {
    final formData = FormData({
      'email': email,
      'password': password,
    });
    print("formData resetPassword ${{
      'email': email,
      'password': password,
    }}");
    return post<SignupParentResponseModel>(
      EndPoints.resetPassword,
      formData,
      decoder: SignupParentResponseModel.fromJson,
    );
  }

}
