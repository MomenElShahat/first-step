import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../add_child_parent/model/add_child_request_model.dart';
import '../models/edit_child_request_model.dart';
import '../models/edit_child_response_model.dart';
import 'edit_child_details_api_provider.dart';

abstract class IEditChildDetailsRepository {
  Future<Response<ChildModel>> getChildDetails(String childId);

  Future<Response<EditChildResponseModel>> editChild(
      {required AddChildRequestModel addChildRequestModel,
      required String childId});
}

class EditChildDetailsRepository extends BaseRepository
    implements IEditChildDetailsRepository {
  EditChildDetailsRepository({required this.provider});

  final IEditChildDetailsProvider provider;

  @override
  Future<Response<ChildModel>> getChildDetails(String childId) async {
    final apiResponse = await provider.getChildDetails(childId);
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
  Future<Response<EditChildResponseModel>> editChild(
      {required AddChildRequestModel addChildRequestModel,
      required String childId}) async {
    final apiResponse = await provider.editChild(
        addChildRequestModel: addChildRequestModel, childId: childId);
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
