// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../../../base/base_auth_provider.dart';
import '../models/login_request.dart';
import '../models/user_model.dart';

abstract class ILoginProvider {
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest);

  Future<Response<LoginResponseModel>> loginWithGoogle({required String token});
}

class LoginProvider extends BaseAuthProvider implements ILoginProvider {
  @override
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest) {
    print(loginRequest.toJson());
    return post<LoginResponseModel>(
      EndPoints.login,
      {"email": loginRequest.email, "password": loginRequest.password},
      decoder: LoginResponseModel.fromJson,
    );
  }

  @override
  Future<Response<LoginResponseModel>> loginWithGoogle(
      {required String token}) {
    print("google token $token");
    return post<LoginResponseModel>(
      EndPoints.loginWithGoogle,
      {"token": token},
      decoder: LoginResponseModel.fromJson,
    );
  }
}
