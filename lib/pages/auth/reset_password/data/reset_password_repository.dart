import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../../../services/auth_service.dart';
import '../../../parent/auth/signup_parent/models/signup_parent_response_model.dart';
import 'reset_password_api_provider.dart';

abstract class IResetPasswordRepository {
  Future<Response<SignupParentResponseModel>> resetPassword({required String email,required String password});
}

class ResetPasswordRepository extends BaseRepository implements IResetPasswordRepository {
  ResetPasswordRepository({required this.provider});
  final IResetPasswordProvider provider;

  @override
  Future<Response<SignupParentResponseModel>> resetPassword({required String email,required String password}) async {
    final apiResponse =
    await provider.resetPassword(email: email , password: password);
    print("apiResponse.bodyString ${apiResponse.bodyString}");
    print("apiResponse.statusCode ${apiResponse.statusCode}");

    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200 || apiResponse.statusCode==201)) {
      print("Raw response: ${apiResponse.bodyString}");
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

}
