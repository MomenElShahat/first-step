import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../model/add_parents_request_model.dart';
import '../model/add_parents_response_model.dart';

abstract class IAddParentsProvider {
  Future<Response<AddParentsResponseModel>> addParent({required AddParentsRequestModel addParentsRequestModel});
}

class AddParentsProvider extends BaseAuthProvider implements IAddParentsProvider {
  @override
  Future<Response<AddParentsResponseModel>> addParent({required AddParentsRequestModel addParentsRequestModel}) async {
    final formData = await addParentsRequestModel.toFormData();
    formData.fields.forEach((field) => print('FIELD => ${field.key}: ${field.value}'));

    return post<AddParentsResponseModel>(
      EndPoints.registerParentByCenter,
      formData,
      decoder: AddParentsResponseModel.fromJson,
    );
  }
}
