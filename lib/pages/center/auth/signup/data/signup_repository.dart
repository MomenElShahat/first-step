import 'dart:io';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../../base/base_repositroy.dart';
import '../models/cities_model.dart';
import '../models/signup_request_model.dart';
import '../models/signup_response_model.dart';
import 'signup_api_provider.dart';

abstract class ISignupRepository {
  Future<Response<SignupResponseModel>> signup(SignupRequestModel signupRequestModel, File? licenseFile,
      File? commercialRecordFile,File? logo,);

  Future<Response<CitiesModel>> getCities();
}

class SignupRepository extends BaseRepository implements ISignupRepository {
  SignupRepository({required this.provider});
  final ISignupProvider provider;

  @override
  Future<Response<SignupResponseModel>> signup(SignupRequestModel signupRequestModel, File? licenseFile,
      File? commercialRecordFile,File? logo,)async {
    final apiResponse =
    await provider.signup(signupRequestModel,licenseFile,commercialRecordFile,logo,);
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


  @override
  Future<Response<CitiesModel>> getCities()async {
    final apiResponse =
    await provider.getCities();
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
