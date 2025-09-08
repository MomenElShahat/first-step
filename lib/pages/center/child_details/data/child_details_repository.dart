import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import 'child_details_api_provider.dart';

abstract class IChildDetailsRepository {
  Future<Response<ChildModel>> getChildDetails(String childId);
}

class ChildDetailsRepository extends BaseRepository implements IChildDetailsRepository {
  ChildDetailsRepository({required this.provider});
  final IChildDetailsProvider provider;

  @override
  Future<Response<ChildModel>> getChildDetails(String childId) async {
    final apiResponse = await provider.getChildDetails(childId);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
