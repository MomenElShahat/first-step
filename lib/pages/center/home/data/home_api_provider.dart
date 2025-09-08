// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../parent/home_parent/models/services_model.dart';
import '../model/plans_model.dart';



abstract class IHomeProvider {
  Future<Response<ServicesParentResponseModel>> getServices();
  Future<Response<PlansModel>> getPlans();
}

class HomeProvider extends BaseAuthProvider implements IHomeProvider {
  @override
  Future<Response<ServicesParentResponseModel>> getServices() {
    return get<ServicesParentResponseModel>(
        EndPoints.servicesParent,
        decoder: ServicesParentResponseModel.fromJson
    );
  }

  @override
  Future<Response<PlansModel>> getPlans() {
    return get<PlansModel>(
        EndPoints.plans,
        decoder: PlansModel.fromJson
    );
  }
}
