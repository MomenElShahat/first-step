import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../../../services/auth_service.dart';
import '../models/login_request.dart';
import '../models/user_model.dart';
import 'login_api_provider.dart';

abstract class ILoginRepository {
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest);

  Future<Response<LoginResponseModel>> loginWithGoogle({required String token});
}

class LoginRepository extends BaseRepository implements ILoginRepository {
  LoginRepository({required this.provider});

  final ILoginProvider provider;

  @override
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest) async {
    final apiResponse = await provider.login(loginRequest);
    print(apiResponse.bodyString);

    final body = apiResponse.body;

    // If backend sends status "401" inside body
    if (body?.status == 401 || body?.user == null) {
      throw body?.message ?? "Invalid email or password.";
    }

    // Otherwise, handle normal success
    if (apiResponse.isOk && body != null && apiResponse.statusCode == 200) {
      AuthService.to.login(body);
      return apiResponse;
    } else {
      throw (getErrorMessage(apiResponse.bodyString ?? ""));
    }
  }

  @override
  Future<Response<LoginResponseModel>> loginWithGoogle({required String token}) async {
    final apiResponse = await provider.loginWithGoogle(token: token);
    print(apiResponse.bodyString);

    if (apiResponse.isOk && apiResponse.body != null && apiResponse.statusCode == 200) {
      AuthService.to.login(apiResponse.body!);
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
