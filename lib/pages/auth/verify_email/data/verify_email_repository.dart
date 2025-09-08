import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../../../services/auth_service.dart';
import '../../../parent/auth/signup_parent/models/signup_parent_response_model.dart';
import 'verify_email_api_provider.dart';

abstract class IVerifyEmailRepository {
  Future<Response<SignupParentResponseModel>> sendOtp(String email);
}

class VerifyEmailRepository extends BaseRepository implements IVerifyEmailRepository {
  VerifyEmailRepository({required this.provider});
  final IVerifyEmailProvider provider;

  @override
  Future<Response<SignupParentResponseModel>> sendOtp(String email) async {
    final apiResponse =
    await provider.sendOtp(email);
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
