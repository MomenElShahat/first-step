import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../../center/control_panel/models/child_model.dart';
import '../model/parent_enrollment_request_model.dart';
import '../model/parent_enrollment_response_model.dart';
import 'booking_api_provider.dart';

abstract class IBookingRepository {
  Future<Response<List<ChildModel>>> getChildren();
  Future<Response<ParentEnrollmentResponseModel>> enroll(ParentEnrollmentRequestModel parentEnrollmentRequestModel);
}

class BookingRepository extends BaseRepository implements IBookingRepository {
  BookingRepository({required this.provider});

  final IBookingProvider provider;

  @override
  Future<Response<List<ChildModel>>> getChildren() async {
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
  Future<Response<ParentEnrollmentResponseModel>> enroll(ParentEnrollmentRequestModel parentEnrollmentRequestModel) async {
    final apiResponse = await provider.enroll(parentEnrollmentRequestModel);
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
