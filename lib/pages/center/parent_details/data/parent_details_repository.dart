import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../control_panel/models/parent_model.dart';
import 'parent_details_api_provider.dart';

abstract class IParentDetailsRepository {
  Future<Response<ParentModel>> getParentDetails(String parentId);
}

class ParentDetailsRepository extends BaseRepository implements IParentDetailsRepository {
  ParentDetailsRepository({required this.provider});
  final IParentDetailsProvider provider;

  @override
  Future<Response<ParentModel>> getParentDetails(String parentId) async {
    final apiResponse = await provider.getParentDetails(parentId);
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
