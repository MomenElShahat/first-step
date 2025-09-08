
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../parent/home_parent/models/services_model.dart';
import '../model/plans_model.dart';
import 'home_api_provider.dart';

abstract class IHomeRepository {
  Future<Response<ServicesParentResponseModel>> getServices();
  Future<Response<PlansModel>> getPlans();
}

class HomeRepository extends BaseRepository implements IHomeRepository {
  HomeRepository({required this.provider});
  final IHomeProvider provider;

  @override
  Future<Response<ServicesParentResponseModel>> getServices()async {
    final apiResponse =
    await provider.getServices();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<PlansModel>> getPlans()async {
    final apiResponse =
    await provider.getPlans();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
