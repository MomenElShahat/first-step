
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../../center/control_panel/models/branch_model.dart';
import '../../control_panel_parent/models/parent_enrollments_model.dart';
import '../model/cancel_response_model.dart';
import '../model/child_enrollment_details_model.dart';
import '../model/parent_branches_model.dart';
import 'child_reservations_api_provider.dart';

abstract class IChildReservationsRepository {
  Future<Response<ChildEnrollmentDetailsModel>> getChildEnrollments(String childId);
  Future<Response<CancelResponseModel>> enrollmentRespond(String enrollmentId);
  Future<Response<List<BranchModel>>> getParentBranches();
}

class ChildReservationsRepository extends BaseRepository implements IChildReservationsRepository {
  ChildReservationsRepository({required this.provider});

  final IChildReservationsProvider provider;

  @override
  Future<Response<ChildEnrollmentDetailsModel>> getChildEnrollments(String childId) async {
    final apiResponse = await provider.getChildEnrollments(childId);
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
  Future<Response<CancelResponseModel>> enrollmentRespond(String enrollmentId) async {
    final apiResponse = await provider.enrollmentRespond(enrollmentId);
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
  Future<Response<List<BranchModel>>> getParentBranches() async {
    final apiResponse = await provider.getParentBranches();
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
