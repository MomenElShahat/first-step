import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../../../services/auth_service.dart';
import '../model/check_code_response_model.dart';
import 'otp_api_provider.dart';

abstract class IOtpRepository {
  Future<Response<CheckCodeResponseModel>> checkOtp(
      {required String email, required String otp});
}

class OtpRepository extends BaseRepository implements IOtpRepository {
  OtpRepository({required this.provider});

  final IOtpProvider provider;

  @override
  Future<Response<CheckCodeResponseModel>> checkOtp(
      {required String email, required String otp}) async {
    final apiResponse = await provider.checkOtp(email: email, otp: otp);
    print("apiResponse.bodyString ${apiResponse.bodyString}");
    print("apiResponse.statusCode ${apiResponse.statusCode}");

    if (apiResponse.isOk &&
        apiResponse.body != null &&
        (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      print("Raw response: ${apiResponse.bodyString}");
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
