
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../model/add_child_request_model.dart';
import '../model/add_child_response_model.dart';
import 'add_child_parent_api_provider.dart';

abstract class IAddChildParentRepository {
  Future<Response<AddChildResponseModel>> addChild(AddChildRequestModel addChildRequestModel);
}

class AddChildParentRepository extends BaseRepository implements IAddChildParentRepository {
  AddChildParentRepository({required this.provider});

  final IAddChildParentProvider provider;

  @override
  Future<Response<AddChildResponseModel>> addChild(AddChildRequestModel addChildRequestModel)async {
    final apiResponse =
    await provider.addChild(addChildRequestModel);
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
