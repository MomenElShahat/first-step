import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../base/base_repositroy.dart';
import '../model/enrollment_details_model.dart';
import 'booking_details_api_provider.dart';

abstract class IBookingDetailsRepository {
  Future<Response<EnrollmentDetailsModel>> getEnrollmentDetailsParent(
      String enrollmentId);

  Future<Response<EnrollmentData>> getEnrollmentDetailsCenter(
      String enrollmentId);


}

class BookingDetailsRepository extends BaseRepository
    implements IBookingDetailsRepository {
  BookingDetailsRepository({required this.provider});

  final IBookingDetailsProvider provider;

  @override
  Future<Response<EnrollmentDetailsModel>> getEnrollmentDetailsParent(
      String enrollmentId) async {
    final apiResponse = await provider.getEnrollmentDetailsParent(enrollmentId);
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
  Future<Response<EnrollmentData>> getEnrollmentDetailsCenter(
      String enrollmentId) async {
    final apiResponse = await provider.getEnrollmentDetailsCenter(enrollmentId);
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
