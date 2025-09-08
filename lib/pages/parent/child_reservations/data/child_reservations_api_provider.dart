import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../../center/control_panel/models/branch_model.dart';
import '../../control_panel_parent/models/parent_enrollments_model.dart';
import '../model/cancel_response_model.dart';
import '../model/child_enrollment_details_model.dart';
import '../model/parent_branches_model.dart';

abstract class IChildReservationsProvider {
  Future<Response<ChildEnrollmentDetailsModel>> getChildEnrollments(
      String childId);

  Future<Response<CancelResponseModel>> enrollmentRespond(String enrollmentId);

  Future<Response<List<BranchModel>>> getParentBranches();
}

class ChildReservationsProvider extends BaseAuthProvider
    implements IChildReservationsProvider {
  @override
  Future<Response<ChildEnrollmentDetailsModel>> getChildEnrollments(
      String childId) {
    return get<ChildEnrollmentDetailsModel>(
      "${EndPoints.parentEnrollmentsGetChild}/$childId",
      decoder: ChildEnrollmentDetailsModel.fromJson,
    );
  }

  @override
  Future<Response<CancelResponseModel>> enrollmentRespond(String enrollmentId) {
    return post<CancelResponseModel>(
        "${EndPoints.parentEnrollments}$enrollmentId${EndPoints.cancelEnrollmentParent}",
        {},
        decoder: CancelResponseModel.fromJson);
  }

  @override
  Future<Response<List<BranchModel>>> getParentBranches() {
    return get<List<BranchModel>>(
        EndPoints.parentBranches,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => BranchModel.fromJson(e)).toList();
      },);
  }
}
