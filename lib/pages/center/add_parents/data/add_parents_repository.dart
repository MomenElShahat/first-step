import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../model/add_parents_request_model.dart';
import '../model/add_parents_response_model.dart';
import 'add_parents_api_provider.dart';

abstract class IAddParentsRepository {
  Future<Response<AddParentsResponseModel>> addParent({required AddParentsRequestModel addParentsRequestModel});
}

class AddParentsRepository extends BaseRepository implements IAddParentsRepository {
  AddParentsRepository({required this.provider});

  final IAddParentsProvider provider;
  @override
  Future<Response<AddParentsResponseModel>> addParent({required AddParentsRequestModel addParentsRequestModel}) async {
    final apiResponse = await provider.addParent(addParentsRequestModel: addParentsRequestModel);
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
