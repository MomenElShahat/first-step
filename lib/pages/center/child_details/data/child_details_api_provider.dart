// ignore: one_member_abstracts
import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';

abstract class IChildDetailsProvider {
  Future<Response<ChildModel>> getChildDetails(String childId);
}

class ChildDetailsProvider extends BaseAuthProvider implements IChildDetailsProvider {
  @override
  Future<Response<ChildModel>> getChildDetails(String childId) {
    return get<ChildModel>(
      "${AuthService.to.userInfo?.user?.role == "parent" ? EndPoints.childrenParentList : EndPoints.childrenList}/$childId",
      decoder: ChildModel.fromJson,
    );
  }
}
