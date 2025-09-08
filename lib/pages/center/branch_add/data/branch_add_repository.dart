import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../auth/signup/models/cities_model.dart';
import '../../auth/signup/models/signup_request_model.dart';
import '../../control_panel/models/branch_model.dart';
import 'branch_add_api_provider.dart';

abstract class IBranchAddRepository {
  Future<Response<BranchModel>> getBranchDetails(String branchId);

  Future<Response<BranchModel>> addBranch({
    required SignupRequestModel branchModel,
    File? licenseFile,
    File? commercialRecordFile,
    File? logo,
  });

  Future<Response<CitiesModel>> getCities();
}

class BranchAddRepository extends BaseRepository
    implements IBranchAddRepository {
  BranchAddRepository({required this.provider});

  final IBranchAddProvider provider;

  @override
  Future<Response<BranchModel>> getBranchDetails(String branchId) async {
    final apiResponse = await provider.getBranchDetails(branchId);

    if (apiResponse.isOk &&
        apiResponse.body != null &&
        (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      return apiResponse;
    } else {
      throw getErrorMessage(apiResponse.bodyString ?? "Unknown error");
    }
  }

  @override
  Future<Response<BranchModel>> addBranch({
    required SignupRequestModel branchModel,
    File? licenseFile,
    File? commercialRecordFile,
    File? logo,
  }) async {
    final apiResponse = await provider.addBranch(
        branchModel: branchModel,
        commercialRecordFile: commercialRecordFile,
        licenseFile: licenseFile,
        logo: logo);
    print(apiResponse.bodyString);
    if (apiResponse.isOk &&
            apiResponse.body != null &&
            (apiResponse.statusCode == 200) ||
        apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<CitiesModel>> getCities() async {
    final apiResponse = await provider.getCities();
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
