import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../model/add_child_request_model.dart';
import '../model/add_child_response_model.dart';

abstract class IAddChildParentProvider {
  Future<Response<AddChildResponseModel>> addChild(
      AddChildRequestModel addChildRequestModel);
}

class AddChildParentProvider extends BaseAuthProvider
    implements IAddChildParentProvider {
  @override
  Future<Response<AddChildResponseModel>> addChild(
      AddChildRequestModel addChildRequestModel) {
    print(addChildRequestModel.toJson());
    return post<AddChildResponseModel>(
        EndPoints.childrenParentList,
        {
          "children": [addChildRequestModel.toJson()]
        },
        decoder: AddChildResponseModel.fromJson);
  }
}
