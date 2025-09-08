// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../auth/signup/models/cities_model.dart';
import '../../control_panel/models/branch_model.dart';

abstract class IBranchDetailsProvider {
  Future<Response<BranchModel>> getBranchDetails(String branchId);
  Future<Response<CitiesModel>> getCities();
}

class BranchDetailsProvider extends BaseAuthProvider implements IBranchDetailsProvider {

  @override
  Future<Response<BranchModel>> getBranchDetails(String branchId) {
    return get<BranchModel>(
      "${EndPoints.branchesList}/$branchId",
      decoder: BranchModel.fromJson,
    );
  }


  @override
  Future<Response<CitiesModel>> getCities() {
    return get<CitiesModel>(
      EndPoints.cities,
      decoder: CitiesModel.fromJson,
    );
  }
}
