import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../base/api_end_points.dart';
import '../model/enrollment_details_model.dart';

abstract class IBookingDetailsProvider {
  Future<Response<EnrollmentDetailsModel>> getEnrollmentDetailsParent(
      String enrollmentId);

  Future<Response<EnrollmentData>> getEnrollmentDetailsCenter(
      String enrollmentId);


}

class BookingDetailsProvider extends BaseAuthProvider
    implements IBookingDetailsProvider {
  @override
  Future<Response<EnrollmentDetailsModel>> getEnrollmentDetailsParent(
      String enrollmentId) {
    return get<EnrollmentDetailsModel>(
        "${EndPoints.parentEnrollmentsGetOne}/$enrollmentId",
        decoder: EnrollmentDetailsModel.fromJson);
  }

  @override
  Future<Response<EnrollmentData>> getEnrollmentDetailsCenter(
      String enrollmentId) {
    return get<EnrollmentData>(
        "${EndPoints.parentEnrollmentRequest}/$enrollmentId",
        decoder: EnrollmentData.fromJson);
  }
}
