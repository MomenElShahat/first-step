import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/api_end_points.dart';
import '../model/status_model.dart';

abstract class ILifecycleProvider {
  Future<Response<StatusModel>> goOnline();
  Future<Response<StatusModel>> goOffline();
}

class LifecycleProvider extends BaseAuthProvider implements ILifecycleProvider {
  @override
  Future<Response<StatusModel>> goOnline() {
    return post<StatusModel>(
        EndPoints.online,
        {},
        decoder: StatusModel.fromJson,);
  }

  @override
  Future<Response<StatusModel>> goOffline() {
    return post<StatusModel>(
        EndPoints.offline,
      {},
        decoder: StatusModel.fromJson,);
  }
}
