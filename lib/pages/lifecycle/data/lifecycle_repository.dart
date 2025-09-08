import 'package:first_step/pages/lifecycle/data/lifecycle_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/base_repositroy.dart';
import '../model/status_model.dart';

abstract class ILifecycleRepository {
  Future<Response<StatusModel>> goOnline();

  Future<Response<StatusModel>> goOffline();
}

class LifecycleRepository extends BaseRepository
    implements ILifecycleRepository {
  LifecycleRepository({required this.provider});

  final ILifecycleProvider provider;

  @override
  Future<Response<StatusModel>> goOnline() async {
    final apiResponse = await provider.goOnline();
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
  Future<Response<StatusModel>> goOffline() async {
    final apiResponse = await provider.goOffline();
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
}
