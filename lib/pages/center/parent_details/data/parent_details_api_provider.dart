// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../control_panel/models/parent_model.dart';

abstract class IParentDetailsProvider {
  Future<Response<ParentModel>> getParentDetails(String parentId);
}

class ParentDetailsProvider extends BaseAuthProvider implements IParentDetailsProvider {
  @override
  Future<Response<ParentModel>> getParentDetails(String parentId) {
    return get<ParentModel>(
      "${EndPoints.parent}/$parentId",
      decoder: ParentModel.fromJson,
    );
  }
}
