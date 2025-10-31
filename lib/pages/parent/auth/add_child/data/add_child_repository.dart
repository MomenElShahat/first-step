import 'dart:io';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../../base/base_repositroy.dart';
import '../../../../../services/auth_service.dart';
import '../../../../auth/login/models/login_request.dart';
import '../../../../auth/login/models/user_model.dart';
import '../../../../center/control_panel/models/child_model.dart' as child;
import '../../../home_parent/models/centers_model.dart';
import '../../signup_parent/models/signup_parent_response_model.dart';
import '../model/child_request_model.dart';
import '../model/child_response_model.dart';
import '../model/existing_enrollment_request_model.dart';
import '../model/existing_enrollment_response_model.dart';
import 'add_child_api_provider.dart';

abstract class IAddChildRepository {
  Future<Response<ChildResponseModel>> addChildren(
      List<ChildRequestModel> children,
      // List<File?> images
      );
  Future<Response<CentersModel>> getCentersWithFilter({required String filter,required List<String> selectedCityIds});
  Future<Response<List<child.ChildModel>>> getChildren();
  Future<Response<ExistingEnrollmentResponseModel>> sendRequest(ExistingEnrollmentRequestModel model);
}

class AddChildRepository extends BaseRepository implements IAddChildRepository {
  AddChildRepository({required this.provider});
  final IAddChildProvider provider;

  @override
  Future<Response<ChildResponseModel>> addChildren(
      List<ChildRequestModel> children,
      // List<File?> images
      ) async {
    final apiResponse = await provider.addChildren(children,
        // images
    );
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null &&
        (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<CentersModel>> getCentersWithFilter({required String filter,required List<String> selectedCityIds}) async {
    final apiResponse =
    await provider.getCentersWithFilter(filter: filter,selectedCityIds: selectedCityIds);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<List<child.ChildModel>>> getChildren() async {
    final apiResponse = await provider.getChildren();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<ExistingEnrollmentResponseModel>> sendRequest(ExistingEnrollmentRequestModel model) async {
    final apiResponse = await provider.sendRequest(model);
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
