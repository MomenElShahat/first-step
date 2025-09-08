import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../../center/control_panel/models/child_model.dart';
import '../model/parent_enrollment_request_model.dart';
import '../model/parent_enrollment_response_model.dart';

abstract class IBookingProvider {
  Future<Response<List<ChildModel>>> getChildren();
  Future<Response<ParentEnrollmentResponseModel>> enroll(ParentEnrollmentRequestModel parentEnrollmentRequestModel);
}

class BookingProvider extends BaseAuthProvider implements IBookingProvider {
  @override
  Future<Response<List<ChildModel>>> getChildren() {
    return get<List<ChildModel>>(
      EndPoints.childrenParentList,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => ChildModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<ParentEnrollmentResponseModel>> enroll(ParentEnrollmentRequestModel parentEnrollmentRequestModel) {
    print(parentEnrollmentRequestModel.toJson());
    return post<ParentEnrollmentResponseModel>(EndPoints.parentEnrollmentRequest, parentEnrollmentRequestModel.toJson(),
        decoder: ParentEnrollmentResponseModel.fromJson);
  }
}
