import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../auth/signup/models/cities_model.dart';
import '../../control_panel/models/branch_model.dart';
import 'branch_details_api_provider.dart';

abstract class IBranchDetailsRepository {
  Future<Response<BranchModel>> getBranchDetails(String branchId);
  Future<Response<CitiesModel>> getCities();
}

class BranchDetailsRepository extends BaseRepository implements IBranchDetailsRepository {
  BranchDetailsRepository({required this.provider});
  final IBranchDetailsProvider provider;

  @override
  Future<Response<BranchModel>> getBranchDetails(String branchId) async {
    final apiResponse = await provider.getBranchDetails(branchId);

    if (apiResponse.isOk &&
        apiResponse.body != null &&
        (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      final firstBranch = apiResponse.body!;
      return Response(
        body: firstBranch,
        statusCode: apiResponse.statusCode,
        request: apiResponse.request,
        statusText: apiResponse.statusText,
      );
    } else {
      throw getErrorMessage(apiResponse.bodyString ?? "Unknown error");
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
