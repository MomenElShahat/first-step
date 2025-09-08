// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../../../base/base_auth_provider.dart';
import '../model/check_code_response_model.dart';


abstract class IOtpProvider {
  Future<Response<CheckCodeResponseModel>> checkOtp({required String email,required String otp});
}

class OtpProvider extends BaseAuthProvider implements IOtpProvider {

  @override
  Future<Response<CheckCodeResponseModel>> checkOtp({required String email,required String otp}) {
    final formData = FormData({
      'email': email,
      'otp': otp,
    });
    print("formData check otp ${{
      'email': email,
      'otp': otp,
    }}");
    return post<CheckCodeResponseModel>(
      EndPoints.checkOtp,
      formData,
      decoder: CheckCodeResponseModel.fromJson,
    );
  }
}
