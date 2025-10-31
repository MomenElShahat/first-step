import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../booking_details/model/enrollment_details_model.dart';
import '../../../parent/notifications_parent/model/parent_notifications_model.dart';
import 'notifications_api_provider.dart';

abstract class INotificationsRepository {
  Future<Response<List<ParentNotificationsModel>>> getParentNotifications();
  Future<Response<String>> readParentNotifications(String notificationId);
  Future<Response<String>> readAllParentNotifications();
  Future<Response<EnrollmentData>> enrollmentRespond({required String enrollmentId, required String respond});
  Future<Response<EnrollmentData>> updateExistingToPaid({
    required String status,
    required String enrollmentId,
  });
}

class NotificationsRepository extends BaseRepository implements INotificationsRepository {
  NotificationsRepository({required this.provider});
  final INotificationsProvider provider;

  @override
  Future<Response<List<ParentNotificationsModel>>> getParentNotifications() async {
    final apiResponse = await provider.getParentNotifications();
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
  Future<Response<String>> readParentNotifications(String notificationId) async {
    final apiResponse = await provider.readParentNotifications(notificationId);
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
  Future<Response<String>> readAllParentNotifications() async {
    final apiResponse = await provider.readAllParentNotifications();
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
  Future<Response<EnrollmentData>> enrollmentRespond({required String enrollmentId, required String respond}) async {
    final apiResponse = await provider.enrollmentRespond(enrollmentId: enrollmentId, respond: respond);
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
  Future<Response<EnrollmentData>> updateExistingToPaid({
    required String status,
    required String enrollmentId,
  }) async {
    final apiResponse = await provider.updateExistingToPaid(
        status: status, enrollmentId: enrollmentId);
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
